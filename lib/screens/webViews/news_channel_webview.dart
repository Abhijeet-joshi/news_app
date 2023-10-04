import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

String? mUrl;
class Channel extends StatefulWidget {
  Channel({required String cUrl}){
    mUrl = cUrl;
  }

  @override
  State<Channel> createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {

  WebViewController getLinkInController(){
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
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
