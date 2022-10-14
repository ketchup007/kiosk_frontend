import 'package:flutter/material.dart';

class numPad extends StatelessWidget{
  final TextEditingController controller;

  const numPad({
    Key? key,
    required this.controller
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            numberButton(number: 1, controller: controller),
            numberButton(number: 2, controller: controller),
            numberButton(number: 3, controller: controller),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            numberButton(number: 4, controller: controller),
            numberButton(number: 5, controller: controller),
            numberButton(number: 6, controller: controller),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            numberButton(number: 7, controller: controller),
            numberButton(number: 8, controller: controller),
            numberButton(number: 9, controller: controller),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  if(controller.text.length > 0){
                    controller.text = controller.text.substring(0, controller.text.length -1);
                  }
                },
                child: Text("X")),
            numberButton(number: 0, controller: controller)
          ],
        )
      ],
    ));
  }

}

class numberButton extends StatelessWidget {
  final int number;
  final TextEditingController controller;

  const numberButton({
    Key? key,
    required this.number,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if(controller.text.length < 9){
            controller.text += number.toString();
          }
        },
        child: Text(number.toString()));
  }

}