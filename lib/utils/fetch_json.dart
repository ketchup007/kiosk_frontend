import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kiosk_flutter/models/container_model.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/models/order_model.dart';
import 'package:kiosk_flutter/utils/parse_json.dart';
import 'package:kiosk_flutter/models/storage_limits_model.dart';

Future<List<StorageModel>> fetchStorage() async {
  final response = await http
      .get(Uri.parse('http://10.3.15.98:8000/api/storage/getProducts'));

  if (response.statusCode == 200) {
    return compute(parseStorage, response.body);
  } else {
    throw Exception('failed to fetch');
  }
}

Future<List<StorageLimitsModel>> fetchStorageLimits() async {
  final response = await http
      .get(Uri.parse('http://10.3.15.98:8000/api/storage/getStorageState'));

  if (response.statusCode == 200) {
    return compute(parseStorageLimits, response.body);
  } else {
    throw Exception('failed to fetch');
  }
}

Future<int> createFirstOrder() async {
  final response = await http
      .get(Uri.parse('http://10.3.15.98:8000/api/orders/createOrder'));

  if (response.statusCode == 200) {
    return parseFirstOrder(response.body);
  } else {
    throw Exception('failed to fetch');
  }
}

Future<int> fetchProductState(String product) async {
  final response = await http.get(Uri.parse(
      'http://10.3.15.98:8000/api/storage/getProductStorageState/$product'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['quantity'];
  } else {
    throw Exception('Failed to fetch');
  }
}

Future<int> fetchOrderNumber(int id) async {
  final response = await http.get(Uri.parse(
      'http://10.3.15.98:8000/api/orders/sendSms/$id'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['order_number'];
  } else {
    throw Exception('Failed to fetch');
  }
}

Future<List<ContainerModel>> fetchContainer() async {
  final response = await http.get(Uri.parse(
    'http://10.3.15.98:8000/api/containers/getList'));

  if(response.statusCode == 200){
    return compute(parseContainers, response.body);
  } else {
    throw Exception('Failed to fetch');
  }
}

