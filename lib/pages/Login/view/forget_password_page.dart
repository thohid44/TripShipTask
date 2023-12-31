import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: customAppBar(),
      body: ListView(
       
       
        children: [
             SizedBox(
                height: 40.h,
              ),
  UnconstrainedBox(
    child: Container(
      
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
  ),
              

              SizedBox(
                height: 40.h,
              ),

              UnconstrainedBox(
                child: CustomTextForm(
                  height: 38.h,
                  width: 250.w,
                  hinttext: "Enter your email",
                  onChanged: (value){
                    print("Email $value");
                  },
                ),
              ),
                SizedBox(
                height: 25.h,
              ),

          CustomButtonOne(
                      title: "Submit",
                      btnColor: navyBlueColor,
                      height: 35.h,
                      marginLR: 95.w,
                      radius: 5.sp,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      onTab: () {
                        
                       
                   
                      })
        ],
      ),
    ));
  }
}