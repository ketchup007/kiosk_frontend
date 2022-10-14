import 'package:flutter/material.dart';
import 'package:kiosk_flutter/widgets/buttons/num_pad.dart';

import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:provider/provider.dart';

class PhonePopupCard extends StatefulWidget{
  final Function onPress;

  const PhonePopupCard({
    Key? key,
    required this.onPress
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _PhonePopupCardState();
}


class _PhonePopupCardState extends State<PhonePopupCard> {
  bool isCheckedMain = false;
  bool isCheckedA = false;
  bool isCheckedB = false;
  bool isCheckedC = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: true);

    final TextEditingController _myController = TextEditingController();
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Wprowadź nr Telefony'),
              Text('data'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('+48'),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child:  TextField(
                        controller: _myController,
                        showCursor: false,
                        keyboardType: TextInputType.none,
                      )
                  )

                ]
              ),
              numPad(controller: _myController),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isCheckedMain,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckedMain = value!;
                        if(value! == true){
                          isCheckedA = true;
                          isCheckedB = true;
                          isCheckedC = true;
                        }
                      });
                    },
                  ),
                  Text('Zaznacz wszystkie')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isCheckedA,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckedA = value!;
                      });
                    },
                  ),
                  Text('Wymagane')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isCheckedB,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckedB = value!;
                      });
                    },
                  ),
                  Text('Promocje')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isCheckedC,
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckedC = value!;
                      });
                    },
                  ),
                  Text('Opcjonalne')
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    if(isCheckedA == true && _myController.text.length == 9){
                      Navigator.of(context).pop();
                      provider.order.client_name = _myController.text;
                      widget.onPress();
                    }
                  },
                  child: Text('Potwierdź '))
            ],
          )
        )
      )
    );
  }

}