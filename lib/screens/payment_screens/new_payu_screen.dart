// import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/features/order/bloc/order_bloc.dart';
import 'package:kiosk_flutter/models/pay_methods_model.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/payment_screens/add_card_payment_screen.dart';
import 'package:kiosk_flutter/screens/payment_screens/apple_pay_screen.dart';
import 'package:kiosk_flutter/screens/payment_screens/blik_payment_screen.dart';
import 'package:kiosk_flutter/screens/payment_screens/google_pay_screen.dart';
import 'package:kiosk_flutter/screens/payment_screens/payment_token_screen.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/bars/payu_top_bar.dart';
import 'package:provider/provider.dart';

class NewPayBlockModel {
  final String value;
  final String brandImageUrl;
  int? id;

  NewPayBlockModel({required this.value, required this.brandImageUrl, this.id});
}

class NewPayUScreen extends StatefulWidget {
  const NewPayUScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewPayUScreenState();
}

class _NewPayUScreenState extends State<NewPayUScreen> {
  late MainProvider provider;

  late Future<int?> _future;

  late List<NewPayBlockModel> blockList = [];

  int id = 0;

  bool _loading = true;

  @override
  Widget build(context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    if (_loading == true) {
      _future = _pageSetup().whenComplete(() {
        _loading = false;
      });
    }

    return Background(
      child: Builder(builder: (context) {
        final totalOrderAmount = context.select<OrderBloc, double>(
          (bloc) => bloc.state.totalOrderAmount,
        );

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PayUTopBar(
              onPress: () => Navigator.pop(context),
              amount: totalOrderAmount,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Text(
                  "Wybierz metodę płatności",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text("error");
                  }

                  if (snapshot.hasData) {
                    id = snapshot.data as int;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                      itemCount: blockList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: GestureDetector(
                            onTap: () {
                              if (blockList[index].value == "blik") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BlikPayScreen(amount: totalOrderAmount, id: id)));
                              } else if (blockList[index].value == "c") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardScreen(amount: totalOrderAmount, id: id)));
                              } else if (blockList[index].value == "card") {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => TokenPaymentScreen(cardToken: provider.cardTokens[blockList[index].id!], id: id, amount: totalOrderAmount, save: false)));
                              } else if (blockList[index].value == "ap") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyGooglePayScreen(amount: totalOrderAmount, id: id)));
                              } else if (blockList[index].value == "jp") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ApplePayScreen(amount: totalOrderAmount, id: id)));
                              }
                            },
                            child: Image.network(
                              blockList[index].brandImageUrl,
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<int?> _pageSetup() async {
    print('in Page setup');
    final output = await ApiService(token: provider.loginToken).getPaymentAuth();

    print("page 1");
    List<PayMethodsModel> temp;

    temp = (await ApiService(token: provider.loginToken).fetchPaymentMethods2(output!))!;

    print("page 2");
    for (int i = 0; i < temp.length; i++) {
      if (temp[i].value == "blik") {
        blockList.add(NewPayBlockModel(value: "blik", brandImageUrl: temp[i].brandImageUrl));
      } else if (temp[i].value == "c") {
        blockList.add(NewPayBlockModel(value: "c", brandImageUrl: temp[i].brandImageUrl));
      } else if (temp[i].value == "ap") {
        if (Platform.isAndroid) {
          blockList.add(NewPayBlockModel(value: "ap", brandImageUrl: temp[i].brandImageUrl));
        }
      } else if (temp[i].value == "jp") {
        if (Platform.isIOS) {
          blockList.add(NewPayBlockModel(value: "jp", brandImageUrl: temp[i].brandImageUrl));
        }
      }
    }
    print("page 3");
    await provider.loadCardTokens();

    print("page 4");
    // print(provider.cardTokens.length);

    try {
      print(provider.cardTokens.length);
      for (int i = 0; i < provider.cardTokens.length; i++) {
        print(provider.cardTokens[i].value);
        blockList.add(NewPayBlockModel(value: "card", brandImageUrl: provider.cardTokens[i].brandImageUrl, id: i));
      }
    } on Exception catch (e) {
      print(e);
    }

    return output;
  }
}
