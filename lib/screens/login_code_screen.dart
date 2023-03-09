import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';

import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../themes/color.dart';
import '../utils/api/api_service.dart';

class LoginCodeScreen extends StatefulWidget{
  const LoginCodeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginCodeState();
}

class _LoginCodeState extends State<LoginCodeScreen> {
  final codeController = TextEditingController();
  int state = 0;
  @override
  Widget build(context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: SVG.Svg('assets/images/background.svg'),
            fit: BoxFit.cover)),
        child: Center(
          child: Column(
            children: [
              LanguageButtons(
                ribbonHeight: MediaQuery.of(context).size.height * 0.1,
                ribbonWidth: MediaQuery.of(context).size.width * 0.1),
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  child: Text('Po otrzymaniu kodu dostępu, wpisz go w poniższe pole aby dokończyć proces logowania',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "GloryMedium"))),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                          controller: codeController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "kod dostępu")))),
              state == 0 ? Container(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        foregroundColor: Colors.black),
                    onPressed: () {
                      print(codeController.text);
                      ApiService(token: provider.loginToken).smsToken(provider.phoneNumber, codeController.text, url: MyApp.of(context)!.url).then((value) {
                        print("first check $value");
                        if(value != null){
                          provider.phoneNumberToken = value!;
                        }

                        setState(() {
                          state=1;
                        });
                        if(value != "NO_ACCESS"){
                          SharedPreferences.getInstance().then((pref) {
                            pref.setString("phone_number", provider.phoneNumber);
                            pref.setString("phone_number_token", provider.phoneNumberToken);
                          });
                          ApiService(token: provider.loginToken).login(provider.phoneNumber, provider.phoneNumberToken, url: MyApp.of(context)!.url).then( (value) {
                            print("seccond check $value");
                            provider.loginToken = jsonDecode(value!)['token'];
                            //print(value);
                            print(jsonDecode(value!)['token']);
                          } );
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => StartScreen()));
                        }
                      });

                    }, child: Text("zaloguj")),
              ) :
                  Text(provider.phoneNumberToken)
            ],
          ),
      )
      ),

    );
  }
}