import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
        child: Center(
          child: Column(
            children: [
              LanguageButtons(
                ribbonHeight: MediaQuery.of(context).size.height * 0.1,
                ribbonWidth: MediaQuery.of(context).size.width * 0.1),

            ],
          ),
      )
      ),

    );
  }
}