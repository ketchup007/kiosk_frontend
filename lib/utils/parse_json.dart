import 'dart:convert';

import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/models/order_model.dart';

List<StorageModel> parseStorage(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<StorageModel>((json) => StorageModel.fromJson(json))
      .toList();
}

int parseFirstOrder(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return parsed['id'];
}
