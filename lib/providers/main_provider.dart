import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/card_token_model.dart';
import 'package:kiosk_flutter/models/country_model.dart';
import 'package:kiosk_flutter/models/menus/munchie_product.dart';
import 'package:kiosk_flutter/models/menus/product_type.dart';
import 'package:kiosk_flutter/models/orders/order.dart';
import 'package:kiosk_flutter/models/orders/order_product.dart';
import 'package:kiosk_flutter/models/orders/order_status.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/utils/payment_sockets.dart';
import 'package:kiosk_flutter/utils/read_json.dart';
import 'package:kiosk_flutter/utils/supabase/database_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MainProvider extends ChangeNotifier {
  List<MunchieProduct> products = [];

  Payment payment = Payment();
  final databaseService = DatabaseService();

  List<MunchieProduct> storagePizza = [];
  List<MunchieProduct> storageDrinks = [];
  List<MunchieProduct> storageBox = [];
  List<MunchieProduct> storageSauce = [];
  List<MunchieProduct> storageCurrent = [];
  List<MunchieProduct> storageOrders = [];
  List<MunchieProduct> storageBeg = [];

  List<OrderProduct> orderProducts = [];

  List<CardPaymentToken> cardTokens = <CardPaymentToken>[];

  Map<String, int> limits = HashMap();

  bool loading = false;
  bool isDone = false;
  bool inPayment = false;
  bool popupDone = false;

  String phoneNumber = "";
  String phoneNumberToken = "";
  String loginToken = "";

  double sumTemp = 0.1;
  double sum = 0.0;
  Order order = Order.empty();
  String languageCode = 'pl';
  List<CountryModel> countryList = [];

  String containerDb = 'default';
  int timeToWait = 6;

  updateTimeToWait() async {
    int? newTime = await ApiService(token: loginToken).getTimeEst();

    if (newTime != null) {
      timeToWait = newTime;
    }
  }

  saveCardTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String json = jsonEncode(CardPaymentToken.toJsonList(cardTokens));

    print(json);
    //json = "";
    final result = await prefs.setString("card_tokens", json);
    print("saved? $result");
  }

  loadCardTokens() async {
    print("load 1");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("load 2");
    String? json = prefs.getString("card_tokens");
    print("load 3");
    //print(json);
    //print(jsonDecode(json));
    //print(jsonDecode(jsonDecode(json)));
    //final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
    print("load 4");
    if (json != null && json != "") {
      //  final parsed = jsonDecode(jsonDecode(json)).cast<Map<String, dynamic>>();
      //debugPrint(parsed);
      print("load 5");
      cardTokens = jsonDecode(jsonDecode(json)).cast<Map<String, dynamic>>().map<CardPaymentToken>((json) => CardPaymentToken.fromJson(json)).toList();
      print("load 6");
    }

//    print(cardTokens[0].brandImageUrl);
  }

  getloginToken() async {
    String? json = await ApiService(token: loginToken).login(phoneNumber, phoneNumberToken);
    if (json != null) {
      loginToken = jsonDecode(json)['token'];
    }
  }

  testShare() async {
    print("in test share");
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('test', 'testadasad');

    print(prefs.getString('test'));
  }

  getStorageData(context) async {
    if (loading != true && isDone != true) {
      loading = true;
      products = await databaseService.getProduct(languageId: languageCode);
      await databaseService.getStorageLimits().then((storageStates) {
        for (final storageState in storageStates) {
          limits[storageState.productId] = storageState.amount;
        }
      });
      breakStorage();
      storageCurrent = storagePizza;
      loading = false;
      isDone = true;

      notifyListeners();
    }
  }

  changeToPizza() {
    storageCurrent = storagePizza;
    notifyListeners();
  }

  changeToDrinks() {
    storageCurrent = storageDrinks;
    notifyListeners();
  }

  changeToBox() {
    storageCurrent = storageBox;
    notifyListeners();
  }

  changeToSauces() {
    storageCurrent = storageSauce;
    notifyListeners();
  }

  begStorageSetup() {
    storageBeg.clear();
    for (int i = 0; i < storagePizza.length; i++) {
      if (getProductInOrderCount(storagePizza[i].productId) > 0) {
        break;
      } else if (i == storagePizza.length - 1) {
        storageBeg.add(storagePizza.first);
      }
    }

    for (int i = 0; i < storageDrinks.length; i++) {
      if (getProductInOrderCount(storageDrinks[i].productId) > 0) {
        break;
      } else if (i == storageDrinks.length - 1) {
        storageBeg.add(storageDrinks.first);
      }
    }

    for (int i = 0; i < storageBox.length; i++) {
      if (getProductInOrderCount(storageBox[i].productId) > 0) {
        break;
      } else if (i == storageBox.length - 1) {
        storageBeg.add(storageBox.first);
      }
    }

    for (int i = 0; i < storageSauce.length; i++) {
      if (getProductInOrderCount(storageSauce[i].productId) > 0) {
        break;
      } else if (i == storageSauce.length - 1) {
        storageBeg.add(storageSauce.first);
      }
    }
  }

  void breakStorage() {
    for (final product in products) {
      switch (product.type) {
        case ProductType.pizza:
          storagePizza.add(product);
          break;
        case ProductType.drink:
          storageDrinks.add(product);
          break;
        case ProductType.box:
          storageSauce.add(product);
          break;
        case ProductType.sauce:
          storageBox.add(product);
          break;
      }
    }
  }

  Future<void> createOrder(String orderName, int value) async {
    await databaseService.createOrder(order);
  }

  // TODO: co zrobic z storageState? powinna byc tu aktualizacja
  void addProductToOrder(String productId) {
    final nextProduct = OrderProduct(
      id: const Uuid().v4(),
      munchieId: AppConfig.instance.munchieId,
      orderId: order.id,
      productId: productId,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    orderProducts.add(nextProduct);
    refreshSum();
  }

  // TODO: co zrobic z storageState? powinna byc tu aktualizacja
  void removeProductToOrder(String productId) {
    final unwantedProductIndex = orderProducts.lastIndexWhere((element) => element.productId == productId);
    orderProducts.removeAt(unwantedProductIndex);
    refreshSum();
  }

  int getProductInOrderCount(String productId) {
    return orderProducts.where((element) => element.productId == productId).length;
  }

  Future<void> updateOrderStatus(OrderStatus status) async {
    await databaseService.updateOrderStatus(order.id, status);
  }

  updateOrderClientPhoneNumber(String? phoneNumber) async {
    await databaseService.updateOrderClientPhoneNumber(order.id, phoneNumber);
  }

  Future<int> getOrderNumber() async {
    return await databaseService.updateOrderNumber(order.id);
  }

  Future<int> testRoute() async {
    print("in blik test");
    return await getOrderNumber();
  }

  refreshSum() {
    sum = 0.0;
    for (var i = 0; i < products.length; i++) {
      sum = sum + products[i].price * getProductInOrderCount(products[i].productId);
    }
    notifyListeners();
  }

  refreshLimit(String product) {
    databaseService.getStorageStateProduct(product).then((data) {
      limits[product] = data;
    });
  }

  getLimits() {
    databaseService.getStorageLimits().then((data) {
      for (int i = 0; i < data.length; i++) {
        limits[data[i].id] = data[i].amount;
      }
    });
  }

  orderCancel() {
    print("in order cancle");
    updateOrderStatus(OrderStatus.canceled);
    order = Order.empty();
    orderProducts.clear();
    storageBeg.clear();
    popupDone = false;
    refreshSum();
  }

  Future<void> orderFinish() async {
    await databaseService.createOrderProducts(orderProducts);

    order = Order.empty();
    orderProducts.clear();
    storageBeg.clear();
    popupDone = false;
    refreshSum();
  }

  getOrderList() {
    if (storageOrders.isNotEmpty) {
      storageOrders.removeRange(0, storageOrders.length);
    }

    for (int i = 0; i < products.length; i++) {
      int productCount = getProductInOrderCount(products[i].productId);
      if (productCount > 0) {
        storageOrders.add(products[i]);
      }
    }

    notifyListeners();
  }

  changeLanguage(context) {
    languageCode = Localizations.localeOf(context).toString();

    notifyListeners();
  }

  getCountryCodes() async {
    if (countryList.isEmpty) {
      countryList = await readCountries();
      notifyListeners();
    }
  }
}
