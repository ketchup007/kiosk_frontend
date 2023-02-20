import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/payment_screens/payment_status_screen.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:pay/pay.dart';


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
              margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (result) {


                  var list = result.values.toList();

                  print("result.toString() ${list.length}");

                  for(int i=0; i<list.length; i++){
                    print(list[i]);
                    print(i);
                    //debugPrint(list[i]);
                  }
                  print(list[2]["tokenizationData"]["token"]);
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

