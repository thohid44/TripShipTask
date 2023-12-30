import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Email_Verify/view/email_verification.dart';
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
          title: 'TripShipTask',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.black,
          ),
          home: child,
        );
      },
      
      child: checkUserType() ? HomeScreen() : SplashScreen(),
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

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              child: Container(
                width: 75,
                height: 82,
                decoration: BoxDecoration(
                  color: Color(0xffD8C9FE),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 30,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'SSC',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                height: 200.h,
                width: 180.w,

                decoration: BoxDecoration(
                    color: Color(0xffD8E54F),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(9.r),
                        bottomLeft: Radius.circular(26.r),
                        bottomRight: Radius.circular(26.r))),
                child: Column(
                  children: [
                    Container(
                      width: 175.w,
                      alignment: Alignment.center,
                      child: Text(
                        "English",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      width: 180.w,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                     
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         
                        Container(
                            width: 78.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 25.w,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE69EFF),
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: Icon(
                                      Icons.percent,
                                      size: 15.h,
                                    )),
                                Container(
                                  padding: EdgeInsets.only(right: 5.w),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Group Study",
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                           Container(
                            width: 78.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 25.w,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE69EFF),
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: Icon(
                                      Icons.percent,
                                      size: 15.h,
                                    )),
                                Container(
                                  padding: EdgeInsets.only(right: 5.w),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Group Study",
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
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
                color: selectedItems.contains(items[itemIndex])
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




class MyFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('TextFormField Design'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
          SizedBox(height: 30.h,), 
                Material(
            elevation: 8,
            color:primaryColor,
            shadowColor:primaryColor,
            borderRadius: BorderRadius.circular(5),
            child:   Container(
              alignment: Alignment.center,
              width: 200, 
              height: 38,
              child: Text("Hello 1")),
          ) ,
          SizedBox(height: 30.h,), 
          Container(
            margin: const EdgeInsets.all(40.0),
            height: 150.0,
            width: double.infinity,
            decoration: const BoxDecoration(
               color: Color(0xffF1F4F9),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                )
              ],
            ),
            child: const Center(child: Text("Hello world 2")),
          ),
          SizedBox(height: 30.h,), 
          Container(
            height: 40.0,
            alignment: Alignment.center,
            width: 200.0,
            decoration: const BoxDecoration(
              color:primaryColor, 
              boxShadow: [
                BoxShadow(
                  color:primaryColor, 
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 5.0, //extend the shadow
                  offset: Offset(
            5.0, // Move to right 5  horizontally
            5.0, // Move to bottom 5 Vertically
                  ),
                )
              ],
            ),
            child: const Text("Hello world 3"),
          ),
          SizedBox(height: 10.h,), 
          Container(
            height: 40.0,
            width: 290,
            decoration: const BoxDecoration(
               color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: primaryColor,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: Offset(
            7.0, // Move to right 7.0 horizontally
            8.0, // Move to bottom 8.0 Vertically
                  )
                )
              ],
            ),
            child: const Center(child: Text("Hello world 4")),
          ),
          
          SizedBox(height: 20.h,), 
                SizedBox(
                  width: 200.w,
                  child: Material(
                       elevation: 8,
                            color:primaryColor,
                            shadowColor:primaryColor,
                            borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding:  EdgeInsets.all(2.0.h),
                              
                   
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          height: 1.5, // Line height
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          hintText: 'Enter text',
                          filled: true,
                          fillColor: primaryColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: BorderSide.none,
                          ),
                          errorStyle: TextStyle(height: 0), // Removes extra space for error text
                        ),
                      ),
                    ),
                  ),
                ),

                 SizedBox(height: 20.h,), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}