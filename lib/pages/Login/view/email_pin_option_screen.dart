import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailOtpScreen extends StatefulWidget {
  const EmailOtpScreen({super.key});

  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  var v1;
  var v2;
  var v3;
  var v4;
  var v5;
  var v6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
          
              Container(
                height: 120.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: primaryColor,
                          offset: Offset(0, 7.0),
                          blurRadius: 6.0,
                          spreadRadius: 4.0)
                    ]),
                child: Column(
                  children: [
                    Container(
                      width: 85.w,
                      height: 85.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/transLogo.png")),
                      ),
                    ),
                    SizedBox(
                      height: 0.h,
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
              

            SizedBox(
              height: 50.h,
            ),
           
              Container(
              child: Text(
                " An OTP has been sent to your phone.",
                style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 15.h,), 
            Container(
              child: Text(
                "Enter OTP Code",
                style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.h,
                    width: 35.w,
                    child: TextFormField(
                      inputFormatters: [],
                      decoration: InputDecoration(),
                      onChanged: (value) {
                        v1 = value;
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.h,
                    width: 35.w,
                    child: TextFormField(
                      inputFormatters: [],
                      onChanged: (value) {
                        if (value.length == 1) {
                          v2 = value;
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.h,
                    width: 35.w,
                    child: TextFormField(
                      inputFormatters: [],
                      onChanged: (value) {
                        v3 = value;
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.h,
                    width: 35.w,
                    child: TextFormField(
                      inputFormatters: [],
                      onChanged: (value) {
                        v4 = value;
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.h,
                    width: 35.w,
                    child: TextFormField(
                      inputFormatters: [],
                      onChanged: (value) {
                        v5 = value;
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.h,
                    width: 35.w,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      inputFormatters: [],
                      onChanged: (value) {
                        v6 = value;
                        print(v6);
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                CustomButtonOne(
                    title: "Verify OTP",
                    height: 40.h,
                    fontWeight: FontWeight.normal,
                    radius: 10.r,
                    marginLR: 0,
                    btnColor: navyBlueColor,
                    onTab: () {
                      var pin = v1 + v2 + v3 + v4 + v5 + v6;
                      print(pin);
                      if (pin == '') {
                        Get.snackbar("PIN", "must be filled");
                      } else {
                        Get.to(ProfileScreen());
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
