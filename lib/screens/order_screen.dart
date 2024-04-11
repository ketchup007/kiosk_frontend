import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/info_screen.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/card/buy_more_popup.dart';
import 'package:provider/provider.dart';
import 'package:kiosk_flutter/widgets/lists/product_list_view.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kiosk_flutter/widgets/card/summary_card.dart';

import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';

import 'package:kiosk_flutter/widgets/buttons/category_buttons.dart';

import 'dart:async';
import 'package:async/async.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _cardState = 0; // 0 = pizza, 1 = drinks, 2 = boxes, 3 = sauces, 4 = summary

  RestartableTimer? timer;
  Timer? timer2;
  late MainProvider provider;

  @override
  void initState() {
    super.initState();
    _timerStart();
    _periodicTimerStart();
  }

  @override
  void dispose(){
    super.dispose();
    timer?.cancel();
  }

  void _periodicTimerStart(){
    timer2?.cancel();
    timer2 = Timer.periodic(const Duration(seconds: 5), (timers) {
      provider.getLimits();
      provider.updateTimeToWait();
      setState(() {});
    });
  }

  void _periodicTimerStop(){
    timer2?.cancel();
  }

  void _resetTimer(PointerEvent details) {
    _timerReset();
  }

  void _timerReset() {
    final check = timer?.isActive;
    if(check!) {
      if (check) {
        timer?.reset();
      }
    }
  }

  void _timerStart(){
    timer?.cancel();
    timer = RestartableTimer(
        const Duration(minutes: 10),
            () {
          _periodicTimerStop();
          print("in timer start");
          provider.orderCancel();
          provider.changeToPizza();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StartScreen())
          );
        });
  }

  void _startTimerLong(){
    timer?.cancel();
    timer = RestartableTimer(
        const Duration(minutes: 30),
            () {
              print("in long timer");
              provider.orderCancel();
              provider.changeToPizza();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StartScreen()));
            });
  }

  void _timerStop(){
    timer?.cancel();
  }

  void cancelButtonAction(){
    _periodicTimerStop();
    _timerStop();
    provider.orderCancel();
    provider.changeToPizza();
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StartScreen()));
  }

  void sumButtonAction(){
    _periodicTimerStop();
    _startTimerLong();
    provider.getOrderList();
    setState(() {
      _cardState = 4;
    });
    if(!provider.popupDone){
      if(provider.sum != 0){
        provider.begStorageSetup();
        showDialog(
            context: context,
            builder: (context) {
              return BuyMorePopup(
                onPress: (number) {
                  setState(() {
                    _cardState = number;
                  });
                },
              );
            });
      }}
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);
    provider.getStorageData(context);
    return Listener(
      onPointerDown: _resetTimer,
      child: Scaffold(
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
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height * 0.14,
                          width: MediaQuery.of(context).size.width * 0.55,
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.06, MediaQuery.of(context).size.height * 0.03, 0, 0),
                          child: GestureDetector(
                            onTap: () { // Safe Space to test things
                              if(MediaQuery.of(context).size.height < 1000){
                                // print("Yey you are on phone");

                              }else {
                                // print("Yey you are on kiosk");
                              }

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const InfoScreen()));

                            },
                            child: SvgPicture.asset('assets/images/MuchiesLogoPlain.svg',
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.fitWidth))),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Przewidywany czas oczekiwania: ${provider.timeToWait} min"),
                        ),
                      ],
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
                                ribbonWidth: MediaQuery.of(context).size.width * 0.05)),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.015, MediaQuery.of(context).size.width * 0.05, 0),
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: const FittedBox(
                                child: Text("Menu",
                              style: TextStyle(
                                fontSize: 60,
                                fontFamily: 'GloryMedium'))))]))]),
//------------------------------------------------------------------------------
//Sekcja Przycisków
//------------------------------------------------------------------------------
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.123, MediaQuery.of(context).size.height > 1000? MediaQuery.of(context).size.width * 0.065 : MediaQuery.of(context).size.width * 0.055, 0),
                  child:  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.11,
                    child: const Text("tu powinna być animacja")//RiveAnimation.asset(
                    //  'assets/animations/newBody.riv',//Ri
                  //    alignment: Alignment.bottomRight,)
                  )),
                Container(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.055, MediaQuery.of(context).size.height * 0.20, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      EdgeCategoryButton(
                          cardState: _cardState,
                          onPressed: () {
                            if(provider.inPayment != true) {
                              _periodicTimerStart();
                              _timerStart();
                              provider.changeToPizza();
                              setState(() {
                                _cardState = 0;
                              });
                            }},
                          number: 1,
                          text: AppLocalizations.of(context)!.pizzaItemLabel),
                      CategoryButton(
                        cardState: _cardState,
                        text: AppLocalizations.of(context)!.drinksItemLabel,
                        number: 2,
                        onPressed: () {
                            if(provider.inPayment != true) {
                              _periodicTimerStart();
                              _timerStart();
                              provider.changeToDrinks();
                              setState( () {
                                _cardState = 1;
                              });
                            }},
                      ),
                      CategoryButton(
                        cardState: _cardState,
                        text: AppLocalizations.of(context)!.boxesItemLabel,
                        number: 3,
                        onPressed: () {
                          if(provider.inPayment != true) {
                            _periodicTimerStart();
                            _timerStart();
                            provider.changeToBox();
                            setState( () {
                              _cardState = 2;
                            });
                          }},
                      ),
                      CategoryButton(
                        cardState: _cardState,
                        text: AppLocalizations.of(context)!.saucesItemLabel,
                        number: 4,
                        onPressed: () {
                          if(provider.inPayment != true) {
                            _periodicTimerStart();
                            _timerStart();
                            provider.changeToSauces();
                            setState( () {
                              _cardState = 3;
                            });
                          }},
                      ),
                      ConfirmCategoryButton(
                          cardState: _cardState,
                          onPressed: () {
                            if(provider.inPayment != true) {
                              _periodicTimerStop();
                              _startTimerLong();
                              provider.changeToPizza();
                              setState(() {
                                provider.getOrderList();
                                _cardState = 4;
                              });

                              if(!provider.popupDone){
                                if(provider.sum != 0){
                                  provider.begStorageSetup();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return BuyMorePopup(
                                            onPress: (number) {
                                              setState(() {
                                                _cardState = number;
                                              });
                                            });
                                      });
                                }}}},
                          number: 5,
                          text: AppLocalizations.of(context)!.summaryButtonLabel)])),
                      Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.123, MediaQuery.of(context).size.height > 1000? MediaQuery.of(context).size.width * 0.065 : MediaQuery.of(context).size.width * 0.055, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.11,
                              child: const Text("tu powinna być animacja")//RiveAnimation.asset(
                            //    'assets/animations/newArms.riv',
                          //      alignment: Alignment.bottomRight)
                          )),
