import 'package:flutter/material.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/buttons/num_pad.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';

class PhonePopupCard extends StatefulWidget{
  final Function onPress;
  final Function onInteraction;

  const PhonePopupCard({
    Key? key,
    required this.onPress,
    required this.onInteraction
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _PhonePopupCardState();
}


class _PhonePopupCardState extends State<PhonePopupCard> {
  bool isCheckedMain = false;
  bool isCheckedA = false;
  bool isCheckedB = false;
  bool isCheckedC = false;
  final TextEditingController _myController = TextEditingController();

  void onPointerDown(PointerEvent){
    print("dumpc");
    widget.onInteraction();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    return Listener(
      onPointerDown: onPointerDown,
      child: Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01, 0, 0),
                child: Text(AppLocalizations.of(context)!.enterPhoneNumberText.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: "GloryMedium"))),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child:  TextField(
                  controller: _myController,
                  showCursor: false,
                  keyboardType: TextInputType.none,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'GloryBold'))),
              Container(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.01, 0, MediaQuery.of(context).size.height*0.02),
                child: NumPad(controller: _myController)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0, 0, 0),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: AppColors.green,
                              checkColor: Colors.transparent,
                              side: MaterialStateBorderSide.resolveWith( (states) => const BorderSide(width: 1.5, color: AppColors.green)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                              value: isCheckedMain,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedMain = value!;
                                  if(value == true){
                                    isCheckedA = true;
                                    isCheckedB = true;
                                    isCheckedC = true;
                                  }else{
                                    isCheckedA = false;
                                    isCheckedB = false;
                                    isCheckedC = false;
                                  }});
                              })),
                          Text(AppLocalizations.of(context)!.selectAllCheckText,
                            style: const TextStyle(
                              fontFamily: "GloryMedium",
                              fontSize: 16))]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: AppColors.green,
                                checkColor: Colors.transparent,
                                side: MaterialStateBorderSide.resolveWith( (states) => const BorderSide(width: 1.5, color: AppColors.green)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                                value: isCheckedA,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedA = value!;
                                    if(isCheckedA == true && isCheckedB == true && isCheckedC == true){
                                      isCheckedMain = true;
                                    }else{
                                      isCheckedMain = false;
                                    }});
                                })),
                          Text(AppLocalizations.of(context)!.requiredCheckText,
                            style: const TextStyle(
                             fontFamily: "GloryMedium",
                                fontSize: 16))]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: AppColors.green,
                                checkColor: Colors.transparent,
                                side: MaterialStateBorderSide.resolveWith( (states) => const BorderSide(width: 1.5, color: AppColors.green)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                                value: isCheckedB,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedB = value!;

                                    if(isCheckedA == true && isCheckedB == true && isCheckedC == true){
                                      isCheckedMain = true;
                                    }else{
                                      isCheckedMain = false;
                                    }});
                                })),
                          Text(AppLocalizations.of(context)!.promotionCheckText,
                            style: const TextStyle(
                              fontFamily: "GloryMedium",
                              fontSize: 16))]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: AppColors.green,
                                checkColor: Colors.transparent,
                                side: MaterialStateBorderSide.resolveWith( (states) => const BorderSide(width: 1.5, color: AppColors.green)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                                value: isCheckedC,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedC = value!;

                                if(isCheckedA == true && isCheckedB == true && isCheckedC == true){
                                  isCheckedMain = true;
                                }else{
                                  isCheckedMain = false;
                                }});
                            })),
                          Text(AppLocalizations.of(context)!.optionalCheckText,
                            style: const TextStyle(
                              fontFamily: "GloryMedium",
                              fontSize: 16))])])),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.035, MediaQuery.of(context).size.width * 0.05, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                        onPressed: () {
                          if(isCheckedA == true && _myController.text.length == 11){
                            Navigator.of(context).pop();
                            provider.order.client_name = _myController.text.substring(0,3) + _myController.text.substring(4,7) + _myController.text.substring(8);
                            widget.onPress(isCheckedB);
                          }},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          foregroundColor: Colors.black),
                        child: Text(AppLocalizations.of(context)!.confirmButtonLabel,
                            style: const TextStyle(
                                fontFamily: 'GloryBold',
                                fontSize: 30)))))])])))));
  }
}