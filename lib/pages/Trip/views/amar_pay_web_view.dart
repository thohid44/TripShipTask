import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AmarPayWebView extends StatefulWidget {
  const AmarPayWebView({super.key});

  @override
  State<AmarPayWebView> createState() => _AmarPayWebViewState();
}

class _AmarPayWebViewState extends State<AmarPayWebView> {

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
        if (request.url.startsWith('https:\/\/secure.aamarpay.com\/paynow_check_update.php?d=ZkcwVG04UTZXRHB2RlRuT0g2T3FNTG1JQlhKZ0N2Sm95bVltVWptVmRlR1kyS2F4U3c9PQ==')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https:\/\/secure.aamarpay.com\/paynow_check_update.php?d=ZkcwVG04UTZXRHB2RlRuT0g2T3FNTG1JQlhKZ0N2Sm95bVltVWptVmRlR1kyS2F4U3c9PQ=='));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         
          body: WillPopScope(
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
          )),
    );
  }
}
