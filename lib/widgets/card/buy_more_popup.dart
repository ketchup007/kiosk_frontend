import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/widgets/lists/product_list_view.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../themes/color.dart';


class BuyMorePopup extends StatefulWidget{
  final Function onPress;

  const BuyMorePopup({
    Key? key,
    required this.onPress
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _BuyMorePopupState();
}

class _BuyMorePopupState extends State<BuyMorePopup> {
  late MainProvider provider;

  void onPointerDown(PointerEvent){
    print("au");
  }

  @override
  void dispose(){
    super.dispose();
    provider.popupDone = true;
    print("popup dispose");
  }
  
  @override
  Widget build(BuildContext context){
    provider = Provider.of<MainProvider>(context, listen:true);

    return Listener(
      onPointerDown: onPointerDown,
      child:
      Stack(
        children: [
          Center(
            child:  SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.width * 0.03, 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                            height: MediaQuery.of(context).size.width * 0.06,
                            child:ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.red),
                              child: Text("x",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30))))),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.02, 0, 0),
                                child: Text(AppLocalizations.of(context)!.begPopupTitle,
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false,
                                        applyHeightToLastDescent: false,
                                        leadingDistribution: TextLeadingDistribution.even),
                                  style: TextStyle(
                                   fontFamily: "GloryBold",
                                   fontSize: 77))),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.54,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  child: Text(AppLocalizations.of(context)!.begPopupInformation,
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false,
                                      applyHeightToLastDescent: false,
                                      leadingDistribution: TextLeadingDistribution.even),
                                    style: TextStyle(
                                      fontFamily: "GloryMedium",
                                      fontSize: 22
                                    ))))]),
                      ]),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.01, 0, 0),
                        child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.09, 0, MediaQuery.of(context).size.width * 0.01, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.17,
                            child: ElevatedButton(
                              onPressed: () {
                                provider.changeToPizza();
                                widget.onPress(0);
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.lightBlue),
                                shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
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
                                                color: AppColors.darkBlue),
                                            child: Container(
                                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                                child:const Text('1',
                                                    textAlign: TextAlign.start,
                                                    textHeightBehavior: TextHeightBehavior(
                                                        applyHeightToFirstAscent: false,
                                                        applyHeightToLastDescent: false,
                                                        leadingDistribution: TextLeadingDistribution.even),
                                                    style: TextStyle(
                                                        color: AppColors.lightBlue,
                                                        fontFamily: 'GloryExtraBold',
                                                        fontSize: 45))))),
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        height: 35,
                                        child: Text(AppLocalizations.of(context)!.pizzaItemLabel,
                                            textAlign: TextAlign.start,
                                            textHeightBehavior: const TextHeightBehavior(
                                                applyHeightToFirstAscent: false),
                                            style: TextStyle(
                                                color: AppColors.darkBlue,
                                                fontFamily: 'GloryMedium',
                                                fontSize: 21)))])))),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.07,
                                        width: MediaQuery.of(context).size.width * 0.17,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            provider.changeToDrinks();
                                            widget.onPress(1);
                                            Navigator.of(context).pop();
                                          },
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                                backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.lightBlue),
                                                shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
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
                                                            color: AppColors.darkBlue),
                                                        child: Container(
                                                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                                            child:const Text('2',
                                                                textAlign: TextAlign.start,
                                                                textHeightBehavior: TextHeightBehavior(
                                                                    applyHeightToFirstAscent: false,
                                                                    applyHeightToLastDescent: false,
                                                                    leadingDistribution: TextLeadingDistribution.even),
                                                                style: TextStyle(
                                                                    color: AppColors.lightBlue,
                                                                    fontFamily: 'GloryExtraBold',
                                                                    fontSize: 45))))),
                                                Container(
                                                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                    height: 35,
                                                    child: Text(AppLocalizations.of(context)!.drinksItemLabel,
                                                        textAlign: TextAlign.start,
                                                        textHeightBehavior: const TextHeightBehavior(
                                                            applyHeightToFirstAscent: false),
                                                        style: TextStyle(
                                                            color: AppColors.darkBlue,
                                                            fontFamily: 'GloryMedium',
                                                            fontSize: 21)))])))),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.07,
                                        width: MediaQuery.of(context).size.width * 0.17,
                                        child: ElevatedButton(
                                          onPressed: () {
                                          provider.changeToBox();
                                          widget.onPress(2);
                                          Navigator.of(context).pop();
                                        },
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                                backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.lightBlue),
                                                shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
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
                                                          color: AppColors.darkBlue),
                                                      child: Container(
                                                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                                          child:const Text('3',
                                                              textAlign: TextAlign.start,
                                                              textHeightBehavior: TextHeightBehavior(
                                                                  applyHeightToFirstAscent: false,
                                                                  applyHeightToLastDescent: false,
                                                                  leadingDistribution: TextLeadingDistribution.even),
                                                              style: TextStyle(
                                                                  color: AppColors.lightBlue,
                                                                  fontFamily: 'GloryExtraBold',
                                                                  fontSize: 45))))),
                                              Container(
                                                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                  height: 35,
                                                  child: Text(AppLocalizations.of(context)!.boxesItemLabel,
                                                      textAlign: TextAlign.start,
                                                      textHeightBehavior: const TextHeightBehavior(
                                                          applyHeightToFirstAscent: false),
                                                      style: TextStyle(
                                                          color: AppColors.darkBlue,
                                                          fontFamily: 'GloryMedium',
                                                          fontSize: 21)))])))),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.07,
                                        width: MediaQuery.of(context).size.width * 0.17,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            provider.changeToSauces();
                                            widget.onPress(3);
                                            Navigator.of(context).pop();
                                          },
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                                backgroundColor: MaterialStateProperty.resolveWith((states) => AppColors.lightBlue),
                                                shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))))
                                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
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
                                                            color: AppColors.darkBlue),
                                                        child: Container(
                                                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                                            child:const Text('4',
                                                                textAlign: TextAlign.start,
                                                                textHeightBehavior: TextHeightBehavior(
                                                                    applyHeightToFirstAscent: false,
                                                                    applyHeightToLastDescent: false,
                                                                    leadingDistribution: TextLeadingDistribution.even),
                                                                style: TextStyle(
                                                                    color: AppColors.lightBlue,
                                                                    fontFamily: 'GloryExtraBold',
                                                                    fontSize: 45))))),
                                                Container(
                                                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                    height: 35,
                                                    child: Text(AppLocalizations.of(context)!.saucesItemLabel,
                                                        textAlign: TextAlign.start,
                                                        textHeightBehavior: const TextHeightBehavior(
                                                            applyHeightToFirstAscent: false),
                                                        style: TextStyle(
                                                            color: AppColors.darkBlue,
                                                            fontFamily: 'GloryMedium',
                                                            fontSize: 21)))]))))])),
                  Center(
                    child: Text(AppLocalizations.of(context)!.productPropositionText,
                    style: TextStyle(
                        fontFamily: 'GloryExtraBold',
                        fontSize: 30,
                        color: AppColors.mediumBlue)),
                  ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child:SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child:ProductList(storage: provider.storageBeg))),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01, 0, 0),
                        child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.of(context).pop();
                          provider.getOrderList();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            foregroundColor: Colors.black),
                        child: Text(AppLocalizations.of(context)!.goToSummaryButtonLabel,
                            style: const TextStyle(
                                fontFamily: 'GloryMedium',
                                fontSize: 25)),
                      ))))])))),
            Container(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.72, MediaQuery.of(context).size.height * 0.195, 0, 0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child:
                    Image.asset('assets/images/robotAnimation/orderMenuRobot/newRobotBeg.png',
                    alignment: Alignment.bottomLeft,
                    fit: BoxFit.fitHeight)
                    //RiveAnimation.asset(
                    //    'assets/animations/robot1.riv',
                    //    alignment: Alignment.bottomLeft,
                    //    fit: BoxFit.fitHeight)
        ))]));
  }
}