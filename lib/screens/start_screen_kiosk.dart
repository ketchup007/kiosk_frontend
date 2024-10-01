import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/screens/order_screen.dart';
import 'package:kiosk_flutter/l10n/generated/l10n.dart';
import 'package:kiosk_flutter/screens/qr_code_screen.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:kiosk_flutter/themes/color.dart';

class StartScreenKiosk extends StatefulWidget {
  const StartScreenKiosk({super.key});

  @override
  State<StatefulWidget> createState() => _StartScreenKioskState();
}

class _StartScreenKioskState extends State<StartScreenKiosk> {
  void goToOrderPage(context) {
    if (MediaQuery.of(context).size.height < 1000) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const QrCodeScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          Center(
            child: LanguageButtons(
              ribbonHeight: MediaQuery.of(context).size.height * 0.1,
              ribbonWidth: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () => goToOrderPage(context),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.15, 0, 0),
                      child: SvgPicture.asset('assets/images/MuchiesLogoPlain.svg', width: MediaQuery.of(context).size.width * 0.65),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.1, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                          onPressed: () => goToOrderPage(context),
                          child: Text(
                            AppText.of(context).touchScreenInfo,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontFamily: 'GloryMedium',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                      child: Material(
                        type: MaterialType.transparency,
                        child: Ink.image(
                          image: const svg.Svg('assets/images/touch.svg'),
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
