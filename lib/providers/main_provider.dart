import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/order_model.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/utils/fetch_json.dart';
import 'package:kiosk_flutter/utils/post_data.dart';
import 'package:http/http.dart' as http;
import 'package:kiosk_flutter/utils/payment_sockets.dart';
import 'package:kiosk_flutter/utils/read_json.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<StorageModel> storageBeg = <StorageModel>[];

  Map<String, int> limits = HashMap();

  bool loading = false;
  bool isDone = false;
  bool inPayment = false;
  bool popupDone = false;

  String phoneNumber = "";
  String phoneNumberToken = "";
  String loginToken ="";

  double sum = 0.0;
  OrderModel order = OrderModel.resetModel();
  String language = 'pl';
  List<CountryModel> countryList = [];

  testShare() async {
    print("in test share");
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('test', 'testadasad');

    print(prefs.getString('test'));
  }

  getStorageData() async {
    if(loading != true && isDone != true) {
      loading = true;
      storage = (await ApiService(token: loginToken).fetchStorage())!;
      //storage = await fetchStorage();
      initMap();
      await ApiService(token: loginToken).fetchStorageLimits().then( (data) {
        for(int i = 0; i < data!.length; i++){
         limits[data[i].orderName] = data[i].quantity;
        }});
      /*
      await fetchStorageLimits().then( (data) {
        for(int i = 0; i < data.length; i++){
          limits[data[i].orderName] = data[i].quantity;
        }});

       */
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

  begStorageSetup(){
    storageBeg.clear();
    for(int i= 0; i<storagePizza.length; i++){
      if(storagePizza[i].number> 0) {
        break;
      }else if(i == storagePizza.length-1){
        storageBeg.add(storagePizza.first);
      }
    }

    for(int i= 0; i<storageDrinks.length; i++){
      if(storageDrinks[i].number> 0) {
        break;
      }else if(i == storageDrinks.length-1){
        storageBeg.add(storageDrinks.first);
      }
    }

    for(int i= 0; i<storageBox.length; i++){
      if(storageBox[i].number> 0) {
        break;
      }else if(i == storageBox.length-1){
        storageBeg.add(storageBox.first);
      }
    }

    for(int i= 0; i<storageSauce.length; i++){
      if(storageSauce[i].number> 0) {
        break;
      }else if(i == storageSauce.length-1){
        storageBeg.add(storageSauce.first);
      }
    }

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
    order.id = (await ApiService(token: loginToken).createFirstOrder())!;
    //order.id = await createFirstOrder();
    ApiService(token: loginToken).changeOrderProduct(order.id, orderName, value);
    //changeOrderProduct(order.id, orderName, value);
  }

  changeOrder(String orderName, int value) async {
    ApiService(token: loginToken).changeOrderProduct(order.id, orderName, value);
    //changeOrderProduct(order.id, orderName, value);
  }

  changeOrderStatus(int value) async{
    ApiService(token: loginToken).changeOrderProduct(order.id, "status", value);
    //changeOrderProduct(order.id, "status", value);
  }

  changOrderName(String value) async {
    ApiService(token: loginToken).changeOrderName(order.id, value);
    //changeOrderName(order.id, value);
  }

  setOrderClientNumber(String number, bool promoPermission) async {
    ApiService(token: loginToken).setClientNumber(order.id, number, promoPermission);
    //setClientNumber(order.id, number, promoPermission);
  }

  Future<int> getOrderNumber() async{
    print("from privider du du du du");
    return (await ApiService(token: loginToken).fetchOrderNumber(order.id))!;
    //return await fetchOrderNumber(order.id);
  }

  Future<int> testRoute() async{
    print("in blik test");
    return await getOrderNumber();
  }

  getSum() {
    sum = 0.0;
    for(var i= 0; i<storage.length; i++){
      sum = sum + storage[i].price * storage[i].number;
    }
    notifyListeners();
  }

  getLimit(String product, int number){
    ApiService(token: loginToken).fetchProductState(product).then((data){
      limits[product] = data! + number;
    });
    /*
    fetchProductState(product).then((data){
      limits[product] = data + number;
    });
     */
  }

  getLimits(){
    //print("tick");
    ApiService(token: loginToken).fetchStorageLimits().then( (data) {
      for(int i = 0; i < data!.length; i++){
        limits[data[i].orderName] = data[i].quantity;
      }});
    /*
    fetchStorageLimits().then( (data) {
      for(int i = 0; i < data.length; i++){
        limits[data[i].orderName] = data[i].quantity;
      }});

     */
  }


  orderCancel() {
    changeOrder("status", 5);
    order = OrderModel.resetModel();
    for(int i = 0; i < storage.length; i++){
      storage[i].number = 0;
    }
    storageBeg.clear();
    popupDone = false;
    getSum();
  }

  orderFinish() {
    order = OrderModel.resetModel();
    for(int i = 0; i < storage.length; i++){
      storage[i].number = 0;
    }
    storageBeg.clear();
    popupDone = false;
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

    notifyListeners();
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