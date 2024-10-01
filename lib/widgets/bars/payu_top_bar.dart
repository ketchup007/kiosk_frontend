import 'package:flutter/material.dart';
import 'package:kiosk_flutter/themes/color.dart';

class PayUTopBar extends StatefulWidget {
  final Function onPress;
  final double amount;

  const PayUTopBar({super.key, required this.onPress, required this.amount});

  @override
  State<StatefulWidget> createState() => _PayUTopBar();
}

class _PayUTopBar extends State<PayUTopBar> {
  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.lime)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: GestureDetector(
              onTap: () {
                widget.onPress();
              },
              child: const Text(
                "<",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.lime,
                  fontSize: 60,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Image.asset('assets/images/payULogos/payULogoLime.png'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              "${widget.amount.toStringAsFixed(2)} zł",
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: AppColors.darkGreen,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
