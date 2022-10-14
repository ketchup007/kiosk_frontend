import 'package:flutter/material.dart';

import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/providers/main_provider.dart';
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                    onTap: () {
                      MyApp.of(context)?.setLocale(
                          const Locale.fromSubtags(languageCode: 'pl'));
                      provider.changeLanguage(context);
                    },
                    child: Ink.image(
                      image: const SVG.Svg('assets/images/polandFlag.svg'),
                      height: ribbonHeight,
                      width: ribbonWidth,
                      fit: BoxFit.cover,
                    )))),
        Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                    onTap: () {
                      MyApp.of(context)?.setLocale(
                          const Locale.fromSubtags(languageCode: 'en'));
                      provider.changeLanguage(context);
                    },
                    child: Ink.image(
                      image: const SVG.Svg('assets/images/angFlag.svg'),
                      height: ribbonHeight,
                      width: ribbonWidth,
                      fit: BoxFit.cover,
                    )))),
      ],
    );
  }
}
