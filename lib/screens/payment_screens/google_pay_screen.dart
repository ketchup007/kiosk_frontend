import 'package:flutter/material.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:pay/pay.dart';

class MyGooglePayScreen extends StatefulWidget {
  final double amount;
  final int id;

  const MyGooglePayScreen({Key? key, required this.amount, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyGooglePayScreenState();
}

class MyGooglePayScreenState extends State<MyGooglePayScreen> {
  late MainProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    return Background(
      child: Column(
        children: [
          PayUTopBar(onPress: () {}, amount: provider.sum),
          GooglePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
              onPaymentResult: (result) {
                var list = result.values.toList();
                var json = list[2]["tokenizationData"]["token"];
                var value = base64.encode(utf8.encode(json));

                ApiService(token: provider.loginToken).paymentGpayTokenOrder(widget.id, widget.amount, value).then((result) {
                  print(result);
                  String statusCode = jsonDecode(result!)["status"];

                  if (statusCode == "WARNING_CONTINUE_REDIRECT") {
                  } else if (statusCode == "WARNING_CONTINUE_3DS") {
                    _didTapHandleWarningContinue3DS(context, jsonDecode(result)["redirectUri"], widget.id);
                  } else if (statusCode == "SUCCESS") {
                  } else if (statusCode == "WARNING_CONTINUE_CVV") {}
                });
              },
              paymentItems: [PaymentItem(label: "total", amount: provider.sum.toString(), status: PaymentItemStatus.final_price)]),
        ],
      ),
    );
  }

  void _didTapHandleWarningContinue3DS(context, String uri, int id) async {
    // final PayU.SoftAcceptMessage result = await showDialog(context: context, builder: (context) => PayU.SoftAcceptAlertDialog(request: PayU.SoftAcceptRequest(redirectUri: uri)));

    // final result2 = PayU.SoftAcceptRequest(redirectUri: uri);

    // print(result2.toString());
    // print("first");
    // print(result.value);
    // print("seccond");

    // if (result.value == "AUTHENTICATION_SUCCESSFUL") {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentStatusScreen(id: id)));
    // } else if (result.value == "AUTHENTICATION_CANCELED") {
    //   print("Authentication failed");
    // } else if (result.value == "DISPLAY_FRAME") {
    //   print(uri);
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayFrameScreen(url: uri, id: id)));
    // }
  }

  static const String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "payu",
            "gatewayMerchantId": "455830"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "transactionInfo": {
      "countryCode": "PL",
      "currencyCode": "PLN"
    }
  }
}''';
}
