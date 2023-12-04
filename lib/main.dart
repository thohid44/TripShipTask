import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Email_Verify/view/email_verification.dart';
import 'package:tripshiptask/my_form.dart';
import 'package:uni_links/uni_links.dart';
import 'Utils/localstorekey.dart';
import 'pages/Home/view/home_screen.dart';
import 'pages/Login/view/login_screen.dart';
import 'dart:io';

void main() async {
  //final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
  // // Default to Hybrid Composition for the example.
  // (platform as GoogleMapsFlutterAndroid).useAndroidViewSurface = true;

  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _box = GetStorage();

  var result;

  StreamSubscription? _sub;

  Future<void> initUniLinks() async {
    // Attach a listener to th stream
    _sub = linkStream.listen((String? link) {
      if (link != null) {
        print("Listener is working");
        var uri = Uri.parse("$link");
        if (uri.queryParameters['token'] != null) {
          print(uri.queryParameters['token'].toString());
        }
      }
    }, onError: (err) {
      print(err.toString());
    });
  }

  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(320, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Trip Ship Task',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.black,
          ),
          home: child
        );
      },
   child: checkUserType() ? HomeScreen() : LoginScreen(),
    );
  }

  ///
  bool checkUserType() {
    var result1 = _box.read(LocalStoreKey.token.toString());
    if (result1 != null) {
      return true;
    }

    return false;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

