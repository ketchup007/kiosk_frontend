import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:just_audio/just_audio.dart';
import 'package:kiosk_flutter/screens/order_screen.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:kiosk_flutter/screens/qr_code_screen.dart';
import 'package:kiosk_flutter/utils/api/clients/local_backend_client.dart';
import 'package:kiosk_flutter/utils/api/controllers/storage_controller.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:kiosk_flutter/widgets/card/gps_wait_popup.dart';
import 'package:kiosk_flutter/themes/color.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../utils/api/api_constants.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void goToOrderPage(context) {
    if (MediaQuery.of(context).size.height < 1000) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const QrCodeScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: null,
        body: Container(
            decoration: const BoxDecoration(color: Colors.white, image: DecorationImage(image: SVG.Svg('assets/images/background.svg'), fit: BoxFit.cover)),
            child: Column(children: [
              Center(child: LanguageButtons(ribbonHeight: MediaQuery.of(context).size.height * 0.1, ribbonWidth: MediaQuery.of(context).size.width * 0.1)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                      onTapDown: (_) => goToOrderPage(context),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.15, 0, 0),
                              child: SvgPicture.asset('assets/images/MuchiesLogoPlain.svg', width: MediaQuery.of(context).size.width * 0.65)),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.1, 0, 0),
                              child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width * 0.65),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                                          onPressed: () => goToOrderPage(context),
                                          child: FittedBox(child: Text(AppText.current!.touchScreenInfo, maxLines: 1, style: const TextStyle(fontSize: 36, fontFamily: 'GloryMedium'))))))),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                              child: Material(
                                  type: MaterialType.transparency,
                                  child: Ink.image(image: const SVG.Svg('assets/images/touch.svg'), height: MediaQuery.of(context).size.height * 0.2, fit: BoxFit.fitHeight))),
                        ],
                      )),
                ),
              ),
              /*
              Container(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.15, 0, 0),
                  child: SvgPicture.asset('assets/images/MuchiesLogoPlain.svg',
                      width: MediaQuery.of(context).size.width * 0.65)),
              Container(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.1, 0, 0),
                  child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: MediaQuery.of(context).size.width * 0.65),
                      child: InkWell(
                        onTapDown: (_) => goToOrderPage(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.green,
                                foregroundColor: Colors.black),
                              onPressed: () => goToOrderPage(context),
                              child: FittedBox(
                                  child: Text(AppText.current!.touchScreenInfo,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 36, fontFamily: 'GloryMedium'))),),
                        ),
                      ))),
              Container(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                  child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                          onTapDown: (_) => goToOrderPage(context),
                          child: Ink.image(
                            image: const SVG.Svg('assets/images/touch.svg'),
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.fitHeight,)))),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.03, 0),
                  alignment: Alignment.bottomRight,
                  height: MediaQuery.of(context).size.height * 0.22,
                    child:const Text("heh")
                ))

               */
            ])));
  }
}
