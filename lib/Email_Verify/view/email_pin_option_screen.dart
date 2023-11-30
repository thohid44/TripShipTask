import 'dart:math';

import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "E-mail Verification",
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter,
                color: Colors.black,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 100.h,
              child: Image.asset("assets/logo.jpg"),
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              child: Text(
                "Enter PIN",
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
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
                    title: "CANCEL",
                    height: 40.h,
                    radius: 10.r,
                    fontWeight: FontWeight.normal,
                    marginLR: 0,
                    btnColor: navyBlueColor,
                    onTab: () {}),
                SizedBox(
                  width: 30.w,
                ),
                CustomButtonOne(
                    title: "SUBMIT",
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
