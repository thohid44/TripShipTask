import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MainPage extends StatefulWidget {
  var path;
  MainPage( this.path);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  WebViewControllerPlus? _controler;
  //var url = 'www.google.com';
  // var url =
  //     "https://secure.aamarpay.com/paynow_check_update.php?d=ZkcwVG04UTZYenR0RVQzQUZLT3FNTEtMQVhKZ0N2SnV3bVloVmptVmRlR2YxcWV6UlE9PQ==";

  @override
  void initState() {
    _controler = WebViewControllerPlus()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            _controler!.onLoaded((msg) {
              _controler!.getWebViewHeight().then((value) {
                var height = int.parse(value.toString()).toDouble();
                if (height != _height) {
                  if (kDebugMode) {
                    print("Height is: $value");
                  }
                  setState(() {
                    _height = height;
                  });
                }
              });
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.path}'));
    super.initState();
  }

  double _height = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment Process'),
      ),
      body: 
          Container(
               color: Colors.white,
             height: 600.h,
            child: WebViewWidget(
              controller: _controler!,
            ),
          ),

    );
  }

  @override
  void dispose() {
    _controler!.server.close();
    super.dispose();
  }
}
