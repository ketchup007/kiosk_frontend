import 'package:flutter/material.dart';
import 'package:kiosk_flutter/themes/color.dart';

class NumPad extends StatelessWidget{
  final TextEditingController controller;
  final int maxDigit;

  const NumPad({
    Key? key,
    required this.controller,
    required this.maxDigit
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width *0.01, 0),
                  child: NumberButton(number: 1, controller: controller, maxDigit: maxDigit)),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width *0.01, 0),
                  child: NumberButton(number: 2, controller: controller, maxDigit: maxDigit)),
                NumberButton(number: 3, controller: controller, maxDigit: maxDigit)]),
            Container(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * 0.01, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width *0.01, 0),
                    child: NumberButton(number: 4, controller: controller, maxDigit: maxDigit)),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width *0.01, 0),
                    child: NumberButton(number: 5, controller: controller, maxDigit: maxDigit)),
                  NumberButton(number: 6, controller: controller, maxDigit: maxDigit)])),
            Container(
                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width *0.01, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width *0.01, 0),
                      child: NumberButton(number: 7, controller: controller, maxDigit: maxDigit)),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width *0.01, 0),
                      child: NumberButton(number: 8, controller: controller, maxDigit: maxDigit)),
                    NumberButton(number: 9, controller: controller, maxDigit: maxDigit)])),
            Container(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * 0.01, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width*0.01, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.14,
                      width: MediaQuery.of(context).size.width * 0.14,
                      child: ElevatedButton(
                        onPressed: () {
                          if(controller.text.isNotEmpty){
                            controller.text = controller.text.substring(0, controller.text.length -1);
                          }},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        child: const Icon(Icons.backspace_outlined,
                          color: Colors.white,
                          size: 60)))),
                  NumberButton(number: 0, controller: controller, maxDigit: maxDigit)]))]));
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final TextEditingController controller;
  final int maxDigit;

  const NumberButton({
    Key? key,
    required this.number,
    required this.controller,
    required this.maxDigit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.14,
      width: MediaQuery.of(context).size.width * 0.14,
      child: ElevatedButton(
        onPressed: () {
          if(controller.text.length < maxDigit){
            controller.text += number.toString();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20))),
        child: Text(number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "GloryBold",
            fontSize: 60))));
  }
}