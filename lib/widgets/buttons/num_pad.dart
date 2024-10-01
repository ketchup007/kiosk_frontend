import 'package:flutter/material.dart';
import 'package:kiosk_flutter/themes/color.dart';

class NumPad extends StatefulWidget {
  final TextEditingController controller;
  final int maxDigit;
  final double buttonSize;

  const NumPad({
    super.key,
    required this.controller,
    required this.maxDigit,
    required this.buttonSize,
  });

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  late double space;

  @override
  Widget build(BuildContext context) {
    if (widget.buttonSize > MediaQuery.of(context).size.width * 0.15) {
      space = MediaQuery.of(context).size.width * 0.02;
    } else {
      space = MediaQuery.of(context).size.width * 0.01;
    }
    return SizedBox(
      width: 3 * widget.buttonSize + 2 * space,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, space, 0),
                child: NumberButton(
                  number: 1,
                  controller: widget.controller,
                  maxDigit: widget.maxDigit,
                  buttonSize: widget.buttonSize,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, space, 0),
                child: NumberButton(
                  number: 2,
                  controller: widget.controller,
                  maxDigit: widget.maxDigit,
                  buttonSize: widget.buttonSize,
                ),
              ),
              NumberButton(
                number: 3,
                controller: widget.controller,
                maxDigit: widget.maxDigit,
                buttonSize: widget.buttonSize,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, space, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, space, 0),
                  child: NumberButton(
                    number: 4,
                    controller: widget.controller,
                    maxDigit: widget.maxDigit,
                    buttonSize: widget.buttonSize,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, space, 0),
                  child: NumberButton(
                    number: 5,
                    controller: widget.controller,
                    maxDigit: widget.maxDigit,
                    buttonSize: widget.buttonSize,
                  ),
                ),
                NumberButton(
                  number: 6,
                  controller: widget.controller,
                  maxDigit: widget.maxDigit,
                  buttonSize: widget.buttonSize,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, space, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, space, 0),
                  child: NumberButton(
                    number: 7,
                    controller: widget.controller,
                    maxDigit: widget.maxDigit,
                    buttonSize: widget.buttonSize,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, space, 0),
                  child: NumberButton(
                    number: 8,
                    controller: widget.controller,
                    maxDigit: widget.maxDigit,
                    buttonSize: widget.buttonSize,
                  ),
                ),
                NumberButton(
                  number: 9,
                  controller: widget.controller,
                  maxDigit: widget.maxDigit,
                  buttonSize: widget.buttonSize,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, space, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, space, 0),
                  child: DeleteButton(
                    controller: widget.controller,
                    maxDigits: widget.maxDigit,
                    buttonSize: widget.buttonSize,
                  ),
                ),
                NumberButton(
                  number: 0,
                  controller: widget.controller,
                  maxDigit: widget.maxDigit,
                  buttonSize: widget.buttonSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteButton extends StatefulWidget {
  final TextEditingController controller;
  final int maxDigits;
  final double buttonSize;

  const DeleteButton({Key? key, required this.controller, required this.maxDigits, required this.buttonSize}) : super(key: key);

  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool buttonPressPerformed = false;

  void buttonPress() {
    if (widget.controller.text.isNotEmpty) {
      widget.controller.text = widget.controller.text.substring(0, widget.controller.text.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.buttonSize,
        width: widget.buttonSize,
        child: InkWell(
          onTapDown: (_) {
            buttonPress();
            buttonPressPerformed = true;
          },
          onTapCancel: () {
            buttonPressPerformed = false;
          },
          child: ElevatedButton(
              onPressed: () {
                if (buttonPressPerformed) {
                  buttonPressPerformed = false;
                } else {
                  buttonPress();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              child: const Center(child: FittedBox(child: Icon(Icons.backspace_outlined, color: Colors.white, size: 60)))),
        ));
  }
}

class NumberButton extends StatefulWidget {
  final int number;
  final TextEditingController controller;
  final int maxDigit;
  final double buttonSize;

  const NumberButton({Key? key, required this.number, required this.controller, required this.maxDigit, required this.buttonSize}) : super(key: key);

  @override
  State<NumberButton> createState() => _NumberButtonState();
}

class _NumberButtonState extends State<NumberButton> {
  bool buttonPressPerformed = false;

  void buttonPress() {
    if (widget.controller.text.length < widget.maxDigit) {
      setState(() {
        widget.controller.text += widget.number.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.buttonSize,
      width: widget.buttonSize,
      child: InkWell(
        onTapDown: (_) {
          buttonPress();
          buttonPressPerformed = true;
        },
        onTapCancel: () {
          buttonPressPerformed = false;
        },
        child: ElevatedButton(
          onPressed: () {
            if (buttonPressPerformed) {
              buttonPressPerformed = false;
            } else {
              buttonPress();
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          child: Center(
            child: FittedBox(
              child: Text(
                widget.number.toString(),
                style: const TextStyle(color: Colors.white, fontFamily: "GloryBold", fontSize: 60),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
class NumberButton extends StatelessWidget {
  final int number;
  final TextEditingController controller;
  final int maxDigit;
  final double buttonSize;

  const NumberButton({
    Key? key,
    required this.number,
    required this.controller,
    required this.maxDigit,
    required this.buttonSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void buttonPress(){
      if(controller.text.length < maxDigit){
        controller.text += number.toString();
      }
    }

    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: InkWell(
        onTapDown: (_) {
          buttonPress();
        },
        child: ElevatedButton(
          onPressed: () {
            buttonPress();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20))),
          child: Center(
            child: FittedBox(
              child: Text(number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "GloryBold",
              fontSize: 60))))),
      ));
  }
}
*/
