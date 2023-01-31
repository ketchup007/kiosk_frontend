import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/payment_screens/payment_status_screen.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:payu/payu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:webview_flutter/webview_flutter.dart';

class CardPayScreen extends StatefulWidget {
  final double amount;
  final int id;

  const CardPayScreen({
    Key? key,
    required this.amount,
    required this.id
}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CardPayScreenState();


}

class CardPayScreenState extends State<CardPayScreen>{
  late MainProvider provider;
  late AddCardService _service;
  final _formKey = GlobalKey<FormState>();

  final cardController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  void dispose() {
    cardController.dispose();
    super.dispose();
  }


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
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.lime)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("<",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.lime,
                          fontSize: 60)))),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Image.asset('assets/images/payULogos/payULogoLime.png')),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text("${provider.sum.toStringAsFixed(2)} zł",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 20)))])),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: cardController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19)
                      ],
                      decoration: InputDecoration(
                        hintText: "Numer Karty"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: monthController,
                      decoration: InputDecoration(
                        hintText: "Miesiąc"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: yearController,
                      decoration: InputDecoration(
                        hintText: "rok"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: cvvController,
                      decoration: InputDecoration(
                        hintText: "cvv"
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    print(monthController.text);
                    print(yearController.text);

                    ApiService(token: provider.loginToken).paymentCardOrder(widget.id, widget.amount, cardController.text, monthController.text, yearController.text, cvvController.text).then(
                            (value) {
                              String statusCode = jsonDecode(value!)["status"];
                              if(statusCode == "WARNING_CONTINUE_REDIRECT"){
                                print(1);
                              } else if(statusCode == "WARNING_CONTINUE_3DS"){
                                print(2);
                                _didTapHandleWarningContinue3DS(context, jsonDecode(value!)["redirectUri"], widget.id);

                              } else if(statusCode == "SUCCESS"){
                                print(3);
                              } else if(statusCode == "WARNING_CONTINUE_CVV"){
                                print(4);

                              }
                            });
                  }, child: Text(""))
                ],
              ),
            ),
            AddCardWidget(
                configuration: AddCardWidgetConfiguration(
                    cvvDecoration: AddCardWidgetTextInputDecoration(
                      hintText: "cvv hint"
                    ),
                    dateDecoration: AddCardWidgetTextInputDecoration(
                        hintText: "date hint"
                    ),
                    numberDecoration: AddCardWidgetTextInputDecoration(
                        hintText: "number hint"
                    ),
                    isFooterVisible: false),
                onCreated: (service) => _service = service),
            TextButton(
                onPressed: () => _tokenizer(false),
                child: Text('Use')),
            TextButton(
                onPressed: () => _tokenizer(true),
                child: Text('Also use xd'))
          ])));
  }

  void _tokenizer(bool save) async {
    final result = await _service.tokenize(false);

  print(result.value);
    ApiService(token: provider.loginToken).paymentCardTokenOrder(widget.id, widget.amount, result.value.toString());
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
      title: const Text('CardPaymentMethod'),
      content: Text(result.toString()),
    ));


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
/*
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    throw UnimplementedError();
  }
}

 */