import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/screens/payment_screens/payment_status_screen.dart';
import 'package:kiosk_flutter/screens/payment_screens/payment_token_screen.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../providers/main_provider.dart';

class DisplayFrameScreen extends StatefulWidget {
  final String url;
  final int id;

  const DisplayFrameScreen({
    Key? key,
    required this.url,
    required this.id
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => DisplayFrameScreenState();
}

class DisplayFrameScreenState extends State<DisplayFrameScreen> {
  late WebViewController _controller;
  late MainProvider provider;
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MainProvider>(context, listen: true);

    ApiService(token: provider.loginToken).checkPaymentStatus(widget.id).then( (value)  {
      print("done");
      if(!flag){
        Navigator.of(context).push(MaterialPageRoute(builder: (context ) => PaymentStatusScreen(id: widget.id)));
        flag = true;
      }

    });

    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,

              initialUrl: widget.url,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
              debuggingEnabled: true,
              onPageStarted: (value) {
                print("pagestart");
                log(value);
              },
              onProgress: (value) {
                log(value.toString());
              },
              onWebResourceError: (value) {
                print("error");
                log(value.toString());
                //Navigator.of(context).push(MaterialPageRoute(builder: (context ) => PaymentStatusScreen(id: widget.id)));
              },
              onPageFinished: (value) {
                log(value);
                if(value.toString() == widget.url){
                  //Navigator.of(context).pop();
                }
              },
            ),
          ),
          ElevatedButton(onPressed: () {
            _load_page();
          }, child: Text(""))
        ],
      ),
    );
  }

  _load_page() async {
    String? page = await _controller.currentUrl();
    log(page!);

    String? title = await _controller.getTitle();
    log(title!);

    _controller.reload();
  }
}