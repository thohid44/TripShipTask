import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Utils/colors.dart';

import 'package:tripshiptask/splashScreen.dart';
import 'package:uni_links/uni_links.dart';
import 'Utils/localstorekey.dart';
import 'pages/Home/view/home_screen.dart';

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
   child: checkUserType() ? HomeScreen() :SplashScreen(),
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




class RatingList extends StatefulWidget {
  @override
  _RatingListState createState() => _RatingListState();
}

class _RatingListState extends State<RatingList> {
  List<String> selectedItems = [];

  final List<String> items = [
    'Professionalism',
    'Behavior',
    'Punctuality',
    'Vehicle Quality',
    'Navigation',
    'Cleanliness',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (items.length / 2).ceil(),
      itemBuilder: (context, index) {
        print("object $selectedItems");
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              buildItemTile(index * 2),
              SizedBox(width: 5.w),
              buildItemTile(index * 2 + 1),
            ],
          ),
        );
      },
    );
  }

  Widget buildItemTile(int itemIndex) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            toggleSelection(items[itemIndex]);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: selectedItems.contains(items[itemIndex])
                ? greenColor
                : Colors.white,
            borderRadius: BorderRadius.circular(5.r),
          ),
          padding: EdgeInsets.all(5.r),
          child: Center(
            child: Text(
              items[itemIndex],
              style: TextStyle(
                color:  selectedItems.contains(items[itemIndex])
                ? Colors.white
                : Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggleSelection(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }
}
