import 'package:flutter/material.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:provider/provider.dart';

import 'package:kiosk_flutter/main.dart';

class LanguageButtons extends StatelessWidget {
  final ribbonHeight;
  final ribbonWidth;

  const LanguageButtons(
      {Key? key, required this.ribbonHeight, required this.ribbonWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: false);

    changeLanguage(String code) {
      MyApp.of(context)?.setLocale(Locale.fromSubtags(languageCode: code));
      provider.changeLanguage(context);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTapDown: (_) {
            changeLanguage("pl");
          },
          child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: SizedBox(
                  width: ribbonWidth,
                  height: ribbonHeight,
                  child: IconButton(
                    onPressed: () {
                      changeLanguage("pl");
                    },
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, ribbonWidth * 0.1),
                    icon: Image.asset('assets/images/plFlag.png',
                      width: ribbonWidth * 0.85,
                      height: ribbonWidth * 0.85,),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(ribbonWidth *0.5),
                          bottomRight: Radius.circular(ribbonWidth *0.5))))))),
        ),
        InkWell(
          onTapDown: (_) {
            changeLanguage("en");
          },
          child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                  width: ribbonWidth,
                  height: ribbonHeight,
                  child: IconButton(
                      onPressed: () {
                        changeLanguage('en');
                      },
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, ribbonWidth * 0.1),
                      icon: Image.asset('assets/images/angFlag.png',
                        width: ribbonWidth * 0.85,
                        height: ribbonWidth * 0.85,),
                      style: IconButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(ribbonWidth *0.5),
                                  bottomRight: Radius.circular(ribbonWidth *0.5))))))),
        )]);
  }
}
