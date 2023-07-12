import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/widgets/lists/product_list_view.dart';
import 'package:provider/provider.dart';
//import 'package:rive/rive.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../themes/color.dart';
import '../../widgets/buttons/category_buttons.dart';


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
                                padding: EdgeInsets.zero,
                                shape: const CircleBorder(),
                                backgroundColor: AppColors.red),
                              child:Center(
                                  child: FittedBox(
                                      child: Text("X",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))))),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.02, 0, 0),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width*0.55,
                                    child: FittedBox(
                                        child: Text(AppLocalizations.of(context)!.begPopupTitle,
                                          textHeightBehavior: const TextHeightBehavior(
                                            applyHeightToFirstAscent: false,
                                            applyHeightToLastDescent: false,
                                            leadingDistribution: TextLeadingDistribution.even),
                                        style: const TextStyle(
                                          fontFamily: "GloryBold",
                                          fontSize: 77))))),
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.54,
                                  height: MediaQuery.of(context).size.height * 0.06,
                                  child: AutoSizeText(AppLocalizations.of(context)!.begPopupInformation,
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      fontFamily: "GloryMedium",
                                      fontSize: 22
                                    ))))]),
                      ]),
                    Container(
                        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.09, MediaQuery.of(context).size.height*0.01, 0, 0),
                        child: Row(
                          children: [
                            CategoryButton(
                                cardState: 10, //Number to make it not equal
                                onPressed: () {
                                  provider.changeToPizza();
                                  widget.onPress(0);
                                  Navigator.of(context).pop();
                                },
                                number: 1,
                                text: AppLocalizations.of(context)!.pizzaItemLabel),
                            CategoryButton(
                                cardState: 10, //Number to make it not equal
                                onPressed: () {
                                  provider.changeToDrinks();
                                  widget.onPress(1);
                                  Navigator.of(context).pop();
                                },
                                number: 2,
                                text: AppLocalizations.of(context)!.drinksItemLabel),
                            CategoryButton(
                                cardState: 10, //Number to make it not equal
                                onPressed: () {
                                  provider.changeToBox();
                                  widget.onPress(2);
                                  Navigator.of(context).pop();
                                },
                                number: 3,
                                text: AppLocalizations.of(context)!.boxesItemLabel),
                            CategoryButton(
                                cardState: 10, //Number to make it not equal
                                onPressed: () {
                                  provider.changeToSauces();
                                  widget.onPress(3);
                                  Navigator.of(context).pop();
                                },
                                number: 4,
                                text: AppLocalizations.of(context)!.saucesItemLabel)])),
                  Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width > 1000 ? MediaQuery.of(context).size.width * 0.27 : MediaQuery.of(context).size.width * 0.40,
                        child: FittedBox(
                            child:Text(AppLocalizations.of(context)!.productPropositionText,
                              style: const TextStyle(
                                fontFamily: 'GloryExtraBold',
                                fontSize: 30,
                                color: AppColors.mediumBlue))))),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child:SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: ProductList(storage: provider.storageBeg))),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01, 0, 0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width > 1000 ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            provider.getOrderList();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            foregroundColor: Colors.black),
                          child: FittedBox(
                              child: Text(AppLocalizations.of(context)!.goToSummaryButtonLabel,
                                style: const TextStyle(
                                  fontFamily: 'GloryMedium',
                                  fontSize: 25)))))))])))),
            Container(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.195, MediaQuery.of(context).size.width *0.05 - MediaQuery.of(context).size.height*0.02, 0),
                alignment: Alignment.topRight,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Image.asset('assets/images/robotAnimation/orderMenuRobot/newRobotBeg.png',
                      alignment: Alignment.bottomRight,
                      fit: BoxFit.fitHeight)))]));
  }
}