//------------------------------------------------------------------------------
//Sekcja stopki
//------------------------------------------------------------------------------
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.9, 0, 0),
                    width: MediaQuery.of(context).size.width > 1000 ? MediaQuery.of(context).size.width * 0.89 : MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.height > 1000? MediaQuery.of(context).size.width * 0.18: MediaQuery.of(context).size.width * 0.25,
                              child: Visibility(
                                visible: !provider.inPayment,
                                maintainState: true,
                                maintainSize: true,
                                maintainAnimation: true,
                                child: InkWell(
                                  onTapDown: (_) {
                                    cancelButtonAction();
                                  },
                                  child: ElevatedButton(
                                    onPressed: () {
                                        cancelButtonAction();
                                      },
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                      backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.red),
                                      shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))))
                                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.02),
                                      child: FittedBox(child:Text(AppLocalizations.of(context)!.cancelButtonLabel,
                                        style: const TextStyle(
                                          fontFamily: 'GloryExtraBold',
                                          fontSize: 18))))),
                                ))),
                            Container(
                              width: MediaQuery.of(context).size.height > 1000? MediaQuery.of(context).size.width * 0.18 + 2 : MediaQuery.of(context).size.width * 0.25 + 2,
                              height: MediaQuery.of(context).size.height * 0.021,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20))))]),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.015, 0, 0),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.08,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height*0.025,
                                            child: FittedBox(child: Text(AppLocalizations.of(context)!.orderTotalText,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'GloryLight')))),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height*0.04,
                                            child: FittedBox(child: Text('${provider.sum.toStringAsFixed(2)} zł',
                                              textHeightBehavior: const TextHeightBehavior(
                                                applyHeightToFirstAscent: false,
                                                applyHeightToLastDescent: false,
                                                leadingDistribution: TextLeadingDistribution.even
                                              ),
                                              style: const TextStyle(
                                                fontSize: 40,
                                                fontFamily: 'GloryBold',
                                              )))),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * 0.015 ,
                                                width: MediaQuery.of(context).size.width * 0.35,
                                                child: FittedBox(child: Text(AppLocalizations.of(context)!.paymentConformationText,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'GloryLightItalic'))))]))),
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.08,
                                          width: MediaQuery.of(context).size.height > 1000? MediaQuery.of(context).size.width * 0.18: MediaQuery.of(context).size.width * 0.25,
                                          child: Visibility(
                                            visible: !provider.inPayment,
                                            maintainState: true,
                                            maintainSize: true,
                                            maintainAnimation: true,
                                            child:InkWell(
                                              onTapDown: (_) {
                                                sumButtonAction();
                                              },
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  sumButtonAction();
                                                  },
                                                style: ButtonStyle(
                                                  foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                                  backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.green),
                                                  shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))))
                                                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                                                child: Container(
                                                  alignment: Alignment.bottomCenter,
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height * 0.02),
                                                  child: FittedBox(child: Text(AppLocalizations.of(context)!.summaryButtonLabel,
                                                    style: const TextStyle(
                                                      fontFamily: 'GloryExtraBold',
                                                      fontSize: 18))))),
                                            ))),
                                        Container(
                                          width: MediaQuery.of(context).size.height > 1000? MediaQuery.of(context).size.width * 0.18 + 2: MediaQuery.of(context).size.width * 0.25+2,
                                          height: MediaQuery.of(context).size.height * 0.021,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(20))))])]))),
                Container(
                        alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height* 0.27, 0, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.65,
                            width: MediaQuery.of(context).size.width > 1000 ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width * 0.91,
                            child: _cardState == 4 ? SummaryCard(
                              onInteraction: () {
                                timer?.reset();
                              },
                              onPopUpFinish: () {
                                _timerStop();
                              }) :
                              Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: AppColors.mediumBlue),
                                  borderRadius: BorderRadius.circular(20)),
                                elevation: 6,
                                surfaceTintColor: Colors.white,
                                child: provider.loading ? Center(
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      height: MediaQuery.of(context).size.width * 0.5,
                                      child:const CircularProgressIndicator(strokeWidth: 5, color: AppColors.mediumBlue))) :
                                ProductList(storage: provider.storageCurrent))))])]))));
  }
}