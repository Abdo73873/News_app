// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewScreen extends StatelessWidget {
  WebViewController controller=WebViewController();
  WebViewScreen(String url){
    controller.loadRequest(Uri.parse(url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller:controller ,
      ),
    );
  }
}
