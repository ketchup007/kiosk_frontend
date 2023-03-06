import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;
import 'package:kiosk_flutter/main.dart';
import 'package:kiosk_flutter/screens/order_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:kiosk_flutter/widgets/buttons/language_buttons.dart';
import 'package:kiosk_flutter/widgets/card/gps_wait_popup.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:kiosk_flutter/themes/color.dart';
import 'package:http/http.dart' as http;

import '../models/container_model.dart';
import '../providers/main_provider.dart';

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

  int status = 0;
  bool loading = true;
  late Future<String?> future;
  late MainProvider provider;

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
      //controller!.resumeCamera();
      status = 1;
      controller!.stopCamera();
    }else {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);
    readQr();

    if(status == 1){
      print("1");
      if(loading){
        print("2");
        future = ApiService(token: provider.loginToken).getFromLink(resultText, http.Client()).then((value) {
          print(3);
          loading = false;
          return value;
        });
      }
    }

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
                    child: Text("Zeskanuj kod Qr punktu sprzedaży")),
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
                status == 1 ? FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      print("4");
                      if(snapshot.hasError){
                        print("5");
                        return Text("error");
                      }
                      print("6");

                      print("${snapshot.hasData}, ${snapshot.data}");
                      if(snapshot.hasData){
                        print("7");
                        String data = snapshot.data as String;
                        ContainerModel container = ContainerModel.fromJson(jsonDecode(data));
                        print(container.address);
                        print("8");
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Text("Przyciśnij poniższy przycisk aby złożyć zamówienie w punkcie sprzedaży ${container.address}"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  provider.containerDb = container.db;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const OrderScreen()));
                                },
                                child: Text("Dalej")),
                          ]
                        );
                      }
                      print("9");
                      return CircularProgressIndicator();
                    }) : Container()
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

