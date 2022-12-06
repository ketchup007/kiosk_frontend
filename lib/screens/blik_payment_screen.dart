import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;

class BlikPayScreen extends StatefulWidget {
  final double amount;
  final int id;

  const BlikPayScreen({
    Key? key,
    required this.amount,
    required this.id
}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BlikPayScreenState();
}

class BlikPayScreenState extends State<BlikPayScreen>{
  late MainProvider provider;
  TextEditingController controller = TextEditingController();
  bool inPayment = false;
  
  @override
  Widget build(context){
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
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.lime)
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.2,
                          child:GestureDetector(
                            onTap: () {
                              if(inPayment == false){
                                Navigator.pop(context);  
                              }
                            },
                            child: Text("<",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.lime,
                                  fontSize: 60
                              ),),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Image.asset('assets/images/payULogos/payULogoLime.png'),
                        ),
                        SizedBox(
                          width:  MediaQuery.of(context).size.width * 0.2,
                          child: Text("${provider.sum} zł",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: AppColors.darkGreen,
                                  fontSize: 20
                              )
                          ),
                        )
                      ])),

              inPayment == false ? Column(
                  children : [Container(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Wprowadź kod blik",
                  ),
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ))),
              ElevatedButton(
                  onPressed: () {
                    if(controller.text.length == 6){
                      ApiService().paymentBlikOrder(widget.id, widget.amount, controller.text);
                      setState(() {
                        inPayment = true;
                      });

                    }
                  },
                  child: const Text("zapłać")),])
               : FutureBuilder(
                  future: ApiService().checkPaymentStatus(widget.id),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final String status = snapshot.data as String;
                      if(status == "COMPLETED"){
                        provider.changeOrderStatus(2);
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Płatność zakończona powodzeniem",
                                style: TextStyle(
                                  fontSize: 20
                                ),)),
                            FutureBuilder(
                                future: provider.getOrderNumber(),
                                builder: (context2, snapshot2) {
                                  if (snapshot2.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator(color: AppColors.darkGreen);
                                  } else if (snapshot2.connectionState == ConnectionState.done) {
                                    if (snapshot2.hasError) {
                                      return Text('Error');
                                    } else if(snapshot2.hasData){
                                      return Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              child: Text('Twoje zamówienie ma nr ${snapshot2.data}',
                                              style: TextStyle(
                                                fontSize: 15
                                              ),)),
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
                                                child: Text("Zakończ transakcje"))
                                          ]);
                                    } else {
                                      return Text('Empty data');
                                    }
                                  } else {
                                    return Text(snapshot2.connectionState.toString());
                                  }
                                })
                          ],
                        );
                      }
                      return Text(status);
                    } else if(snapshot.hasError) {
                      return Text("");
                    }else {
                      return Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(20),
                                child: Text("Płatność rozpoczęta")),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: MediaQuery.of(context).size.width *0.5,
                                child: CircularProgressIndicator())
                          ]);
                    }
                  })
            ],
          ),
      ),
    );
  }
}