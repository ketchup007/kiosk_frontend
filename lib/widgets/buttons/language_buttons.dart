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
            child: Container(
                width: ribbonWidth,
                height: ribbonHeight,
                child: IconButton(
                  onPressed: () {},
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, ribbonWidth * 0.1),
                  icon: Image.asset('assets/images/plFlag.png',
                    width: ribbonWidth * 0.85,
                    height: ribbonWidth * 0.85,),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 122, 166),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(ribbonWidth *0.5),
                        bottomRight: Radius.circular(ribbonWidth *0.5))))))),
        Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
                width: ribbonWidth,
                height: ribbonHeight,
                child: IconButton(
                    onPressed: () {},
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, ribbonWidth * 0.1),
                    icon: Image.asset('assets/images/angFlag.png',
                      width: ribbonWidth * 0.85,
                      height: ribbonWidth * 0.85,),
                    style: IconButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 122, 166),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(ribbonWidth *0.5),
                                bottomRight: Radius.circular(ribbonWidth *0.5))))))),
      ],
    );
  }
}
