import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/pages/Login/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 120.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      // boxShadow: const [
                      //   BoxShadow(
                      //     color: primaryColor,
                      //     blurStyle: BlurStyle.outer,
                      //     spreadRadius: 10.0, //extend the shadow
                      //     // offset: Offset(
                      //     //   5.0, // Move to right 5  horizontally
                      //     //   5.0, // Move to bottom 5 Vertically
                      //     // ),
                      //   )
                      // ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.h,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/logo.jpeg")),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Container(
                          child: Text(
                            "TripShipTask",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.sp),
                          ),
                        ),
                        Text(
                          "Connect Assist Earn",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 9.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
