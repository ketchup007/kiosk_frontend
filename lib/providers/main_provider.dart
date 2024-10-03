import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/models/card_token_model.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  List<CardPaymentToken> cardTokens = <CardPaymentToken>[];

  bool loading = false;
  bool isDone = false;

  String phoneNumber = "";
  String phoneNumberToken = "";
  String loginToken = "";

  String containerDb = 'default';
  int timeToWait = 6;

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

  Future<int> testRoute() async {
    print("in blik test");
    return Random().nextInt(99) + 1;
    // return await getOrderNumber();
  }
}
