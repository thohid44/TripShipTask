import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class AmarPayWebView extends StatefulWidget {
  var url;
   AmarPayWebView({super.key, this.url});

  @override
  State<AmarPayWebView> createState() => _AmarPayWebViewState();
}

class _AmarPayWebViewState extends State<AmarPayWebView> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  var currentUrl = '';
var url;
  @override
  void initState() {
    super.initState();
    var url = widget.url;
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
            Text('Current URL: $currentUrl'),
          ],
        ));
  }
}