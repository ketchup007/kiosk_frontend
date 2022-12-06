import 'dart:developer';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kiosk_flutter/models/container_model.dart';
import 'package:kiosk_flutter/models/pay_methods_model.dart';
import 'package:kiosk_flutter/models/storage_limits_model.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:kiosk_flutter/utils/get_ip.dart';
import 'package:kiosk_flutter/utils/json_parser.dart';

class ApiService{

  //Get Data Section
  Future<List<StorageModel>?> fetchStorage() async {
    try{
      var response = await http.get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.getProducts));

      if(response.statusCode == 200) {
        return compute(JsonParser().parseStorage, response.body);
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    }catch (e) {
      log("In fetchStorage ${e.toString()}");
    }
    return null;
  }

  Future<List<StorageLimitsModel>?> fetchStorageLimits() async {
    try{
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getStorageState));

      if(response.statusCode == 200){
        return compute(JsonParser().parseStorageLimits, response.body);
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    }catch (e) {
      log("In fetchStorageState ${e.toString()}");
    }
    return null;
  }

  Future<int?> createFirstOrder() async {
    try{
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.createOrder));

      if(response.statusCode == 200){
        return jsonDecode(response.body)["id"];
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    }catch (e) {
      log("In createFirstOrder ${e.toString()}");
    }
    return null;
  }

  Future<int?> fetchProductState(String product) async {
    try{
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getProductStorageState(product)));

      if(response.statusCode == 200){
        return jsonDecode(response.body)["quantity"];
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    }catch (e) {
      log("In fetchProductState ${e.toString()}");
    }
    return null;
  }

  Future<int?> fetchOrderNumber(int id) async {
    try{
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.sendSms(id)));

      if(response.statusCode == 200){
        return jsonDecode(response.body)['order_number'];
      }else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchOrderNumber ${e.toString()}");
    }
    return null;
  }

  Future<List<ContainerModel>?> fetchContainer() async {
    try{
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getContainersList));

      if(response.statusCode == 200){
        print(response.body);
        return compute(JsonParser().parseContainers, response.body);
      }else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    }catch (e) {
      log("In fetchContainer ${e.toString()}");
    }
    return null;
  }

  Future<List<PayMethodsModel>?> fetchPaymentMethods() async {
    try{
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.getPaymentMethods)
      );

      if(response.statusCode == 200){
        return compute(JsonParser().parsePayMethods, response.body);
      }else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchPaymentMethods ${e.toString()}");
    }
    return null;
  }

  Future<String?> fetchPaymentStatus(int id) async{
    try{
      var response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.paymentNotifyGet(id))
      );

      if(response.statusCode == 200){
        return jsonDecode(response.body)["status"];
      }else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchPaymentStatus ${e.toString()}");
    }
    return null;
  }

  // get loop
  Future<String?> checkPaymentStatus(int id) async{
    var status = await fetchPaymentStatus(id);

    if(status != "COMPLETED"){
      while(status != "COMPLETED"){
        status = await fetchPaymentStatus(id);
      }
    }

    return status;
  }


  //Post Data Section
  Future<int?> changeOrderProduct(int id, String orderName, int value) async {
    try{
      var response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.updateOrder),
        headers: <String, String>{'Content-Type' : 'application/json'},
        body: jsonEncode(<String, String>{
          'id': id.toString(),
          'order_name': orderName,
          'value': value.toString()
        }));

      if (response.statusCode == 200){
        return jsonDecode(response.body)['accepted'];
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    }catch (e) {
      log("In changeOrderProduct ${e.toString()}");
    }
    return null;
  }

  Future<int?> changeOrderName(int id, String value) async {
    try{
      var response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.updateOrder),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'id': id.toString(),
          'order_name': 'client_name',
          'value': value
        }));

      if(response.statusCode == 200) {
        return jsonDecode(response.body)['accepted'];
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    }catch (e) {
      log("In changeOrderName ${e.toString()}");
    }
    return null;
  }

  Future<int?> setClientNumber(int id, String number, bool promoPermission) async {
    try{
      var response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.setClientNumber),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "id": id.toString(),
          "client_number": number,
          "promo_permission": promoPermission.toString()
        }));

      if (response.statusCode == 200){
        return jsonDecode(response.body)['accepted'];
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    }catch (e) {
      log("In setClientNumber ${e.toString()}");
    }
    return null;
  }

  Future<String?> paymentBlikOrder(int id, double totalAmount ,String blikCode) async {
    try{
      final amount = totalAmount * 100;
      print('amount ${amount.toStringAsFixed(0)}');
      var response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.payBlik),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "id": id.toString(),
          "customerIp": await gettingIP(),
          "totalAmount": amount.toStringAsFixed(0),
          "blikCode": blikCode,
        }));

      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
        return response.body;
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }

    } catch (e) {
      log("In paymentBlikOrder ${e.toString()}");
    }
    return null;
  }




















}