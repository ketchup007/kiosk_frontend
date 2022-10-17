import 'dart:convert';

import 'package:http/http.dart' as http;

Future<int> changeOrderProduct(int id, String orderName, int value) async {
  final response = await http.post(
      Uri.parse('http://10.3.15.98:8000/api/orders/updateOrder'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'order_name': orderName,
        'value': value.toString(),
      }));
  print('Change Product Order Status Code: ${response.statusCode}');
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['accepted'];
  } else {
    throw Exception('failed to post');
  }
}

Future<int> changeOrderName(int id, String value) async {
  final response = await http.post(
      Uri.parse('http://10.3.15.98:8000/api/orders/updateOrder'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'order_name': "client_name",
        'value': value,
      }));
  print('Change Product Order Status Code: ${response.statusCode}');
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['accepted'];
  } else {
    throw Exception('failed to post');
  }
}

Future<int> setClientNumber(int id, String number, bool promoPermission) async {
  final response = await http.post(
    Uri.parse('http://10.3.15.98:8000/api/orders/setClientNumber'),
    headers: <String, String>{"Content-Type":"application/json"},
    body: jsonEncode(<String, String>{
      "id": id.toString(),
      "client_number": number,
      "promo_permission": promoPermission.toString()}));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['accepted'];
  } else {
    throw Exception('failed to post');
  }
}
