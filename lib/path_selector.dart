import 'package:flutter/cupertino.dart';
import 'package:kiosk_flutter/screens/start_screen_mobile.dart';
import 'package:kiosk_flutter/screens/start_screen_kiosk.dart';

class PathSelector extends StatelessWidget {
  const PathSelector({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.height > 1000) {
      // KIOSK
      return const StartScreenKiosk();
    } else {
      return const StartScreenMobile();
    }
  }
}
