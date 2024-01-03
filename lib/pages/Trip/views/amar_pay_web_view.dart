import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AmarPayWebView extends StatefulWidget {
  var payUrl;
  AmarPayWebView(this.payUrl);

  @override
  State<AmarPayWebView> createState() => _AmarPayWebViewState();
}

class _AmarPayWebViewState extends State<AmarPayWebView> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  var currentUrl =
      'https://secure.aamarpay.com/paynow_check_update.php?d=ZkcwVG04UTZYejFyRUQvSEZLT3FNTE9IQm5KZ0N2SnZ5V0FnVWptVmRlR2UwNkd4VHc9PQ==';
  // var url =
  //     'https://secure.aamarpay.com/paynow_check_update.php?d=ZkcwVG04UTZYejFyRUQvSEZLT3FNTE9IQm5KZ0N2SnZ5V0FnVWptVmRlR2UwNkd4VHc9PQ==';
  var url;
  @override
  void initState() {
    url = widget.payUrl;

    print("url $url");
    super.initState();

    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
            currentUrl = url;
          });
          debugPrint('url: $url');
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('$url'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AamarPay'),
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          
          ],
        ));
  }
}
