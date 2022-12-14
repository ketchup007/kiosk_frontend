import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/screens/start_screen.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';

import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';
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
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                          controller: codeController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "access code")))),
              state == 0 ? ElevatedButton(
                  onPressed: () {
                    print(codeController.text);
                    ApiService().smsToken(provider.phoneNumber, codeController.text).then((value) {
                      provider.phoneNumberToken = value!;
                      setState(() {
                        state=1;
                      });
                      if(value != "NO_ACCESS"){
                        ApiService().login(provider.phoneNumber, provider.phoneNumberToken).then( (value) {
                          print(value);
                        } );
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => StartScreen()));
                      }
                    });

                  }, child: Text("")) :
                  Text(provider.phoneNumberToken)
            ],
          ),
      )
      ),

    );
  }
}