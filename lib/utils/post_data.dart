import 'dart:convert';

import 'package:http/http.dart' as http;

Future<int> changeOrderProduct(int id, String order_name, int value) async {
  final response = await http.post(
      Uri.parse('http://10.3.15.98:8000/api/orders/updateOrder'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'order_name': order_name,
        'value': value.toString(),
      }));
  print('Change Product Order Status Code: ${response.statusCode}');
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['accepted'];
  } else {
    throw Exception('failed to post');
  }
}
