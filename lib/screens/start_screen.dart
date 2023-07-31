
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:just_audio/just_audio.dart';
import 'package:kiosk_flutter/main.dart';
import 'package:kiosk_flutter/screens/order_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kiosk_flutter/screens/qr_code_screen.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:kiosk_flutter/widgets/card/gps_wait_popup.dart';
//import 'package:lottie/lottie.dart';
//import 'package:rive/rive.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../utils/api/api_constants.dart';

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

  test() async {
    var file = await DefaultCacheManager().getFileFromCache(ApiConstants.baseUrl + '/assets/margherita.png');
    // print(file?.file);
  }
  @override
  Widget build(BuildContext context) {
    //print("Size: Width - ${MediaQuery.of(context).size.width}, Height - ${MediaQuery.of(context).size.height}");
    //print("Screen Density: ${MediaQuery.of(context).devicePixelRatio}");
   // test();
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
              ElevatedButton(onPressed: () async {
                print("a");
                final player = AudioPlayer();
                await player.setAsset("assets/audio/moo.mp3");
                print("set");
                player.play();
                //final player = AudioPlayer();
                //player.play(AssetSource("assets/sounds/beep.mp3"));
                print("b");
              }, child: Text("test")),
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
                              /*
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return GpsWaitPopup(
                                      onPress: () {
                                        goToOrderPage(context);
                                      },
                                    );
                                  });
                               */
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const QrCodeScreen()));
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
                    child:const Text("heh") //RiveAnimation.asset('assets/animations/robot1.riv',
                      //fit: BoxFit.fitHeight,
                      //alignment: Alignment.bottomRight)
                ))])));
      }
}
