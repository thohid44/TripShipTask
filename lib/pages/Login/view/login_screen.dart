import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/Widget/space_widgeter.dart';
import 'package:tripshiptask/pages/Login/controller/LoginController.dart';
import 'package:tripshiptask/pages/Login/view/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var con = Get.put(LoginController());

  facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
    } else {
      print(result.status);
      print(result.message);
    }
  }

  bool status = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          elevation: 0,
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
                icon: Image.asset(
                  "assets/menu_bar.jpeg",
                  height: 15.h,
                  fit: BoxFit.fitHeight,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SpaceWidget(
                hight: 60.h,
              ),
              Container(
                height: 120.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: const [
                    BoxShadow(
                      color: primaryColor,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 10.0, //extend the shadow
                      // offset: Offset(
                      //   5.0, // Move to right 5  horizontally
                      //   5.0, // Move to bottom 5 Vertically
                      // ),
                    )
                  ],
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
              SizedBox(
                height: 10,
              ),
              SpaceWidget(
                hight: 30.h,
              ),
              CustomTextForm(
                  width: 260.w,
                  height: 40.h,
                  fontSize: 14.sp,
                  textController: _email,
                  hinttext: "Enter Email"),
              SizedBox(
                height: 10.h,
              ),
              UnconstrainedBox(
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: 260.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffF1F4F9)
                                .withOpacity(0.5), //color of shadow
                            spreadRadius: 8, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(5, 5), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                        ]),
                    child: TextField(
                      controller: _password,
                      autofocus: false,
                      obscureText: status,
                      style: TextStyle(fontSize: 15.sp),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                status = !status;
                              });
                            },
                            icon: status == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14.sp),
                        filled: true,
                        fillColor: primaryColor,
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
              SpaceWidget(
                hight: 30.h,
              ),
              Obx(() => con.isLoading.value == false
                  ? CustomButtonOne(
                      title: "Login",
                      btnColor: navyBlueColor,
                      marginLR: 80.w,
                      radius: 10.sp,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      onTab: () {
                        print("press login");
                        //    if (_email.text.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //     content: Text('Email filed is required!'),
                        //   ));
                        // } else if (_password.text.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //     content: Text('Password filed is required!'),
                        //   ));
                        // }
                        //   else{
                        //     con.login(
                        //       _email.text.toString(), _password.text.toString());
                        //   }

                        con.login(
                            _email.text.toString(), _password.text.toString());
                      })
                  : CircularProgressIndicator()),
              SpaceWidget(
                hight: 20.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: skyColor,
                  ),
                ),
              ),
              SpaceWidget(
                hight: 15.h,
              ),
              // Container(
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.symmetric(horizontal: 10.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       Container(
              //         child: Text(
              //           "-----------------------",
              //           style: TextStyle(
              //             fontSize: 16.sp,
              //             color: skyColor,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         child: Text(
              //           "OR",
              //           style: TextStyle(
              //             fontSize: 16.sp,
              //             color: skyColor,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         child: Text(
              //           "-----------------------",
              //           style: TextStyle(
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.w500,
              //             color: skyColor,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SpaceWidget(
              //   hight: 5.h,
              // ),
              // Container(
              //   alignment: Alignment.center,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //           child: FaIcon(FontAwesomeIcons.google, size: 20.h)),
              //       SizedBox(
              //         width: 12.w,
              //       ),
              //       Container(
              //         child: Text(
              //           "Login with Google",
              //           style: TextStyle(
              //             fontSize: 15.sp,
              //             color: skyColor,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SpaceWidget(
              //   hight: 5.h,
              // ),
              // Container(
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.only(left: 20.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //           child: FaIcon(FontAwesomeIcons.facebook, size: 22.h)),
              //       SizedBox(
              //         width: 12.h,
              //       ),
              //       Container(
              //         child: Text(
              //           "Login with Facebook",
              //           style: TextStyle(
              //             fontSize: 15.sp,
              //             color: skyColor,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 5.h,
              // ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Don't Have an Account ?",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: skyColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(RegistrationScreen());
                      },
                      child: Container(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: skyColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginTextForm extends StatelessWidget {
  TextEditingController? textController;
  double? width;
  double? height;
  double? left;
  double? right;
  String? hinttext;

  LoginTextForm(
      {super.key, this.hinttext, this.width, this.height, this.textController});
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: width ?? 100.w,
        height: height ?? 30.h,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          controller: textController,
          autofocus: false,
          obscureText: true,
          style: TextStyle(fontSize: 15.sp),
          decoration: InputDecoration(
            suffixIcon:
                IconButton(onPressed: () {}, icon: Icon(Icons.visibility)),
            hintText: hinttext ?? 'Enter hint text',
            hintStyle:
                TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp),
            filled: true,
            fillColor: primaryColor,
            border: InputBorder.none,
          ),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
