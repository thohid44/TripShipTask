import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

final Uri _url = Uri.parse('https://flutter.dev');

// koliAmarFnd
class WebViewPayment extends StatefulWidget {
  @override
  State<WebViewPayment> createState() => _WebViewPaymentState();
}

class _WebViewPaymentState extends State<WebViewPayment> {
  // var url =
  //     "https://secure.aamarpay.com/paynow_check_update.php?d=ZkcwVG04UTZYenR0RVQzQUZLT3FNTEtMQVhKZ0N2SnV3bVloVmptVmRlR2YxcWV6UlE9PQ==";


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
          // if (request.url.startsWith(url1)) {
          //   return NavigationDecision.prevent;
          // }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("https://secure.aamarpay.com/paynow_check_update.php?d=ZkcwVG04UTZYenR0RVQzQUZLT3FNTEtMQVhKZ0N2SnV3bVloVmptVmRlR2YxcWV6UlE9PQ=="));
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
