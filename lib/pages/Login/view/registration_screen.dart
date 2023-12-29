import 'dart:math';

import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/Widget/custom_text_field.dart';
import 'package:tripshiptask/my_form.dart';

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
    var logInController = Get.put(LoginController());
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
    {"id": 3, "name": "Rather not say", "slug": "Rather not say"},
    {"id": 4, "name": "Other", "slug": "Other"},
  ];
  bool status = true;
  bool isYesSelected = true;
  bool isNoSelected = false;

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();
  var width = 290.w;
  var height = 38.h;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //backgroundColor: Colors.white,
     
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.h,) , 
                Container(
                height: 100.h,
                width: 95.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
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
                      width: 65.w,
                      height: 65.h,
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
                height: 35.h,
              ),
              CustomTextForm(
                  width: width,
                  height: height,
                  errorMsg: "Full Name is Required",
                  textController: name,
                  hinttext: "Full Name"),
              SizedBox(
                height: 8.h,
              ),
              UnconstrainedBox(
                child: Row(
                  children: [
                 Material(
      elevation: 8,
      color: primaryColor,
      shadowColor: primaryColor,
      borderRadius: BorderRadius.circular(5),
                      child: Container(
                                width: 40.w,
                                height: 38.h,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(0.r),
                                   // border: Border.all(width: 0.1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xffF1F4F9)
                                            .withOpacity(0.5), //color of shadow
                                        spreadRadius: 8, //spread radius
                                        blurRadius: 7, // blur radius
                                        offset: Offset(
                                            5, 5), // changes position of shadow
                                      ),
                                    ]),
                                    child: Image.asset("assets/bangla.png"),
                                    ),
                    ),
                    CustomTextForm(
                      width: 250.w,
                      height: height,
                      textController: phone,
                      errorMsg: "Phone Number is Required",
                      hinttext: "Phone Number eg.(0123456789)",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: 285.w,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text('WhatsApp Number:'),
                    SizedBox(width: 5.w),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: isYesSelected,
                          onChanged: (value) {
                            setState(() {
                              isYesSelected = value as bool;
                              isNoSelected = !value;
                            });
                          },
                          activeColor: Colors.teal,
                        ),
                        Text('Yes'),
                      ],
                    ),
                    SizedBox(width: 5.w),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: isNoSelected,
                          onChanged: (value) {
                            setState(() {
                              isNoSelected = value as bool;
                              isYesSelected = !value;
                            });
                          },
                          activeColor: Colors.teal,
                        ),
                        Text('No'),
                      ],
                    ),
                  ],
                ),
              ),
              isNoSelected == false
                  ? Container()
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Material(
                            elevation: 8,
                            color: primaryColor,
                            shadowColor: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 38.h,
                              width: 50.w,
                              child: Image.asset("assets/whatsapp.png"),
                            ),
                          ),
                          CustomTextForm(
                            width: 240.w,
                            height: height,
                            textController: phone,
                            errorMsg: "Phone Number is Required",
                            hinttext: "WhatsApp Number",
                            onChanged: (value) {
                            
                              logInController.whatsAppNumber.value = value;
                            },
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 8.h,
              ),
              CustomTextForm(
                width: width,
                height: height,
                textController: email,
                errorMsg: "Email is Required",
                hinttext: "Email",
              ),
              SizedBox(
                height: 8.h,
              ),
              Material(
                  elevation: 8,
      color: primaryColor,
      shadowColor: primaryColor,
      borderRadius: BorderRadius.circular(5),
                child: Container(
                    width: width,
                    height: 38.h,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(4.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffF1F4F9)
                                .withOpacity(0.5), //color of shadow
                            spreadRadius: 8, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(5, 5), // changes position of shadow
                          ),
                        ]),
                    child: DropdownButton(
                        padding: EdgeInsets.only(left: 9.w),
                        isExpanded: true,
                        hint: Text(
                          "${isSelect ? genderName : 'Gender'}",
                          style:  GoogleFonts.inter(
                                fontWeight: FontWeight.normal, fontSize: 14.sp),
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
              ),
              SizedBox(
                height: 8.h,
              ),
              UnconstrainedBox(
                child: Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Container(
                        width: 250.w,
                        height: 38.h,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffF1F4F9)
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 8, //spread radius
                                blurRadius: 7, // blur radius
                                offset:
                                    Offset(5, 5), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              ),
                            ]),
                        child: TextField(
                          controller: password,
                          autofocus: false,
                          obscureText: status,
                          style: TextStyle(fontSize: 15.sp),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.normal, fontSize: 14.sp),
                            filled: true,
                            fillColor: primaryColor,
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            status = !status;
                          });
                        },
                        child: Container(
                            width: 40.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(0.r),
                                border: Border.all(width: 0.1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffF1F4F9)
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 8, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: Offset(
                                        5, 5), // changes position of shadow
                                  ),
                                ]),
                            child: status == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                      ),
                    ],
                  ),
                ),
              ),
              UnconstrainedBox(
                child: Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Container(
                           width: 250.w,
                        height: 38.h,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffF1F4F9)
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 8, //spread radius
                                blurRadius: 7, // blur radius
                                offset:
                                    Offset(5, 5), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              ),
                            ]),
                        child: TextField(
                          controller: retypePassword,
                          autofocus: false,
                          obscureText: status,
                          style: TextStyle(fontSize: 15.sp),
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle:  GoogleFonts.inter(
                                fontWeight: FontWeight.normal, fontSize: 14.sp),
                            filled: true,
                            fillColor: primaryColor,
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            status = !status;
                          });
                        },
                        child: Container(
                            width: 40.w,
                            height: 39.h,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(0.r),
                                border: Border.all(width: 0.1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffF1F4F9)
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 8, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: Offset(
                                        5, 5), // changes position of shadow
                                  ),
                                ]),
                            child: status == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonOne(
                height: 35.h,
                title: "Sign Up",
                width: 125.w,
                btnColor: navyBlueColor,
                radius: 11.r,
                fontSize: 12.sp,
                onTab: () {
                  // if(formkey.currentState!.validate()){

                  // }
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(5.r))),
                  //           contentPadding: EdgeInsets.only(top: 10.0),
                  //           content: Stack(
                  //             children: <Widget>[
                  //               Container(
                  //                 width: MediaQuery.of(context).size.width,
                  //                 child: Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.stretch,
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: <Widget>[
                  //                     SizedBox(height: 20.0.h),
                  //                     Text(
                  //                       "Success",
                  //                       textAlign: TextAlign.center,
                  //                       style: TextStyle(
                  //                           fontSize: 14.sp,
                  //                           fontWeight: FontWeight.w700,
                  //                           color: Colors.black),
                  //                     ),
                  //                     Center(
                  //                         child: Padding(
                  //                       padding: const EdgeInsets.all(10.0),
                  //                       child: Text(
                  //                         "Sign Up Successful! \n Please verify your Email.",
                  //                         style: TextStyle(
                  //                             fontSize: 13.sp,
                  //                             fontWeight: FontWeight.normal,
                  //                             color: Colors.black),
                  //                         textAlign: TextAlign.center,
                  //                       ),
                  //                     ) //
                  //                         ),
                  //                     SizedBox(
                  //                       height: 20.0,
                  //                     ),
                  //                     UnconstrainedBox(
                  //                       child: CustomButtonOne(
                  //                           width: 70.w,
                  //                           height: 30.h,
                  //                           radius: 5.r,
                  //                           marginLR: 0.w,
                  //                           title: "Ok",
                  //                           btnColor: navyBlueColor,
                  //                           onTab: () {
                  //                             Get.to(LoginScreen());
                  //                           }),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 20.0,
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                   top: 0.h,
                  //                   right: 0.w,
                  //                   child: IconButton(
                  //                     onPressed: () {
                  //                       Navigator.pop(context);
                  //                     },
                  //                     icon: Icon(
                  //                       Icons.close,
                  //                       color: Colors.grey,
                  //                     ),
                  //                   )),
                  //             ],
                  //           ));
                  //     });

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
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: GoogleFonts.inter(fontSize: 12.sp),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'By signing up, you agree to our',
                          style: GoogleFonts.inter(
                              fontSize: 12.sp, color: Colors.black),
                        ),
                        TextSpan(
                          text:
                              'Terms , Privacy, Data, Cookies, Acceptable Use , Charge Points, Security Deposit, Return & Refund, Cancellation Policy and Copyright Policy.',
                          style: GoogleFonts.inter(
                              fontSize: 12.sp, color: Color(0xff007BFF)),
                        ),
                        TextSpan(
                          text: 'and',
                          style: GoogleFonts.inter(
                              fontSize: 12.sp, color: Colors.black),
                        ),
                        TextSpan(
                          text: ' Copyright Policy.',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Color(0xff007BFF),
                          ),
                        ),
                      ],
                    ),
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
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 5.h,
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
                        "Log in",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff007BFF),
                        ),
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

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = name.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
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
