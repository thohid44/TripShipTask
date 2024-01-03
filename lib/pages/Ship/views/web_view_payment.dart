import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewPayment extends StatefulWidget {
  @override
  State<WebViewPayment> createState() => _WebViewPaymentState();
}

class _WebViewPaymentState extends State<WebViewPayment> {
  late WebViewController _webViewController;
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://tcargo.blogtools.xyz')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://tcargo.blogtools.xyz'));
  @override
  Widget build(BuildContext context) {
    return 
         WillPopScope(
          onWillPop: () async {
            if (await controller.canGoBack()) {
              controller.goBack();
              return false;
            } else {
              return true;
            }
          },
          child: WebViewWidget(
            controller: controller,
          ),
        
        
      
    );
  }
}
