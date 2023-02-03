import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/payment_screens/payment_token_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;

import '../../models/pay_methods_model.dart';
import '../../widgets/bars/payu_top_bar.dart';
import 'add_card_payment_screen.dart';
import 'blik_payment_screen.dart';
import 'card_payment_screen.dart';

class NewPayUScreen extends StatefulWidget {
  const NewPayUScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewPayUScreenState();
}

class _NewPayUScreenState extends State<NewPayUScreen> {
  late MainProvider provider;

  late Future<int?> _future;

  late List<PayMethodsModel> blockList;

  int id = 0;

  bool _loading = true;

  @override
  Widget build(context) {
    provider = Provider.of<MainProvider>(context, listen:true);

    if(_loading == true){
      _future = _pageSetup().whenComplete(() {
        _loading = false;
      });
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PayUTopBar(
                onPress: () => Navigator.pop(context),
                amount: provider.sum),
            Container(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.75,
                child: const Text("Wybierz metodę płatności",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20)))),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.35,
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return const Text("error");
                  }

                  if(snapshot.hasData){
                    id = snapshot.data as int;
                    return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 /2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: blockList.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.1,
                              child: GestureDetector(
                                  onTap: () {
                                    if(blockList[index].value == "blik"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => BlikPayScreen(amount: provider.sum, id: id)));
                                    }else if(blockList[index].value == "c"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CardPayScreen(amount: provider.sum, id: id)));
                                    }else if(blockList[index].value == "add_card"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardScreen(amount: provider.sum, id: id)));
                                    }
                                  },
                                  child: Image.network(blockList[index].brandImageUrl))
                          );

                    });
                  }

                  return const CircularProgressIndicator();
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Future <int?> _pageSetup() async {
    print('in Page setup');
    final output = await ApiService(token: provider.loginToken).getPaymentAuth();

    blockList = (await ApiService(token:provider.loginToken).fetchPaymentMethods2(output!))!;

    return output;
  }
}