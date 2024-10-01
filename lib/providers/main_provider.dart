import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/config.dart';
import 'package:kiosk_flutter/models/backend_models.dart';
import 'package:kiosk_flutter/models/card_token_model.dart';
import 'package:kiosk_flutter/models/menu_item_with_description.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/utils/payment_sockets.dart';
import 'package:kiosk_flutter/utils/supabase/database_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class MainProvider extends ChangeNotifier {
  List<MenuItemWithDescription> menuItems = [];

  Payment payment = Payment();
  final databaseService = DatabaseService();

  List<MenuItemWithDescription> storagePizza = [];
  List<MenuItemWithDescription> storageDrinks = [];
  List<MenuItemWithDescription> storageBox = [];
  List<MenuItemWithDescription> storageSauce = [];
  List<MenuItemWithDescription> storageCurrent = [];
  List<MenuItemWithDescription> storageOrders = [];
  List<MenuItemWithDescription> storageBeg = [];

  List<ApsOrderItem> orderItems = [];

  List<CardPaymentToken> cardTokens = <CardPaymentToken>[];

  Map<int, int> limits = HashMap();

  bool loading = false;
  bool isDone = false;
  bool popupDone = false;

  String phoneNumber = "";
  String phoneNumberToken = "";
  String loginToken = "";

  double sumTemp = 0.1;
  double sum = 0.0;

  String containerDb = 'default';
  int timeToWait = 6;

  bool _inPayment = false;

  set inPayment(bool value) {
    _inPayment = value;
    notifyListeners();
  }

  bool get inPayment => _inPayment;

  Future<void> updateTimeToWait() async {
    int? newTime = await ApiService(token: loginToken).getTimeEst();

    if (newTime != null) {
      timeToWait = newTime;
    }
  }

  Future<void> saveCardTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String json = jsonEncode(CardPaymentToken.toJsonList(cardTokens));

    print(json);
    //json = "";
    final result = await prefs.setString("card_tokens", json);
    print("saved? $result");
  }

  Future<void> loadCardTokens() async {
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

  Future<void> getloginToken() async {
    String? json = await ApiService(token: loginToken).login(phoneNumber, phoneNumberToken);
    if (json != null) {
      loginToken = jsonDecode(json)['token'];
    }
  }

  Future<void> getStorageData() async {
    if (loading != true && isDone != true) {
      loading = true;
      // products = await databaseService.getAllItemDescriptions();
      menuItems = await databaseService.menuItemsWithDescriptionsStream(apsId: AppConfig.instance.apsId).first;

      refreshLimit();

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
      if (getQuantityOfItemInOrder(storagePizza[i].itemDescription.id) > 0) {
        break;
      } else if (i == storagePizza.length - 1) {
        storageBeg.add(storagePizza.first);
      }
    }

    for (int i = 0; i < storageDrinks.length; i++) {
      if (getQuantityOfItemInOrder(storageDrinks[i].itemDescription.id) > 0) {
        break;
      } else if (i == storageDrinks.length - 1) {
        storageBeg.add(storageDrinks.first);
      }
    }

    for (int i = 0; i < storageBox.length; i++) {
      if (getQuantityOfItemInOrder(storageBox[i].itemDescription.id) > 0) {
        break;
      } else if (i == storageBox.length - 1) {
        storageBeg.add(storageBox.first);
      }
    }

    for (int i = 0; i < storageSauce.length; i++) {
      if (getQuantityOfItemInOrder(storageSauce[i].itemDescription.id) > 0) {
        break;
      } else if (i == storageSauce.length - 1) {
        storageBeg.add(storageSauce.first);
      }
    }
  }

  void breakStorage() {
    for (final menuItem in menuItems) {
      switch (menuItem.itemDescription.category) {
        case ItemCategory.snack:
          storagePizza.add(menuItem);
          break;
        case ItemCategory.drink || ItemCategory.coffee:
          storageDrinks.add(menuItem);
          break;
        case ItemCategory.sauce:
          storageSauce.add(menuItem);
          break;
        case ItemCategory.takeAwayBox:
          storageBox.add(menuItem);
          break;
        case ItemCategory.paperTray:
          break;
        case ItemCategory.cup:
          break;
        case ItemCategory.sugar:
          break;
      }
    }
  }

  // Future<void> createOrder() async {
  //   order = ApsOrder(
  //     apsId: AppConfig.instance.apsId,
  //     origin: OriginType.kiosk,
  //     status: OrderStatus.duringOrdering,
  //     estimatedTime: 0,
  //     kdsOrderNumber: null,
  //     pickupNumber: null,
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //   );

  //   order = await databaseService.createOrder(order!);
  // }

  void addProductToOrder(int itemId) {
    final nextProduct = ApsOrderItem(
      apsId: AppConfig.instance.apsId,
      apsOrderId: order!.id!,
      itemId: itemId,
      status: ItemStatus.reserved,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    orderItems.add(nextProduct);
    refreshSum();
  }

  // TODO: co zrobic z storageState? powinna byc tu aktualizacja
  void removeProductToOrder(int? itemId) {
    final unwantedProductIndex = orderItems.lastIndexWhere((element) => element.itemId == itemId);
    orderItems.removeAt(unwantedProductIndex);
    refreshSum();
  }

  int getQuantityOfItemInOrder(int? itemId) {
    return orderItems.where((element) => element.itemId == itemId).length;
  }

  Future<void> updateOrderStatus(OrderStatus status) async {
    if (order != null && order?.id != null) {
      await databaseService.updateOrderStatus(order!.id!, status);
    }
  }

  updateOrderClientPhoneNumber(String? phoneNumber) async {
    if (order != null && order?.id != null) {
      await databaseService.updateOrderClientPhoneNumber(order!.id!, phoneNumber);
    }
  }

  Future<int> getOrderNumber() async {
    if (order != null && order?.id != null) {
      return await databaseService.updateOrderNumber(orderId: order!.id!);
    } else {
      return -1;
    }
  }

  Future<int> testRoute() async {
    print("in blik test");
    return await getOrderNumber();
  }

  refreshSum() {
    sum = 0.0;
    for (var i = 0; i < menuItems.length; i++) {
      sum = sum + menuItems[i].menuItemPrice.price * getQuantityOfItemInOrder(menuItems[i].itemDescription.id);
    }
    notifyListeners();
  }

  Future<void> refreshLimit() async {
    final itemIds = menuItems.map((menuItem) => menuItem.itemDescription.id).whereNotNull().toList();
    await databaseService.getAvailableItems(itemIds: itemIds).then((availableItems) {
      for (final availableItem in availableItems) {
        limits[availableItem.itemId] = availableItem.availableQuantity;
      }
    });
    notifyListeners();
  }

  Future<void> orderCancel() async {
    print("in order cancle");
    await updateOrderStatus(OrderStatus.canceled);
    order = null;
    orderItems.clear();
    storageBeg.clear();
    popupDone = false;
    refreshSum();
  }

  Future<void> orderFinish() async {
    await databaseService.createOrderItems(orderItems);

    order = null;
    orderItems.clear();
    storageBeg.clear();
    popupDone = false;
    refreshSum();
  }

  getOrderList() {
    if (storageOrders.isNotEmpty) {
      storageOrders.removeRange(0, storageOrders.length);
    }

    for (int i = 0; i < menuItems.length; i++) {
      int itemQuantity = getQuantityOfItemInOrder(menuItems[i].itemDescription.id);
      if (itemQuantity > 0) {
        storageOrders.add(menuItems[i]);
      }
    }

    notifyListeners();
  }
}
