import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/payment_screens/payment_status_screen.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:payu/payu.dart' as PayU;
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:pay/pay.dart';
import 'dart:io';

import 'display_frame_screen.dart';


class MyGooglePayScreen extends StatefulWidget {
  final double amount;
  final int id;

  const MyGooglePayScreen({
    Key? key,
    required this.amount,
    required this.id
  }): super(key:key);

  @override
  State<StatefulWidget> createState() => MyGooglePayScreenState();
}

class MyGooglePayScreenState extends State<MyGooglePayScreen>{
  late MainProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: SVG.Svg('assets/images/background.svg'),
              fit: BoxFit.cover)),
        child: Column(
          children: [
            PayUTopBar(
                onPress: () {},
                amount: provider.sum),

            GooglePayButton(
              paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
                onPaymentResult: (result) {


                  var list = result.values.toList();

                  print("result.toString() ${list.length}");

                  for(int i=0; i<list.length; i++){
                    print(list[i]);
                    print(i);
                    //debugPrint(list[i]);
                  }
                  print(list[2]["tokenizationData"]["token"]);
                  var json = jsonDecode(list[2]["tokenizationData"]["token"]);
                  print(jsonDecode(json["signedMessage"])["encryptedMessage"]);
                  ApiService(token: provider.loginToken).paymentGpayTokenOrder(widget.id, widget.amount, jsonDecode(json["signedMessage"])["encryptedMessage"]).then(
                      (result) {
                        print(result);

                        ApiService(token: provider.loginToken).fetchTransactionData(widget.id);
                        ApiService(token: provider.loginToken).fetchOrderData(widget.id);
                        //_didTapHandleWarningContinue3DS(context, jsonDecode(result!)["redirectUri"], widget.id);
                      }
                  );
                },
                paymentItems: [
                  PaymentItem(
                    label: "total",
                    amount: provider.sum.toString(),
                    status: PaymentItemStatus.final_price
                )])



          ],
        ),
      ),
    );
  }
  void _didTapHandleWarningContinue3DS(context, String uri, int id) async {
    final PayU.SoftAcceptMessage result = await showDialog(
        context: context,
        builder: (context) => PayU.SoftAcceptAlertDialog(
            request: PayU.SoftAcceptRequest(
                redirectUri: uri)));

    final result2 = PayU.SoftAcceptRequest(redirectUri: uri);

    print(result2.toString());
    print("first");
    print(result.value);
    print("seccond");

    if(result.value == "AUTHENTICATION_SUCCESSFUL"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentStatusScreen(id: id)));
    }else if(result.value == "AUTHENTICATION_CANCELED"){
      print("Authentication failed");
    }else if(result.value == "DISPLAY_FRAME"){
      print(uri);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DisplayFrameScreen(url: uri, id: id)
          ));
    }
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
    "merchantInfo": {
      "merchantId": "01234567890123456789",
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "US",
      "currencyCode": "USD"
    }
  }
}''';

}

