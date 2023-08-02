import 'dart:developer';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kiosk_flutter/models/container_model.dart';
import 'package:kiosk_flutter/models/pay_methods_model.dart';
import 'package:kiosk_flutter/models/storage_limits_model.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/utils/api/api_constants.dart';
import 'package:kiosk_flutter/utils/get_ip.dart';
import 'package:kiosk_flutter/utils/json_parser.dart';

class ApiService {
  String token;
  http.Client client = http.Client();

  ApiService({
    required this.token,
  });

  Future<int?> getTimeEst() async {
    try {
      // print("in Api Call time est");
      var response = await client
          .get(Uri.parse(ApiConstants.baseUrl + "/api/orders/getOrderTime"), headers: {'Authorization': 'Bearer $token'});

      // print("in Api Call 2 time est${response.statusCode}");

      if (response.statusCode == 200) {
        // print("in Api Call 3 ${response.body}");
        String? output = response.body;
        return jsonDecode(response.body)["time"];
      }
    } catch (e) {
      log("${e.toString()}");
    }
  }


  Future<String?> getFromLink(String link, http.Client client) async {
    try {
      print("in Api Call $link");
      var response = await client
          .get(Uri.parse(link), headers: {'Authorization': 'Bearer $token'});

      print("in Api Call 2 $link, ${response.statusCode}");

      if (response.statusCode == 200) {
        print("in Api Call 3 ${response.body}");
        String? output = response.body;
        return output;
      } else {
        return "error statusCode ${response.statusCode}";
        //throw Exception('StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("${e.toString()}");
      return "error in ${e.toString()}";
    }

    return "error somewhat";
  }

  //Get Data Section
  Future<List<StorageModel>?> fetchStorage(http.Client client, {String db = 'default', String url = ApiConstants.baseUrl}) async {
    try {
      var response = await client.post(
          Uri.parse(url + ApiConstants.getProducts),
          headers: {'Authorization': 'Bearer $token'},
          body: jsonEncode(<String, String>{'db': db.toString()}));

      if (response.statusCode == 200) {
        // print(response.body);
        return compute(JsonParser().parseStorage, response.body);
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchStorage ${e.toString()}");
    }
    return null;
  }

  Future<List<StorageLimitsModel>?> fetchStorageLimits(http.Client client) async {
    try {
      var response = await client.get(
          Uri.parse(ApiConstants.localUrl + ApiConstants.getStorageState),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return compute(JsonParser().parseStorageLimits, response.body);
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchStorageState ${e.toString()}");
    }
    return null;
  }

  Future<int?> createFirstOrder(http.Client client) async {
    try {
      var response = await client.post(
          Uri.parse(ApiConstants.localUrl + ApiConstants.order),
          // headers: {'Authorization': 'Bearer $token'},
          );

      print(response.body);
      if (response.statusCode == 201) {
        return jsonDecode(response.body)["id"];
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In createFirstOrder ${e.toString()}");
    }
    return null;
  }

  Future<int?> fetchProductState(http.Client client, String product,
      ) async {
    try {
      var response = await client.get(
          Uri.parse(ApiConstants.localUrl +
              ApiConstants.getProductStorageState(product)),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)["quantity"];
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchProductState ${e.toString()}");
    }
    return null;
  }

  Future<int?> fetchOrderNumber(http.Client client, int id) async {
    print("sms dudu dudy");
    try {
      var response = await client.patch(
          Uri.parse(ApiConstants.localUrl + ApiConstants.setOrderNumber(id)),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['order_number'];
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchOrderNumber ${e.toString()}");
    }
    return null;
  }

  Future<List<ContainerModel>?> fetchContainer() async {
    try {
      var response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getContainersList),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        // print(response.body);
        return compute(JsonParser().parseContainers, response.body);
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchContainer ${e.toString()}");
    }
    return null;
  }

  Future<int?> startPaymentSession() async {
    try {
      var response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getPaymentCredentials),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        return jsonDecode(response.body)["id"];
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In startPaymentSession ${e.toString()}");
    }
    return null;
  }

  Future<int?> getPaymentAuth() async {
    try {
      var response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.payAuth),
          headers: {'Authorization': 'Bearer $token'});

      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["id"];
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In getPaymentAuth ${e.toString()}");
    }
    return null;
  }

  Future<String?> fetchTransactionData(int id) async {
    try {
      var response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.transactionStatus(id)),
          headers: {'Authorization': 'Bearer $token'});

      // debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchTransactionData ${e.toString()}");
    }
    return null;
  }

  Future<String?> fetchOrderData(int id) async {
    try {
      var response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.orderStatus(id)),
          headers: {'Authorization': 'Bearer $token'});

      // debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchOrderData ${e.toString()}");
    }
    return null;
  }

  Future<List<PayMethodsModel>?> fetchPaymentMethods2(int id) async {
    try {
      var response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.payMethodsAuth(id)),
          headers: {'Authorization': 'Bearer $token'});

      debugPrint(response.body);
      if (response.statusCode == 200) {
        return compute(JsonParser().parsePayMethods, response.body);
      }

      throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
    } catch (e) {
      log("In fetchPaymentMethods ${e.toString()}");
    }
    return null;
  }

  Future<List<PayMethodsModel>?> fetchPaymentMethods() async {
    try {
      var response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getPaymentMethods),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        print(response.body);
        print(response.body);
        return compute(JsonParser().parsePayMethods, response.body);
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchPaymentMethods ${e.toString()}");
    }
    return null;
  }

  Future<String?> fetchPaymentStatus(int id) async {
    try {
      var response = await http.get(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.paymentNotifyGet(id)),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        return jsonDecode(response.body)["status"];
      } else {
        throw Exception('Failed to fetch - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In fetchPaymentStatus ${e.toString()}");
    }
    return null;
  }

  // get loop
  Future<String?> checkPaymentStatus(int id) async {
    var status = await fetchPaymentStatus(id);

    if (status != "COMPLETED") {
      while (status != "COMPLETED" && status != "CANCELED") {
        status = await fetchPaymentStatus(id);
        print(status);
      }
    }

    return status;
  }

  //Post Data Section
  Future<int?> changeOrderProduct(int id, String orderName, int value,
      ) async {
    print(orderName);
    print(value);
    try {
      var response = await http.patch(
          Uri.parse(ApiConstants.localUrl + ApiConstants.updateOrder(id)),
          headers: <String, String>{
            'Content-Type': 'application/json'
            // 'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            orderName: value.toString(),
          }));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['accepted'];
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In changeOrderProduct ${e.toString()}");
    }
    return null;
  }

  // Future<int?> changeOrderName(int id, String value,
  //     ) async {
  //   try {
  //     var response = await http.put(
  //         Uri.parse("${ApiConstants.localUrl}${ApiConstants.order}/$id"),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json'
  //           // 'Authorization': 'Bearer $token'
  //         },
  //         body: jsonEncode(<String, String>{
  //           'client_name': value,
  //         }));
  //
  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body)['accepted'];
  //     } else {
  //       throw Exception('failed to post - StatusCode ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     log("In changeOrderName ${e.toString()}");
  //   }
  //   return null;
  // }

  Future<int?> setClientNumber(int id, String number, int promoPermission,
      ) async {
    try {
      var response = await http.patch(
          Uri.parse(ApiConstants.localUrl + ApiConstants.setClientNumber(id)),
          headers: <String, String>{
            'Content-Type': 'application/json'
            // 'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            "client_name": "${number}",
            "promo_permission": promoPermission.toString()
          }));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['accepted'];
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In setClientNumber ${e.toString()}");
    }
    return null;
  }

  Future<String?> paymentBlikOrder(
      int id, double totalAmount, String blikCode) async {
    try {
      final amount = totalAmount * 100;
      print('amount ${amount.toStringAsFixed(0)}');
      var response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.payBlik),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "id": id.toString(),
            "customerIp": await gettingIP(),
            "totalAmount": amount.toStringAsFixed(0),
            "blikCode": blikCode,
          }));

      print("Blik Status: ${response.statusCode}");
      print("Blik response: ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In paymentBlikOrder ${e.toString()}");
    }
    return null;
  }

  Future<String?> paymentCardOrder(
      int id,
      double totalAmount,
      String cardNumber,
      String expirationMonth,
      String expirationYear,
      String cvv) async {
    try {
      final amount = totalAmount * 100;
      var response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.payCard),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "id": id.toString(),
            "customerIp": await gettingIP(),
            "totalAmount": amount.toStringAsFixed(0),
            "cardNumber": cardNumber,
            "expirationMonth": expirationMonth,
            "expirationYear": expirationYear,
            "cvv": cvv
          }));

      print("Card Status: ${response.statusCode}");
      log("Card response: ${response.body}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In paymentCardOrder ${e.toString()}");
    }

    return null;
  }

  Future<String?> paymentCardTokenOrder(
      int id, double totalAmount, String cardToken) async {
    try {
      final amount = totalAmount * 100;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo andr = await deviceInfo.androidInfo;
      print(andr.fingerprint);

      var response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.payTokenCard),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "id": id.toString(),
            "customerIp": await gettingIP(),
            "totalAmount": amount.toStringAsFixed(0),
            "cardToken": cardToken,
            "fingerprint": andr.fingerprint,
          }));

      print("Card Status: ${response.statusCode}");
      log("Card response: ${response.body}");
      //print("${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In paymentCardOrder ${e.toString()}");
    }

    return null;
  }

  Future<String?> paymentCardTokenCreate(
      int id, double totalAmount, String cardToken) async {
    try {
      final amount = totalAmount * 100;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo andr = await deviceInfo.androidInfo;
      print(andr.fingerprint);

      var response = await http.post(
          Uri.parse(ApiConstants.baseUrl + "/api/payment/pay/createToken"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "id": id.toString(),
            "customerIp": await gettingIP(),
            "cardToken": cardToken,
            "fingerprint": andr.fingerprint,
          }));

      print("Card Status: ${response.statusCode}");
      log("Card response: ${response.body}");
      //print("${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In paymentCardOrder ${e.toString()}");
    }

    return null;
  }

  Future<String?> paymentGpayTokenOrder(
      int id, double totalAmount, String GpayToken) async {
    try {
      final amount = totalAmount * 100;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo andr = await deviceInfo.androidInfo;
      print(andr.fingerprint);
      print(GpayToken);

      var response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.payGpay),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "id": id.toString(),
            "customerIp": await gettingIP(),
            "totalAmount": amount.toStringAsFixed(0),
            "cardToken": GpayToken,
            "fingerprint": andr.fingerprint,
          }));

      print("Gpay Status: ${response.statusCode}");
      log("Gpay response: ${response.body}");
      //print("${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In paymentCardOrder ${e.toString()}");
    }

    return null;
  }

  Future<String?> paymentApplePayTokenOrder(
      int id, double totalAmount, String applePayToken) async {
    print(applePayToken);
    print("tt1");
    try {
      final amount = totalAmount * 100;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo andr = await deviceInfo.iosInfo;

      var response = await http.post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.payApplePay),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode({
            "id": id.toString(),
            "customerIp": await gettingIP(),
            "totalAmount": amount.toStringAsFixed(0),
            "cardToken": applePayToken,
            "fingerprint": andr.identifierForVendor,
          }));

      print("Gpay Status: ${response.statusCode}");
      debugPrint("Gpay response: ${response.body}");
      //print("${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      print("In paymentCardOrder ${e.toString()}");
      log("In paymentCardOrder ${e.toString()}");
    }
    print("tt2");
    return null;
  }

  //Login

  Future<String?> smsLogin(String phoneNumber, {String url = ApiConstants.baseUrl}) async {
    try {
      print(phoneNumber);
      var response = await client.post(
          Uri.parse(url + ApiConstants.smsLogin),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone_number': phoneNumber}));

      print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["status"];
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In sendSMS ${e.toString()}");
    }
    return null;
  }

  Future<String?> smsToken(String phoneNumber, String code, {String url = ApiConstants.baseUrl}) async {
    try {
      print("${phoneNumber}, ${code}");
      var response = await http.post(
          Uri.parse(url + ApiConstants.getSmsToken),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone_number': phoneNumber, 'code': code}));

          print(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["status"] == "SUCCESS") {
          return jsonDecode(response.body)["token"];
        } else {
          return jsonDecode(response.body)["status"];
        }
      } else {
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In sms Token ${e.toString()}");
    }
    return null;
  }

  Future<String?> login(String phoneNumber, String token, {String url = ApiConstants.baseUrl}) async {
    try {
      var response = await http.post(
          Uri.parse(url + ApiConstants.loginToken),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {'phone_number': phoneNumber, 'password_token': token}));

      print(ApiConstants.baseUrl + "/api/login_check");
      print("number: $phoneNumber, token: $token");

      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print("In error: ${response.body}");
        throw Exception('failed to post - StatusCode ${response.statusCode}');
      }
    } catch (e) {
      log("In login ${e.toString()}");
    }
    return null;
  }
}
