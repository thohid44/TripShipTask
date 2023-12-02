import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Utils/localstorekey.dart';
import 'pages/Home/view/home_screen.dart';
import 'pages/Login/view/login_screen.dart';
import 'dart:io';

void main() async{
  // final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
  // // Default to Hybrid Composition for the example.
  // (platform as GoogleMapsFlutterAndroid).useAndroidViewSurface = true;
  
  HttpOverrides.global = MyHttpOverrides();
    await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _box = GetStorage();
  MyApp({super.key});
  var result;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   

    return ScreenUtilInit(
      designSize: const Size(360, 690),
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
          home: child,
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

  ///
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// void main() => runApp(MaterialApp.router(routerConfig: router));

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (_, __) => Scaffold(
//         appBar: AppBar(title: const Text('Home Screen')),
//       ),
//       routes: [
//         GoRoute(
//           path: 'details',
//           builder: (_, __) => Scaffold(
//             appBar: AppBar(title: const Text('Details Screen')),
//           ),
//         ),
//       ],
//     ),
//   ],
// );