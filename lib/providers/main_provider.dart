import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/order_model.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/utils/fetch_json.dart';
import 'package:kiosk_flutter/utils/post_data.dart';
import 'package:http/http.dart' as http;
import 'package:kiosk_flutter/utils/payment_sockets.dart';
import 'package:kiosk_flutter/utils/read_json.dart';

import '../models/country_model.dart';

class MainProvider extends ChangeNotifier {
  List<StorageModel> storage = <StorageModel>[];
  Payment payment = Payment();

  List<StorageModel> storagePizza = <StorageModel>[];
  List<StorageModel> storageDrinks = <StorageModel>[];
  List<StorageModel> storageBox = <StorageModel>[];
  List<StorageModel> storageSauce = <StorageModel>[];
  List<StorageModel> storageCurrent = <StorageModel>[];
  List<StorageModel> storageOrders = <StorageModel>[];

  Map<String, int> limits = HashMap();

  bool loading = false;
  bool isDone = false;
  bool inPayment = false;
  double sum = 0.0;
  OrderModel order = OrderModel.resetModel();
  String language = 'pl';
  List<CountryModel> countryList = [];

  getStorageData() async {
    if(loading != true && isDone != true) {
      loading = true;
      storage = await fetchStorage();
      initMap();
      await fetchStorageLimits().then( (data) {
        for(int i = 0; i < data.length; i++){
          limits[data[i].orderName] = data[i].quantity;
        }});
      breakStorage();
      storageCurrent = storagePizza;
      loading = false;
      isDone = true;

      notifyListeners();
    }
  }

  initMap(){
    for(int i = 0; i< storage.length; i++){
      limits.addAll({storage[i].orderName: storage[i].quantity});
    }
  }

  changeToPizza(){
    storageCurrent = storagePizza;
    notifyListeners();
  }

  changeToDrinks(){
    storageCurrent = storageDrinks;
    notifyListeners();
  }

  changeToBox(){
    storageCurrent = storageBox;
    notifyListeners();
  }

  changeToSauces(){
    storageCurrent = storageSauce;
    notifyListeners();
  }

  breakStorage(){
    for(int i= 0; i<storage.length; i++){
      switch(storage[i].type){
        case 1:{
          storagePizza.add(storage[i]);
        }
        break;

        case 2:{
          storageDrinks.add(storage[i]);
        }
        break;

        case 3:{
          storageSauce.add(storage[i]);
        }
        break;

        case 4:{
          storageBox.add(storage[i]);
        }
        break;
      }}}

  getFirstOrder(String orderName, int value) async {
    order.id = await createFirstOrder();
    changeOrderProduct(order.id, orderName, value);
  }

  changeOrder(String orderName, int value) async {
    changeOrderProduct(order.id, orderName, value);
  }

  changeOrderStatus(int value) async{
    changeOrderProduct(order.id, "status", value);
  }

  changOrderName(String value) async {
    changeOrderName(order.id, value);
  }

  setOrderClientNumber(String number, bool promoPermission) async {
    setClientNumber(order.id, number, promoPermission);
  }

  Future<int> getOrderNumber() async{
    return await fetchOrderNumber(order.id);
  }

  getSum() {
    sum = 0.0;
    for(var i= 0; i<storage.length; i++){
      sum = sum + storage[i].price * storage[i].number;
    }
    notifyListeners();
  }

  getLimit(String product, int number){
    fetchProductState(product).then((data){
      limits[product] = data + number;
    });
  }

  getLimits(){
    print("tick");
    fetchStorageLimits().then( (data) {
      for(int i = 0; i < data.length; i++){
        limits[data[i].orderName] = data[i].quantity;
      }});
  }


  orderCancel() {
    changeOrder("status", 5);
    order = OrderModel.resetModel();
    for(int i = 0; i < storage.length; i++){
      storage[i].number = 0;
    }
    getSum();
  }

  orderFinish() {
    order = OrderModel.resetModel();
    for(int i = 0; i < storage.length; i++){
      storage[i].number = 0;
    }
    getSum();
  }

  getOrderList() {
    if(storageOrders.isNotEmpty){
      storageOrders.removeRange(0, storageOrders.length);
    }

    for(int i = 0; i < storage.length; i++){
      if(storage[i].number > 0){
        storageOrders.add(storage[i]);
      }
    }
  }

  changeLanguage(context) {
    language = Localizations.localeOf(context).toString();

    notifyListeners();
  }

  getCountryCodes() async {
    if(countryList.isEmpty){
      countryList = await readCountries();
      notifyListeners();
    }
  }

}