import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:http/http.dart' as http;
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/main.dart';

import 'package:kiosk_flutter/widgets/lists/product_list_view.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/screens/sum_screen.dart';
import 'package:kiosk_flutter/models/storage_model.dart';
import 'package:kiosk_flutter/utils/fetch_json.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kiosk_flutter/widgets/card/summary_card.dart';

import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _cardState = 0; // 0 = pizza, 1 = drinks, 2 = boxes, 3 = sauces, 4 = summary

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);
    provider.getStorageData();
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
            Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.09, MediaQuery.of(context).size.height * 0.03, 0, 0),
                      child: SvgPicture.asset(
                        'assets/images/MuchiesLogoPlain.svg',
                        height: MediaQuery.of(context).size.height * 0.12)
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.08, 0),
                            child:
                              LanguageButtons(
                                ribbonHeight: MediaQuery.of(context).size.height * 0.05,
                                ribbonWidth: MediaQuery.of(context).size.width * 0.05
                              )
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.015, MediaQuery.of(context).size.width * 0.05, 0),
                            child: const Text(
                              "Menu",
                              style: TextStyle(
                                fontSize: 60,
                                fontFamily: 'GloryMedium'
                               )
                            )
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.123, MediaQuery.of(context).size.width * 0.065, 0),
                  child: Image.asset(
                    'assets/images/robotAnimation/orderMenuRobot/newRobotBack.png',
                    height: MediaQuery.of(context).size.height * 0.11
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.055, MediaQuery.of(context).size.height * 0.20, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.18,
                            padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                  backgroundColor: MaterialStateProperty.resolveWith((states) => _cardState == 0 ? const Color.fromARGB(255, 86, 197, 208) : const Color.fromARGB(255, 146, 214, 227)),
                                  shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                onPressed: () {
                                  if(provider.inPayment != true) {
                                    provider.changeToPizza();
                                    setState(() {
                                      _cardState = 0;
                                    });
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(255, 29, 152, 170)
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                          child:Text('1',
                                            textAlign: TextAlign.start,
                                            textHeightBehavior: const TextHeightBehavior(
                                              applyHeightToFirstAscent: false,
                                              applyHeightToLastDescent: false,
                                              leadingDistribution: TextLeadingDistribution.even
                                            ),
                                            style: TextStyle(
                                              color: _cardState == 0 ? Colors.white : const Color.fromARGB(255, 146, 214, 227),
                                              fontFamily: 'GloryExtraBold',
                                              fontSize: 45
                                            )
                                          )
                                        )
                                              ),
                                            ),
                                            Container(
                                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                height: 35,
                                                child: Text(AppLocalizations.of(context)!.pizzaItemLabel,
                                                    textAlign: TextAlign.start,
                                                    textHeightBehavior: const TextHeightBehavior(
                                                        applyHeightToFirstAscent: false
                                                    ),
                                                    style: TextStyle(
                                                        color: _cardState == 0 ? Colors.white : const Color.fromARGB(255, 29, 152, 170),
                                                        fontFamily: _cardState == 0 ? 'GloryExtraBold' : 'GloryMedium',
                                                        fontSize: 21
                                                    )
                                                )
                                            )
                                          ],
                                        )
                                    )
                                ),
                                    Visibility(
                                        visible: _cardState != 0,
                                        maintainState: true,
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        child: Container(
                                        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.07, 0, 0),
                                        child: Container(
                                        width: MediaQuery.of(context).size.width * 0.17,
                                        height: MediaQuery.of(context).size.height * 0.05,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(18)
                                          )
                                        ),))),]),
                                Container(
                                    height: _cardState == 1 ? MediaQuery.of(context).size.height * 0.10 : MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width * 0.18,
                                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                            backgroundColor: MaterialStateProperty.resolveWith((states) => _cardState == 1 ? const Color.fromARGB(255, 86, 197, 208) : const Color.fromARGB(255, 146, 214, 227)),
                                            shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                        onPressed: () {
                                          if(provider.inPayment != true) {
                                            provider.changeToDrinks();
                                            setState(() {
                                              _cardState = 1;
                                            });
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromARGB(255, 29, 152, 170)
                                                  ),
                                                  child: Container(
                                                      padding: const EdgeInsets.fromLTRB(14, 0, 0, 5),
                                                      child:Text('2',
                                                          textAlign: TextAlign.start,
                                                          textHeightBehavior: const TextHeightBehavior(
                                                              applyHeightToFirstAscent: false,
                                                              applyHeightToLastDescent: false,
                                                              leadingDistribution: TextLeadingDistribution.even
                                                          ),

                                                          style: TextStyle(
                                                              color: _cardState == 1 ? Colors.white : const Color.fromARGB(255, 146, 214, 227),
                                                              fontFamily: 'GloryExtraBold',
                                                              fontSize: 45
                                                          )
                                                      ))
                                              ),
                                            ),
                                            Container(
                                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                height: 35,
                                                child: Text(AppLocalizations.of(context)!.drinksItemLabel,
                                                    textAlign: TextAlign.start,
                                                    textHeightBehavior: const TextHeightBehavior(
                                                        applyHeightToFirstAscent: false
                                                    ),
                                                    style: TextStyle(
                                                        color: _cardState == 1 ? Colors.white : const Color.fromARGB(255, 29, 152, 170),
                                                        fontFamily: _cardState == 1 ? 'GloryExtraBold' : 'GloryMedium',
                                                        fontSize: 21
                                                    )
                                                )
                                            )
                                          ],
                                        )
                                    )),
                                Container(
                                    height: _cardState == 2 ? MediaQuery.of(context).size.height * 0.10 : MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width * 0.18,
                                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                            backgroundColor: MaterialStateProperty.resolveWith((states) => _cardState == 2 ? const Color.fromARGB(255, 86, 197, 208) : const Color.fromARGB(255, 146, 214, 227)),
                                            shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                        onPressed: () {
                                          if(provider.inPayment != true) {
                                            provider.changeToBox();
                                            setState(() {
                                              _cardState = 2;
                                            });
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromARGB(255, 29, 152, 170)
                                                  ),
                                                  child: Container(
                                                      padding: const EdgeInsets.fromLTRB(13, 0, 0, 5),
                                                      child:Text('3',
                                                          textAlign: TextAlign.start,
                                                          textHeightBehavior: const TextHeightBehavior(
                                                              applyHeightToFirstAscent: false,
                                                              applyHeightToLastDescent: false,
                                                              leadingDistribution: TextLeadingDistribution.even
                                                          ),

                                                          style: TextStyle(
                                                              color: _cardState == 2 ? Colors.white : const Color.fromARGB(255, 146, 214, 227),
                                                              fontFamily: 'GloryExtraBold',
                                                              fontSize: 45
                                                          )
                                                      ))
                                              ),
                                            ),
                                            Container(
                                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                height: 35,
                                                child: Text(AppLocalizations.of(context)!.boxesItemLabel,
                                                    textAlign: TextAlign.start,
                                                    textHeightBehavior: const TextHeightBehavior(
                                                        applyHeightToFirstAscent: false
                                                    ),
                                                    style: TextStyle(
                                                        color: _cardState == 2 ? Colors.white : const Color.fromARGB(255, 29, 152, 170),
                                                        fontFamily: _cardState == 2 ? 'GloryExtraBold' : 'GloryMedium',
                                                        fontSize: 21
                                                    )
                                                )
                                            )
                                          ],
                                        )
                                    )),
                                Container(
                                    height: _cardState == 3 ? MediaQuery.of(context).size.height * 0.10 : MediaQuery.of(context).size.height * 0.07,
                                    width: MediaQuery.of(context).size.width * 0.18,
                                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                            backgroundColor: MaterialStateProperty.resolveWith((states) => _cardState == 3 ? const Color.fromARGB(255, 86, 197, 208) : const Color.fromARGB(255, 146, 214, 227)),
                                            shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                        onPressed: () {
                                          if(provider.inPayment != true) {
                                            provider.changeToSauces();
                                            setState(() {
                                              _cardState = 3;
                                            });
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromARGB(255, 29, 152, 170)
                                                  ),
                                                  child: Container(
                                                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 5),
                                                      child:Text('4',
                                                          textAlign: TextAlign.start,
                                                          textHeightBehavior: const TextHeightBehavior(
                                                              applyHeightToFirstAscent: false,
                                                              applyHeightToLastDescent: false,
                                                              leadingDistribution: TextLeadingDistribution.even
                                                          ),

                                                          style: TextStyle(
                                                              color: _cardState == 3 ? Colors.white : const Color.fromARGB(255, 146, 214, 227),
                                                              fontFamily: 'GloryExtraBold',
                                                              fontSize: 45
                                                          )
                                                      ))
                                              ),
                                            ),
                                            Container(
                                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                height: 35,
                                                child:  Text(AppLocalizations.of(context)!.saucesItemLabel,
                                                    textAlign: TextAlign.start,
                                                    textHeightBehavior: const TextHeightBehavior(
                                                        applyHeightToFirstAscent: false
                                                    ),
                                                    style: TextStyle(
                                                        color: _cardState == 3 ? Colors.white : const Color.fromARGB(255, 29, 152, 170),
                                                        fontFamily: _cardState == 3 ? 'GloryExtraBold' : 'GloryMedium',
                                                        fontSize: 21
                                                    )
                                                )
                                            )
                                          ],
                                        ))),
                                Stack(children:[Container(
                                    height: MediaQuery.of(context).size.height * 0.10,
                                    width: MediaQuery.of(context).size.width * 0.18,
                                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                            backgroundColor: MaterialStateProperty.resolveWith((states) => const Color.fromARGB(255, 151, 203, 98)),
                                            shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                        onPressed: () {
                                          if(provider.inPayment != true) {
                                            provider.changeToPizza();
                                            setState(() {
                                              provider.getOrderList();
                                              _cardState = 4;
                                            });
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                              child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color.fromARGB(255, 89, 162, 38)
                                                  ),
                                                  child: Container(
                                                      padding: const EdgeInsets.fromLTRB(14, 0, 0, 5),
                                                      child:Text('5',
                                                          textAlign: TextAlign.start,
                                                          textHeightBehavior: const TextHeightBehavior(
                                                              applyHeightToFirstAscent: false,
                                                              applyHeightToLastDescent: false,
                                                              leadingDistribution: TextLeadingDistribution.even
                                                          ),

                                                          style: TextStyle(
                                                              color: _cardState == 4 ? Colors.white : const Color.fromARGB(255, 151, 203, 98),
                                                              fontFamily: 'GloryExtraBold',
                                                              fontSize: 45
                                                          )
                                                      ))
                                              ),
                                            ),
                                            Container(
                                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                                height: 35,
                                                child:  Text('Podsumowanie',
                                                    textAlign: TextAlign.start,
                                                    textHeightBehavior: const TextHeightBehavior(
                                                        applyHeightToFirstAscent: false
                                                    ),
                                                    style: TextStyle(
                                                        color: _cardState == 4 ? Colors.white : const Color.fromARGB(255, 89, 162, 38),
                                                        fontFamily: _cardState == 4 ? 'GloryExtraBold' : 'GloryMedium',
                                                        fontSize: 17
                                                    )
                                                )
                                            )
                                          ],
                                        ))),
                                  Visibility(
                                      visible: _cardState != 4,
                                      maintainState: true,
                                      maintainSize: true,
                                      maintainAnimation: true,
                                      child: Container(
                                          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.07, 0, 0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.17,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(18)
                                                )
                                            ),)))
                                ]),
                              ]
                          )
                      ),
                      Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.123, MediaQuery.of(context).size.width * 0.065, 0),
                          child: Image.asset(
                              'assets/images/robotAnimation/orderMenuRobot/newRobotArms.png',
                              height: MediaQuery.of(context).size.height * 0.11)
                      ),
                      Center(
                          child:
                          Container(
                            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.9, 0, 0),
                              width: MediaQuery.of(context).size.width * 0.89,
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      width: MediaQuery.of(context).size.width * 0.18,
                                      child: Visibility(
                                        visible: !provider.inPayment,
                                        maintainState: true,
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                                backgroundColor: MaterialStateProperty.resolveWith((states) => const Color.fromARGB(255, 218, 49, 62)),
                                                shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))))
                                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                            onPressed: () {
                                              provider.orderCancel();
                                              provider.changeToPizza();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => const StartScreen())
                                              );
                                            },
                                            child:
                                            Container(
                                                alignment: Alignment.bottomCenter,
                                                padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.02),
                                                child:Text(AppLocalizations.of(context)!.cancelButtonLabel,
                                                style: const TextStyle(
                                                    fontFamily: 'GloryMedium',
                                                    fontSize: 18
                                                )))
                                        ),
                                      )
                                  ), Container(
                                        width: MediaQuery.of(context).size.width * 0.18 + 2,
                                        height: MediaQuery.of(context).size.height * 0.021,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20)
                                          )
                                        )
                                     )
                                    ]
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.02, 0, 0),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text('Suma zamówienia:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'GloryLight'
                                          )
                                        ),
                                        Text('${provider.sum.toStringAsFixed(2)} zł',
                                          style: const TextStyle(
                                            fontSize: 40,
                                            fontFamily: 'GloryBold',
                                          ),
                                          textHeightBehavior: const TextHeightBehavior(
                                              applyHeightToFirstAscent: false,
                                              applyHeightToLastDescent: false,
                                              leadingDistribution: TextLeadingDistribution.even
                                          ),
                                        ),
                                        const Text('System nie wydaje potwierdzeń płatności',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'GloryLightItalic'
                                          )
                                        )
                                    ],
                                  )),
                                  Stack(
                                    children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.08,
                                    width: MediaQuery.of(context).size.width * 0.18,
                                    child: Visibility(
                                        visible: !provider.inPayment,
                                        maintainState: true,
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        child:ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                                backgroundColor: MaterialStateProperty.resolveWith((states) => const Color.fromARGB(255, 151, 203, 98)),
                                                shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))))
                                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                            onPressed: () {
                                              provider.getOrderList();
                                              setState(() {
                                                _cardState = 4;
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.02),
                                              child:const Text('Podsumowanie',
                                                style: TextStyle(
                                                    fontFamily: 'GloryExtraBold',
                                                    fontSize: 18
                                                )))
                                        )),
                                  ), Container(
                                          width: MediaQuery.of(context).size.width * 0.18 + 2,
                                          height: MediaQuery.of(context).size.height * 0.021,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(20)
                                              )
                                          )
                                      )
                                    ],
                                  )
                                ],
                              )
                          )
                      ),
                      Container(
                        alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height* 0.27, 0, 0),
                          child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.65,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: _cardState == 4 ? SummaryCard() : Card(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 86, 197, 208),
                                  ),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              elevation: 6,
                              surfaceTintColor: Colors.white,
                              child:
                              provider.loading ?
                                Center( child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.width * 0.5,
                                    child:const CircularProgressIndicator(strokeWidth: 5, color: Color.fromARGB(255, 86, 197, 208)))) :
                              ProductList(storage: provider.storageCurrent)
                          )
                      )),
                    ]
            )
                ],
            ),
        )
    );
  }
}