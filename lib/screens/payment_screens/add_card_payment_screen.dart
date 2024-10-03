import 'package:flutter/material.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
// import 'package:payu/payu.dart';
import 'package:provider/provider.dart';

class AddCardScreen extends StatefulWidget {
  final int id;
  final double amount;

  const AddCardScreen({Key? key, required this.id, required this.amount}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddCardScreenState();
}

class AddCardScreenState extends State<AddCardScreen> {
  late MainProvider provider;
  // late AddCardService _service;

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
          // AddCardWidget(
          //   configuration: AddCardWidgetConfiguration(
          //     cvvDecoration: const AddCardWidgetTextInputDecoration(hintText: "cvv hint"),
          //     dateDecoration: const AddCardWidgetTextInputDecoration(hintText: "date hint"),
          //     numberDecoration: const AddCardWidgetTextInputDecoration(hintText: "number hint"),
          //     isFooterVisible: false,
          //   ),
          //   onCreated: (service) => _service = service,
          // ),
          // TextButton(
          //   onPressed: () => _tokenizer(false).then(
          //     (value) => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => TokenPaymentScreen(
          //           cardToken: value,
          //           id: widget.id,
          //           amount: widget.amount,
          //           save: false,
          //         ),
          //       ),
          //     ),
          //   ),
          //   child: const Text("Use"),
          // ),
          // TextButton(
          //   onPressed: () => _tokenizer(true).then(
          //     (value) => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => TokenPaymentScreen(
          //           cardToken: value,
          //           id: widget.id,
          //           amount: widget.amount,
          //           save: true,
          //         ),
          //       ),
          //     ),
          //   ),
          //   child: const Text("Use and save"),
          // ),
          // const TermsAndConditionsWidget(),
        ],
      ),
    );
  }

  // Future<CardPaymentToken> _tokenizer(bool save) async {
  //   // final CardToken result = await _service.tokenize(save);

  //   // print(result.value);
  //   // print(result);

  //   // final newCardToken = CardPaymentToken.fromCardToken(result);

  //   // //Save Multi Use Token
  //   // //if(save){
  //   // //provider.cardTokens.add(newCardToken);
  //   // //provider.saveCardTokens();
  //   // //}

  //   // print("New Card Token: value: ${newCardToken.value}, ${newCardToken.cardNumberMasked}");
  //   // return newCardToken;

  //   /*
  //   final result2 = await ApiService(token: provider.loginToken).paymentCardTokenOrder(widget.id, widget.amount, result.value.toString());

  //   print(result2);
  //   String statusCode = jsonDecode(result2!)["status"];
  //   if(statusCode == "WARNING_CONTINUE_REDIRECT"){
  //     print(1);
  //   } else if(statusCode == "WARNING_CONTINUE_3DS"){
  //     print(2);
  //     _didTapHandleWarningContinue3DS(context, jsonDecode(result2)["redirectUri"], widget.id);

  //   } else if(statusCode == "SUCCESS"){
  //     print(3);
  //   } else if(statusCode == "WARNING_CONTINUE_CVV"){
  //     print(4);
  //   }
  //    */
  // }

  void _didTapHandleWarningContinue3DS(context, String uri, int id) async {
    // final SoftAcceptMessage result = await showDialog(context: context, builder: (context) => SoftAcceptAlertDialog(request: SoftAcceptRequest(redirectUri: uri)));

    // print("first");
    // print(result.value);
    // print("seccond");

    // if (result.value == "AUTHENTICATION_SUCCESSFUL") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => PaymentStatusScreen(id: id),
    //     ),
    //   );
    // }
  }
}
