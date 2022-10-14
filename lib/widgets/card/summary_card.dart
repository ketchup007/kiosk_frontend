import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/transaction_screen.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';

import 'package:kiosk_flutter/widgets/lists/order_list_view.dart';
import 'package:kiosk_flutter/screens/transaction_screen.dart';
import 'package:kiosk_flutter/widgets/card/phone_popup_card.dart';

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
            side: BorderSide(
              color: Color.fromARGB(255, 151, 203, 98),
            ),
            borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        surfaceTintColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Text('Podsumowanie zamówienia',
                    style: TextStyle(
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
                    alignment: AlignmentDirectional.centerEnd,
                    padding: EdgeInsets.fromLTRB(
                        0,
                        MediaQuery.of(context).size.height * 0.05,
                        MediaQuery.of(context).size.width * 0.04,
                        0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 151, 203, 100),
                          foregroundColor: Colors.black),
                      onPressed: () {
                        if (provider.sum != 0) {
                          showDialog(
                            context: context,
                            builder: (context){
                              return PhonePopupCard(onPress: () {
                                print(provider.order.client_name);
                                setState(() {
                                  _paymentState = 1;
                                });
                                provider.changeOrderStatus(1);
                                provider.inPayment = true;
                                provider.notifyListeners();
                              },);
                            });
                        }
                        /*if (provider.sum != 0) {
                          setState(() {
                            _paymentState = 1;
                          });
                          provider.changeOrderStatus(1);
                          provider.inPayment = true;
                          provider.notifyListeners();
                        } */
                      },
                      child: Text('Dokonaj Płatności'),
                    ))
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
                                      color: Color.fromARGB(255, 151, 203, 98),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              'Płatność Rozpoczęta'
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontFamily: 'GloryExtraBold',
                                                  fontSize: 25)),
                                          Text(
                                              'Postępuj zgodnie z instrukcjami wyświetlonymi na terminalu poniżej',
                                              style: TextStyle(
                                                  fontFamily: 'GloryMedium',
                                                  fontSize: 20)),
                                          CircularProgressIndicator(
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
                                            color: Color.fromARGB(
                                                255, 151, 203, 98),
                                            child: Center(
                                                child: Text(
                                                    'Płatność Zaakceptowana'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'GloryExtraBold',
                                                        fontSize: 25))))),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                foregroundColor: Color.fromARGB(
                                                    255, 218, 49, 62),
                                                side: BorderSide(
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
                                            child: Text('Powrót',
                                                style: TextStyle(
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
                                              Color.fromARGB(255, 218, 49, 62),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  'Płatność Anulowana'
                                                      .toUpperCase(),
                                                  style: TextStyle(
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
                                                child: Container(
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
                                                                Color.fromARGB(
                                                                    255, 218, 49, 62),
                                                            side: BorderSide(
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
                                                          provider
                                                              .notifyListeners();
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
                                                        child: Text('Powrót', style: TextStyle(fontSize: 17, fontFamily: 'GloryMedium'))))),
                                            Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.45,
                                                    0,
                                                    0,
                                                    0),
                                                child: Container(
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
                                                              Color.fromARGB(
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
                                                            'Spróbuj ponownie',
                                                            style: TextStyle(
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
                            return Text('snapshot.connectionState');
                          }
                        }))
          ],
        ));
  }
}
