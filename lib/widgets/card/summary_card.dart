import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/transaction_screen.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';

import 'package:kiosk_flutter/widgets/lists/order_list_view.dart';
import 'package:kiosk_flutter/screens/transaction_screen.dart';
import 'package:kiosk_flutter/widgets/card/phone_popup_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummaryCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SummaryCardState();
}

class SummaryCardState extends State<SummaryCard> {
  var _paymentState =
      0; // 0 - Not Started, 1 - Processing, 2 - Not Accepted, 3 - Accepted

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    return Card(
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromARGB(255, 151, 203, 98),
            ),
            borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        surfaceTintColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Text(AppLocalizations.of(context)!.orderSummaryText,
                    style: const TextStyle(
                        fontFamily: 'GloryExtraBold',
                        fontSize: 30,
                        color: Color.fromARGB(255, 86, 197, 208)))),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              child: OrderList(storage: provider.storageOrders),
            ),
            _paymentState == 0
                ? Container(
                    alignment: AlignmentDirectional.center,
                    padding: EdgeInsets.fromLTRB(
                        0,
                        MediaQuery.of(context).size.height * 0.05,  //0.05
                        MediaQuery.of(context).size.width * 0,   //0.04
                        0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.86,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 151, 203, 100),
                          foregroundColor: Colors.black),
                      onPressed: () {
                        if (provider.sum != 0) {
                          showDialog(
                            context: context,
                            builder: (context){
                              return PhonePopupCard(onPress: (isPromotionChecked) {
                                provider.setOrderClientNumber(provider.order.client_name, isPromotionChecked);
                                setState(() {
                                  _paymentState = 1;
                                });
                                provider.changeOrderStatus(1);
                                provider.inPayment = true;
                                provider.notifyListeners();
                              },);
                            });
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.makePaymentButtonLabel,
                          style: const TextStyle(
                              fontFamily: 'GloryBold',
                              fontSize: 30)),
                    )))
                : Container(
                    child: FutureBuilder(
                        future: provider.payment.startTransaction(provider.sum),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width *
                                        0.86,
                                    child: Card(
                                      color: const Color.fromARGB(255, 151, 203, 98),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(AppLocalizations.of(context)!.paymentStartedText
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontFamily: 'GloryExtraBold',
                                                  fontSize: 25)),
                                          Text(
                                              AppLocalizations.of(context)!.paymentInfoText,
                                              style: const TextStyle(
                                                  fontFamily: 'GloryMedium',
                                                  fontSize: 20)),
                                          const CircularProgressIndicator(
                                              color: Color.fromARGB(
                                                  255, 89, 162, 38))
                                        ],
                                      ),
                                    )),
                              ],
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.hasData) {
                              if (snapshot.data.toString() == "0") {
                                // REMEMBER TO CHANGE TO 0 !!!!!!!!
                                provider.changeOrderStatus(2);
                                return Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.86,
                                        child: Card(
                                            color: const Color.fromARGB(
                                                255, 151, 203, 98),
                                            child: Center(
                                                child: Text(
                                                    AppLocalizations.of(context)!.paymentAcceptedText
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'GloryExtraBold',
                                                        fontSize: 25))))),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                foregroundColor: const Color.fromARGB(
                                                    255, 218, 49, 62),
                                                side: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 218, 49, 62),
                                                    width: 1)),
                                            onPressed: () {
                                              provider.orderFinish();
                                              provider.changeToPizza();
                                              provider.inPayment = false;
                                              provider.notifyListeners();
                                              setState(() {
                                                _paymentState = 0;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const StartScreen()));
                                            },
                                            child: Text(AppLocalizations.of(context)!.returnButtonLabel,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontFamily:
                                                        'GloryMedium'))))
                                  ],
                                );
                              } else {
                                provider.changeOrderStatus(5);
                                return Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.86,
                                        child: Card(
                                          color:
                                              const Color.fromARGB(255, 218, 49, 62),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!.paymentCancelledText
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'GloryExtraBold',
                                                      fontSize: 25,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        )),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0,
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                            0,
                                            0),
                                        child: Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                    0,
                                                    0,
                                                    0),
                                                child: SizedBox(
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.03,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.2,
                                                    child: OutlinedButton(
                                                        style: OutlinedButton.styleFrom(
                                                            foregroundColor:
                                                                const Color.fromARGB(
                                                                    255, 218, 49, 62),
                                                            side: const BorderSide(
                                                                color: Color.fromARGB(
                                                                    255, 218, 49, 62),
                                                                width: 1)),
                                                        onPressed: () {
                                                          provider
                                                              .orderCancel();
                                                          provider
                                                              .changeToPizza();
                                                          provider.inPayment =
                                                              false;
                                                          provider.notifyListeners();
                                                          setState(() {
                                                            _paymentState = 0;
                                                          });
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const StartScreen()));
                                                        },
                                                        child: Text(AppLocalizations.of(context)!.returnButtonLabel, style: TextStyle(fontSize: 17, fontFamily: 'GloryMedium'))))),
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.45,
                                                    0,
                                                    0,
                                                    0),
                                                child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.03,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color.fromARGB(
                                                                  255,
                                                                  151,
                                                                  203,
                                                                  100),
                                                          foregroundColor:
                                                              Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          provider
                                                              .changeOrderStatus(
                                                                  1);
                                                          setState(() {
                                                            _paymentState = 1;
                                                          });
                                                        },
                                                        child: Text(
                                                            AppLocalizations.of(context)!.tryAgainButtonLabel,
                                                            style: const TextStyle(
                                                                fontSize: 17,
                                                                fontFamily:
                                                                    'GloryMedium')))))
                                          ],
                                        ))
                                  ],
                                );
                              }
                            } else {
                              print(snapshot.data);
                              return const Text('Empty data');
                            }
                          } else {
                            return const Text('snapshot.connectionState');
                          }
                        }))
          ],
        ));
  }
}
