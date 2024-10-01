import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiosk_flutter/common/widgets/background.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/login_screen.dart';
import 'package:kiosk_flutter/screens/start_screen_kiosk.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreenMobile extends StatefulWidget {
  const StartScreenMobile({super.key});

  @override
  State<StatefulWidget> createState() => _MobileStartScreen();
}

class _MobileStartScreen extends State<StartScreenMobile> {
  int state = 0; //0 - undetermined, 1 - login, 2- logged

  @override
  Widget build(context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    if (state == 0) {
      SharedPreferences.getInstance().then((pref) async {
        String? phoneNumber = pref.getString('phone_number');
        String? phoneNumberToken = pref.getString('phone_number_token');

        if (phoneNumber == null && phoneNumberToken == null) {
          setState(() {
            state = 1;
            print("bebe 1");
          });
        } else {
          provider.phoneNumber = phoneNumber!;
          provider.phoneNumberToken = phoneNumberToken!;
          await provider.getloginToken();
          setState(() {
            state = 2;
            print("bebe 2");
          });
        }
      });
    }

    print("state in Mobile menu $state");
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: LanguageButtons(ribbonHeight: MediaQuery.of(context).size.height * 0.1, ribbonWidth: MediaQuery.of(context).size.width * 0.1),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.15, 0, 0),
              child: SvgPicture.asset(
                'assets/images/MuchiesLogoPlain.svg',
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
          ),
          state == 0
              ? const CircularProgressIndicator()
              : state == 1
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            "Login",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    )
                  : state == 2
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: MediaQuery.of(context).size.height * 0.05,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                                  onPressed: () {
                                    SharedPreferences.getInstance().then((prefs) {
                                      prefs.remove('phone_number');
                                      prefs.remove('phone_number_token');

                                      setState(() {
                                        state = 1;
                                      });
                                    });
                                  },
                                  child: const Text(
                                    "Logout",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: MediaQuery.of(context).size.height * 0.05,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreenKiosk()));
                                  },
                                  child: const Text(
                                    "Place Order",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Text("")
        ],
      ),
    );
  }
}
