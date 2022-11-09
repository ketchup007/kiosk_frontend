import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/main.dart';
import 'package:kiosk_flutter/screens/order_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:kiosk_flutter/widgets/animations/first_screen_robot.dart';
import 'package:kiosk_flutter/widgets/card/gps_wait_popup.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:kiosk_flutter/themes/color.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  void goToOrderPage(context){
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => const OrderScreen()));
  }

  @override
  Widget build(BuildContext context) {
    print("Size: Width - ${MediaQuery.of(context).size.width}, Height - ${MediaQuery.of(context).size.height}");
    print("Screen Density: ${MediaQuery.of(context).devicePixelRatio}");

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
              Center(
                  child: LanguageButtons(
                      ribbonHeight: MediaQuery.of(context).size.height * 0.1,
                      ribbonWidth: MediaQuery.of(context).size.width * 0.1)),
              Container(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.15, 0, 0),
                  child: SvgPicture.asset('assets/images/MuchiesLogoPlain.svg',
                      width: MediaQuery.of(context).size.width * 0.65)),
              Container(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.1, 0, 0),
                  child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: MediaQuery.of(context).size.width * 0.65),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            foregroundColor: Colors.black),
                          onPressed: () {
                            if(MediaQuery.of(context).size.height < 1000){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return GpsWaitPopup(
                                      onPress: () {
                                        goToOrderPage(context);
                                      },
                                    );
                                  });
                            }else{
                              goToOrderPage(context);
                            }
                          },
                          child: FittedBox(
                            child: Text(AppLocalizations.of(context)!.touchScreenInfo,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 36, fontFamily: 'GloryMedium')))))),
              Container(
                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                  child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                          onTap: () {
                            if(MediaQuery.of(context).size.height < 1000){
                              showDialog(context: context,
                                  builder: (context) => GpsWaitPopup(
                                      onPress: () => goToOrderPage(context)));
                            }else{
                              goToOrderPage(context);
                            }
                          },
                          child: Ink.image(
                            image: const SVG.Svg('assets/images/touch.svg'),
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.fitHeight,)))),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.03, 0),
                  alignment: Alignment.bottomRight,
                  height: MediaQuery.of(context).size.height * 0.22,
                    child:const RiveAnimation.asset('assets/animations/robot1.riv',
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.bottomRight)))])));
      }
}
