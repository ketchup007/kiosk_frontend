import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiosk_flutter/screens/login_screen.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';

import '../themes/color.dart';

class MobileStartScreen extends StatefulWidget {
  const MobileStartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MobileStartScreen();
}

class _MobileStartScreen extends State<MobileStartScreen> {

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: SVG.Svg('assets/images/background.svg'),
            fit: BoxFit.cover)),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: LanguageButtons(
                    ribbonHeight: MediaQuery.of(context).size.height * 0.1,
                    ribbonWidth: MediaQuery.of(context).size.width * 0.1)),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.15, 0, 0),
                child:  SvgPicture.asset('assets/images/MuchiesLogoPlain.svg',
                    width: MediaQuery.of(context).size.width * 0.65))),
            Container(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        foregroundColor: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen())
                      );
                    },
                    child: Text("Login",
                            textAlign: TextAlign.center,
                            maxLines: 1)))),
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            foregroundColor: Colors.black),
                        onPressed: () {},
                        child: Text("Choose Container",
                            textAlign: TextAlign.center,
                            maxLines: 1)))),
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            foregroundColor: Colors.black),
                        onPressed: () {},
                        child: Text("Place Order",
                            textAlign: TextAlign.center)))),

          ])));
  }
}