import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  late WebViewController controller; // declare as late variable

  WebViewScreen(String url) {
    controller = WebViewController(); // initialize later
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.setNavigationDelegate(
    NavigationDelegate(
    onProgress: (int progress) {
    // Update loading bar.
    },
    onPageStarted: (String url) {},
    onPageFinished: (String url) {},
    onWebResourceError: (WebResourceError error) {},
    onNavigationRequest: (NavigationRequest request) {
    if (request.url.startsWith('https://www.youtube.com/')) {
    return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
    },
    ),
    );
    controller.loadRequest(Uri.parse(url)); // load the given URL



  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.windows) {
     // WebViewPlatform.instance = WebViewWindows();

    }

    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        controller: controller,
      ),

    );
  }
}
