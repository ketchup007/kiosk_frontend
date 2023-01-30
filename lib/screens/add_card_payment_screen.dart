import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/payment_status_screen.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:payu/payu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:webview_flutter/webview_flutter.dart';

class AddCardScreen extends StatefulWidget{
  final int id;
  final double amount;

  const AddCardScreen({
    Key? key,
    required this.id,
    required this.amount
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddCardScreenState();
}

class AddCardScreenState extends State<AddCardScreen> {
  late MainProvider provider;
  late AddCardService _service;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
          color:  Colors.white,
          image: DecorationImage(
            image: SVG.Svg('assets/images/background.svg'),
            fit: BoxFit.cover)),
          child: Column(
            children: [
              PayUTopBar(
                onPress: () {},
                  amount: provider.sum),
              AddCardWidget(
                  configuration: AddCardWidgetConfiguration(
                      cvvDecoration: const AddCardWidgetTextInputDecoration(
                          hintText: "cvv hint"
                      ),
                      dateDecoration: const AddCardWidgetTextInputDecoration(
                          hintText: "date hint"
                      ),
                      numberDecoration: const AddCardWidgetTextInputDecoration(
                          hintText: "number hint"
                      ),
                      isFooterVisible: false),
                  onCreated: (service) => _service = service),
              TextButton(
                onPressed: () => _tokenizer(false),
                child:  Text("Use")),
              TextButton(
                  onPressed: () => _tokenizer(true),
                  child: Text("Use and save"))])));
  }

  void _tokenizer(bool save) async {
    final CardToken result = await _service.tokenize(save);

    print(result.value);
    /*
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('CardPaymentMethod'),
          content: Text(result.toString()),
        ));

     */

    final result2 = await ApiService(token: provider.loginToken).paymentCardTokenOrder(widget.id, widget.amount, result.value.toString());

    print(result2);
    String statusCode = jsonDecode(result2!)["status"];
    if(statusCode == "WARNING_CONTINUE_REDIRECT"){
      print(1);
    } else if(statusCode == "WARNING_CONTINUE_3DS"){
      print(2);
      _didTapHandleWarningContinue3DS(context, jsonDecode(result2)["redirectUri"], widget.id);

    } else if(statusCode == "SUCCESS"){
      print(3);
    } else if(statusCode == "WARNING_CONTINUE_CVV"){
      print(4);

    }
  }

  void _didTapHandleWarningContinue3DS(context, String uri, int id) async {
    final SoftAcceptMessage result = await showDialog(
        context: context,
        builder: (context) => SoftAcceptAlertDialog(
            request: SoftAcceptRequest(
                redirectUri: uri)));

    print("first");
    print(result.value);
    print("seccond");

    if(result.value == "AUTHENTICATION_SUCCESSFUL"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentStatusScreen(id: id)));
    }
  }


}