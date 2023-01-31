import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_flutter/models/pay_methods_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/payment_screens/blik_payment_screen.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:payu/payu.dart';
import 'package:provider/provider.dart';

import '../screens/payment_screens/add_card_payment_screen.dart';
import '../screens/payment_screens/card_payment_screen.dart';

class MobilePayment extends StatefulWidget{
  final double amount;
  
  const MobilePayment({
    Key? key,
    required this.amount
  }): super(key: key);
  
  @override
  State<StatefulWidget> createState() => MobilePaymentState();
}

class PayBlockModel{
  final String value;
  final String brandImageUrl;


  PayBlockModel({
    required this.value,
    required this.brandImageUrl,
  });
}

class MobilePaymentState extends State<MobilePayment>{
  int id = 0;
  var _loading = true;
  late Future<int?> _future;

  late MainProvider provider;

  List<PayBlockModel> blocksList = [
    PayBlockModel(
        value: "blik",
        brandImageUrl: "https://static.payu.com/images/mobile/logos/pbl_blik.png"),
    PayBlockModel(
        value: "c",
        brandImageUrl: "https://static.payu.com/images/mobile/logos/pbl_c.png"),
    PayBlockModel(
        value: "add_card",
        brandImageUrl: "https://static.payu.com/images/mobile/logos/pbl_c.png")
  ];



  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);


    if(_loading == true){
      _future = ApiService(token: provider.loginToken).startPaymentSession().whenComplete(() {
        _loading = false;
        provider.loadCardTokens();
      });
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: const Text("Wybierz metodę płatności",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20))),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.35,
            child:FutureBuilder(
              future: _future,
              builder: (context, snapshot){

                if(snapshot.hasData){
                  id = snapshot.data as int;

                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 /2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                      itemCount: blocksList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: GestureDetector(
                              onTap: () {
                                if(blocksList[index].value == "blik"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlikPayScreen(amount: widget.amount, id: id)));
                                }else if(blocksList[index].value == "c"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardPayScreen(amount: widget.amount, id: id)));
                                }else if(blocksList[index].value == "add_card"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardScreen(amount: widget.amount, id: id)));
                                }
                              },
                                child: Image.network(blocksList[index].brandImageUrl))
                            );
                      },
                  );
                } else if(snapshot.hasError){
                  return Text("");
                } else {
                  return CircularProgressIndicator();
                }
              })),
        ]);
  }
  
}