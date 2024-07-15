import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/providers/main_provider.dart';
import 'package:kiosk_flutter/screens/payment_screens/payment_status_screen.dart';
import 'package:kiosk_flutter/utils/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayFrameScreen extends StatefulWidget {
  final String url;
  final int id;

  const DisplayFrameScreen({Key? key, required this.url, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DisplayFrameScreenState();
}

class DisplayFrameScreenState extends State<DisplayFrameScreen> {
  late WebViewController _controller;
  late MainProvider provider;
  bool flag = false;

  @override
  void initState() {
    provider = Provider.of<MainProvider>(context, listen: true);

    ApiService(token: provider.loginToken).checkPaymentStatus(widget.id).then((value) {
      print("done");
      if (!flag) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentStatusScreen(id: widget.id)));
        flag = true;
      }
    });

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        // onWebViewCreated: (WebViewController webViewController) {
        //   _controller = webViewController;
        // },
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
          if (value.toString() == widget.url) {
            //Navigator.of(context).pop();
          }
        },
      ))
      ..loadRequest(Uri.parse(widget.url));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: WebViewWidget(
              controller: _controller,
            ),
          ),
          ElevatedButton(
            onPressed: _loadPage,
            child: const Text(""),
          )
        ],
      ),
    );
  }

  _loadPage() async {
    String? page = await _controller.currentUrl();
    log(page!);

    String? title = await _controller.getTitle();
    log(title!);

    _controller.reload();
  }
}
