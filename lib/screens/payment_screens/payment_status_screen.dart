import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;

class PaymentStatusScreen extends StatefulWidget {
  final int id;

  const PaymentStatusScreen({
    Key? key,
    required this.id
  }) : super(key : key);

  @override
  State<StatefulWidget> createState() => PaymentStatusScreenState();
}

class PaymentStatusScreenState extends State<PaymentStatusScreen> {
  late MainProvider provider;
  int status = 0;

  int orderNumber = 1;

  bool paymentFlag = false;
  bool smsFlag = false;


  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    if(status == 0){ //Checking payment status state
      if(!paymentFlag){
        paymentFlag = true;
        ApiService(token: provider.loginToken).checkPaymentStatus(widget.id).then( (value) => {
          if(value == "COMPLETED"){
            setState(() {
              status = 1;
              provider.changeOrderStatus(2);
            })
          }else if(value == "CANCELED"){
            setState(() {
              status = 3;
              provider.changeOrderStatus(5);
            })
          }
        });
      }
    }else if(status == 1){ //Sending SMS state
      if(!smsFlag){
        smsFlag = true;
        provider.testRoute().then((value) => {
          setState( () {
            orderNumber = value;
            status = 2;
          })});
      }
    }else{

    }

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
            status == 0 ? Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text("Płatność rozpoczęta")),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width *0.5,
                    child: const CircularProgressIndicator())
              ],
            ) :
            status == 1 ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("Płatność zakończona powodzeniem",
                    style: TextStyle(
                      fontSize: 20))),
                const CircularProgressIndicator()]) :
            status == 2 ? Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text("Płatność zakończona powodzeniem",
                            style: TextStyle(
                                fontSize: 20))),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: Text('Twoje zamówienie ma nr ${orderNumber}',
                          style: const TextStyle(
                              fontSize: 15))),
                    ElevatedButton(
                        onPressed: () {
                          provider.orderFinish();
                          provider.changeToPizza();
                          provider.notifyListeners();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StartScreen()));
                        },
                        child: const Text("Zakończ transakcje"))]) :
                Column(
                  children: [
                    Text("Płatność anulowana"),
                    ElevatedButton(
                        onPressed: () {
                          provider.orderFinish();
                          provider.changeToPizza();
                          provider.notifyListeners();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const StartScreen()));
                        },
                        child: const Text("Zakończ transakcje"))])])));
  }
}