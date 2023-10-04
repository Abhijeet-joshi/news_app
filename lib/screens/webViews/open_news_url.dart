import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

String? mUrl;
class OpenNews extends StatefulWidget {
  OpenNews({required String cUrl}){
    mUrl = cUrl;
  }

  @override
  State<OpenNews> createState() => _OpenNewsState();
}

class _OpenNewsState extends State<OpenNews> {

  WebViewController getLinkInController(){
    var controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.disabled)
        ..loadRequest(Uri.parse(mUrl.toString()));
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: getLinkInController(),
        ),
      ),
    );
  }
}
