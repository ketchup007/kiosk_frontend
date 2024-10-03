import 'package:flutter/material.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class ApplePayScreen extends StatefulWidget {
  final double amount;
  final int id;

  const ApplePayScreen({Key? key, required this.amount, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ApplePayScreenState();
}

class ApplePayScreenState extends State<ApplePayScreen> {
  late MainProvider provider;
  bool warning = false;
  String redirectUrl = '';

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);
    return Background(
      child: Column(
        children: [
          Builder(
            builder: (context) {
              final double totalOrderAmount = context.select<OrderBloc, double>(
                (bloc) => bloc.state.totalOrderAmount,
              );

              return PayUTopBar(
                onPress: () {},
                amount: totalOrderAmount,
              );
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            child: !warning
                ? Builder(builder: (context) {
                    final totalOrderAmount = context.select<OrderBloc, double>(
                      (bloc) => bloc.state.totalOrderAmount,
                    );

                    return ApplePayButton(
                      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
                      onPaymentResult: (result) {
                        print("------------------");

                        var temp = jsonDecode(result["token"]);
                        print(temp["version"]);
                        print(temp["data"]);
                        print(temp["signature"]);
                        print(temp["header"]);

                        var headerData = {
                          "ephemeralPublicKey": temp["header"]["ephemeralPublicKey"],
                          "publicKeyHash": temp["header"]["publicKeyHash"],
                          "transactionId": temp["header"]["transactionId"]
                        };

                        var data = {'version': temp["version"], 'data': temp["data"], 'signature': temp["signature"], 'header': headerData};

                        var json = jsonEncode(data);

                        print("-------------------");
                        print("json");
                        print(json);

                        print("------------------");

                        var value = base64.encode(utf8.encode(json));
                        print("value");
                        print(value);

                        ApiService(token: provider.loginToken).paymentApplePayTokenOrder(widget.id, widget.amount, value).then((result) {
                          print(result);
                          String statusCode = jsonDecode(result!)["status"]["statusCode"];

                          if (statusCode == "WARNING_CONTINUE_REDIRECT") {
                          } else if (statusCode == "WARNING_CONTINUE_3DS") {
                            setState(() {
                              redirectUrl = jsonDecode(result)["redirectUri"];
                              warning = true;
                            });

                            _didTapHandleWarningContinue3DS(context, jsonDecode(result)["redirectUri"], widget.id);
                          } else if (statusCode == "SUCCESS") {
                          } else if (statusCode == "WARNING_CONTINUE_CVV") {}
                        });
                      },
                      style: ApplePayButtonStyle.black,
                      type: ApplePayButtonType.buy,
                      width: 200,
                      height: 50,
                      paymentItems: [
                        // Builder(
                        //   builder: (context) {
                        //     final double totalOrderAmount = context.select<OrderBloc, double>(
                        //       (bloc) => bloc.state.totalOrderAmount,
                        //     );

                        //     return PayUTopBar(
                        //       onPress: () {},
                        //       amount: totalOrderAmount,
                        //     );
                        //   },
                        // ),
                        PaymentItem(
                          label: "total",
                          amount: totalOrderAmount.toString(),
                          status: PaymentItemStatus.final_price,
                        ),
                      ],
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  })
                : ElevatedButton(
                    onPressed: () {
                      _didTapHandleWarningContinue3DS(context, redirectUrl, widget.id);
                    },
                    child: const Text(''),
                  ),
          ),
          const Text('new'),
        ],
      ),
    );
  }

  void _didTapHandleWarningContinue3DS(context, String uri, int id) async {
    // final payu.SoftAcceptMessage result = await showDialog(context: context, builder: (context) => payu.SoftAcceptAlertDialog(request: payu.SoftAcceptRequest(redirectUri: uri)));

    // final result2 = payu.SoftAcceptRequest(redirectUri: uri);

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

  static const String defaultApplePay = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.city.test.munchies",
    "displayName": "Munchiess",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "PL",
    "currencyCode": "PLN",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": [],
    "shippingMethods": [
      {
        "amount": "0.00",
        "detail": "Available within an hour",
        "identifier": "in_store_pickup",
        "label": "In-Store Pickup"
      },
      {
        "amount": "4.99",
        "detail": "5-8 Business Days",
        "identifier": "flat_rate_shipping_id_2",
        "label": "UPS Ground"
      },
      {
        "amount": "29.99",
        "detail": "1-3 Business Days",
        "identifier": "flat_rate_shipping_id_1",
        "label": "FedEx Priority Mail"
      }
    ]
  }
}''';
}
