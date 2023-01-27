import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;

class PayUTopBar extends StatefulWidget{
  final Function onPress;
  double amount;
  
  PayUTopBar({
    Key? key,
    required this.onPress,
    required this.amount
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _PayUTopBar();
}

class _PayUTopBar extends State<PayUTopBar> {

  @override
  Widget build(context){

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.lime)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.2,
            child: GestureDetector(
              onTap: () {
                widget.onPress();
              },
              child: const Text("<",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.lime,
                  fontSize: 60)))),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Image.asset('assets/images/payULogos/payULogoLime.png')),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text("${widget.amount.toStringAsFixed(2)} zł",
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.darkGreen,
                fontSize: 20)))]));
  }
}
