import 'dart:convert';
import 'package:kiosk_flutter/models/container_model.dart';
import 'package:kiosk_flutter/models/pay_methods_model.dart';
import 'package:kiosk_flutter/models/storage_limits_model.dart';
import 'package:kiosk_flutter/models/storage_model.dart';

class JsonParser {
  List<StorageModel> parseStorage(String json) => jsonDecode(json)
      .cast<Map<String, dynamic>>()
      .map<StorageModel>((x) => StorageModel.fromJson(x))
      .toList();

  List<StorageLimitsModel> parseStorageLimits(String json) => jsonDecode(json)
      .cast<Map<String, dynamic>>()
      .map<StorageLimitsModel>((x) => StorageLimitsModel.fromJson(x))
      .toList();

  List<ContainerModel> parseContainers(String json) => jsonDecode(json)
      .cast<Map<String, dynamic>>()
      .map<ContainerModel>((x) => ContainerModel.fromJson(x))
      .toList();

  List<PayMethodsModel> parsePayMethods(String json) {
    print(jsonDecode(json)["pay_methods"]["payByLinks"].toString());
    final int id = jsonDecode(json)["id"] as int;

    return jsonDecode(json)["pay_methods"]["payByLinks"]
        .cast<Map<String, dynamic>>()
        .map<PayMethodsModel>((x) => PayMethodsModel.fromJson(x, id))
        .toList();
  }
}
