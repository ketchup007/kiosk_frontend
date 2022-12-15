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

  int status = 0;
  int orderNumber = 1;
  bool blikFlag = false;
  bool smsFlag = false;

  bool inPayment = false;
  late Future<String?> _future;
  late Future<int> _future2;
  bool paymentDone = false;


  @override
  Widget build(context){
    provider = Provider.of<MainProvider>(context, listen: true);
    print("status: $status");
    if(status == 1){
      if(!blikFlag){
        blikFlag = true;
        ApiService(token: provider.loginToken).checkPaymentStatus(widget.id).then((value) => {
          setState( () {
            if(value == "COMPLETED"){
              status = 2;
              provider.changeOrderStatus(2);
            }})});
      }
    }else if(status == 2){
      if(!smsFlag){
        smsFlag = true;
        provider.testRoute().then((value) => {
          setState( () {
            orderNumber = value;
            status = 3;
          })});
      }
    }else if(status == 3){

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
                            if(status == 0){
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("<",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.lime,
                                fontSize: 60)))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Image.asset('assets/images/payULogos/payULogoLime.png')),
                      SizedBox(
                        width:  MediaQuery.of(context).size.width * 0.2,
                        child: Text("${provider.sum.toStringAsFixed(2)} zł",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                color: AppColors.darkGreen,
                                fontSize: 20)))])),
            status == 0 ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: "Wprowadź kod blik",
                          ),
                          maxLength: 6,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly]))),
                  ElevatedButton(
                      onPressed: () {
                        if(controller.text.length == 6){
                          ApiService(token: provider.loginToken).paymentBlikOrder(widget.id, widget.amount, controller.text);
                          setState(() {
                            _future = ApiService(token: provider.loginToken).checkPaymentStatus(widget.id);
                            status = 1;
                          });
                        }
                      },
                      child: const Text("zapłać"))]) :
            status == 1 ? Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      child: Text("Płatność rozpoczęta")),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width *0.5,
                      child: CircularProgressIndicator())
                ]) :
            status == 2 ? Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Płatność zakończona powodzeniem",
                        style: TextStyle(
                            fontSize: 20
                        ))),
                  CircularProgressIndicator()]) :
            status == 3 ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Płatność zakończona powodzeniem",
                        style: TextStyle(
                            fontSize: 20
                        ))),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Twoje zamówienie ma nr ${orderNumber}',
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
                ]) : Text("")])));

  }

  /*
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
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),)
                ]) :
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.lime)
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.2,
                          child: GestureDetector(
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
                          child: Text("${provider.sum.toStringAsFixed(2)} zł",
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
                        _future = ApiService().checkPaymentStatus(widget.id);
                        inPayment = true;
                      });

                    }
                  },
                  child: const Text("zapłać")),])
               : FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final String status = snapshot.data as String;
                      if(status == "COMPLETED"){
                          if(!paymentDone){
                            paymentDone == true;
                            _future2 = provider.testRoute();
                          }
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
                                future: _future2,
                                builder: (context2, snapshot2) {
                                  if (snapshot2.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator(color: AppColors.darkGreen);
                                  } else if (snapshot2.connectionState == ConnectionState.done) {
                                    if (snapshot2.hasError) {
                                      return Text('Error');
                                    } else if(snapshot2.hasData){
                                      //print("in blik payment");
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
   */
}