import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:kiosk_flutter/widgets/mobile_payment.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;

import '../../widgets/bars/payu_top_bar.dart';

class PayUScreen extends StatefulWidget {
  const PayUScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PayUScreenState();
}

class _PayUScreenState extends State<PayUScreen> {
  late MainProvider provider;
  @override
  Widget build(context){
    provider = Provider.of<MainProvider>(context, listen:true);
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
          children: [
            PayUTopBar(
              onPress: () => Navigator.pop(context),
              amount: provider.sum,),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.75,
                child: MobilePayment(amount: provider.sum)))

          ])));
  }
}