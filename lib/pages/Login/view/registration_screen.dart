import 'dart:math';

import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';

import 'package:tripshiptask/pages/Login/controller/LoginController.dart';
import 'package:tripshiptask/pages/Login/view/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/pages/Login/view/privacy_policy.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController retypePassword = TextEditingController();

  bool isSelect = false;
  String? gender;
  var genderName;

  List<Map<String, dynamic>> items = [
    {"id": 1, "name": "Male", "slug": "Male"},
    {"id": 2, "name": "Female", "slug": "Female"},
  ];

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios_new),
        actions: [
          Icon(Icons.filter),
        ],
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 110.h,
                width: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: const [
                    BoxShadow(
                      color: primaryColor,
                      blurStyle: BlurStyle.outer,
                      //    spreadRadius: 15.0, //extend the shadow
                      // offset: Offset(
                      //   5.0, // Move to right 5  horizontally
                      //   5.0, // Move to bottom 5 Vertically
                      // ),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,
                      margin: EdgeInsets.only(top: 5.h),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              "assets/logo.jpeg",
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      child: Text(
                        "Trip Ship Task",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 13.sp),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextForm(
                  width: 260.w, textController: name, hinttext: "Full Name"),
              SizedBox(
                height: 15.h,
              ),
              CustomTextForm(
                width: 260.w,
                textController: phone,
                hinttext: "Phone Number",
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextForm(
                width: 260.w,
                textController: email,
                hinttext: "Email",
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                  width: 260.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 48,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      isExpanded: true,
                      hint: Text(
                        "${isSelect ? genderName : 'Gender'}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.sp),
                      ),
                      underline: SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      value: gender,
                      items: items
                          .map((e) => DropdownMenuItem(
                                onTap: () {
                                  genderName = e['name'].toString();
                                },
                                value: e['id'],
                                child: Text(
                                  "${e['name']}",
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          isSelect = true;
                        });
                      })),
              SizedBox(
                height: 15.h,
              ),
              CustomTextForm(
                width: 260.w,
                textController: password,
                hinttext: "Password",
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextForm(
                width: 260.w,
                textController: retypePassword,
                hinttext: "Retype Password",
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButtonOne(
                height: 45.h,
                title: "Sign Up",
                btnColor: navyBlueColor,
                radius: 10.r,
                fontSize: 17.sp,
                onTab: () {
                  if (name.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Name filed is required!'),
                    ));
                  } else if (phone.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Phone number filed is required!'),
                    ));
                  } else if (email.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Email filed is required!'),
                    ));
                  } else if (password.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Phone number filed is required!'),
                    ));
                  } else if (password.text != retypePassword.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Retrype password not match!'),
                    ));
                  } else {
                    var logInController = Get.put(LoginController());
                    logInController.registration(
                      name: name.text.toString(),
                      phone: phone.text.toString(),
                      email: email.text.toString(),
                      gender: gender.toString(),
                      password: password.text.toString(),
                    );
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(PrivacyPolicy());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  alignment: Alignment.center,
                  child: Text(
                    "By signing up, you agree to our Terms, Privacy, Data, Cookies,Acceptable Use and Copyright Policy",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: navyBlueColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Have an Account?",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: navyBlueColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        LoginScreen(),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: navyBlueColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget _textInputForm({controller, hint, icon, inputAction, userErrorText}) {
  return Container(
    height: 40.h,
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.r))),
    child: TextFormField(
      textInputAction: inputAction,
      validator: (value) {
        if (value!.isEmpty) {
          return userErrorText;
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
        helperText: '  ',
        hintText: hint,
        prefixIcon: icon,
        hintStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          gapPadding: 4.6,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      ),
    ),
  );
}
