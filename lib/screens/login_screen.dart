import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/screens/register_screen.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LanguageButtons(
                ribbonHeight: MediaQuery.of(context).size.height * 0.1,
                ribbonWidth: MediaQuery.of(context).size.width * 0.1,)),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: loginController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                      hintText: "Phone number")))),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  print("login: ${loginController.text}, password: ${passwordController.text}");
                },
                child: const Text("Login")),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
                },
                child: const Text("Register")),
            )

          ]
        )
      ),
    );
  }
}