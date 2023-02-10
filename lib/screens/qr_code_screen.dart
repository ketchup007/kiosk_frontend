import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/main.dart';
import 'package:kiosk_flutter/screens/order_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:kiosk_flutter/widgets/animations/first_screen_robot.dart';
import 'package:kiosk_flutter/widgets/card/gps_wait_popup.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:kiosk_flutter/themes/color.dart';

class QrCodeScreen extends StatefulWidget{
  const QrCodeScreen({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen>{
  Barcode? result;
  String resultText = "";
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller){
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((scanData) => setState(() => result = scanData));
  }

  @override
  void reassemble() {
    super.reassemble();

    if(Platform.isAndroid){
      controller!.pauseCamera();
    } else if(Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if(result != null) {
      controller!.pauseCamera();
      print(result!.code);
      resultText = result!.code!;
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();

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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                          borderColor: Colors.orange,
                          borderRadius: 10,
                          borderLength: 30,
                          borderWidth: 10,
                          cutOutSize: 250
                      ))),
                Text("${resultText}"),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderScreen()));
                    },
                    child: Text("NEXT")),
                ElevatedButton(
                    onPressed: () {
                      controller?.resumeCamera();
                    },
                    child: Text("Resume"))
              ],
            ),
          )));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}

