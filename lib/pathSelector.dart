import 'package:flutter/cupertino.dart';
import 'package:kiosk_flutter/screens/mobile_start_screen.dart';
import 'package:kiosk_flutter/screens/start_screen.dart';

class PathSelector extends StatelessWidget{
  const PathSelector({super.key});

  @override
  Widget build(BuildContext context) {

    if(MediaQuery.of(context).size.height > 1000){ //KIOSK
      return StartScreen();
    }else { //MOBLIE
      return MobileStartScreen();
    }
  }

}
