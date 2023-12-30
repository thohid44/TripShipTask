import 'package:tripshiptask/pages/Login/view/email_pin_option_screen.dart';
import 'package:tripshiptask/Email_Verify/view/email_verification.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailVerificationOptionalInfo extends StatefulWidget {
  const EmailVerificationOptionalInfo({super.key});

  @override
  State<EmailVerificationOptionalInfo> createState() =>
      _EmailVerificationOptionalInfoState();
}

class _EmailVerificationOptionalInfoState
    extends State<EmailVerificationOptionalInfo> {
  final TextEditingController area = TextEditingController();
 final TextEditingController contactPerson = TextEditingController();
  final TextEditingController emergencyContact = TextEditingController();
  List<Map<String, dynamic>> bloodList = [
    {"id": 1, "name": "A+", "slug": "A+"},
    {"id": 2, "name": "B+", "slug": "B+"},
    {"id": 3, "name": "B+", "slug": "O+"},
    {"id": 4, "name": "AB+", "slug": "AB+"},
  ];
 
   var selectBloodType;
  String? bloodValue;
  bool isBlood = false;
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("assets/logo.jpg"),
              ),
              Container(
                child: Text(
                  "Optional Information",
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
             CustomDropDown(
                height:45, 
                              width: 300.w,
                              selectEducationType: selectBloodType,
                              title: "Blood",
                              items: bloodList,
                              selectedValue: bloodValue,
                              onChanged: (value) {
                                print("object $selectBloodType");
                              },
                              labelText: "Blood Group"),
              SizedBox(
                height: 10.h,
              ),
             
              Card(
              child: Container(
            width: 300.w,
            height: 45.h,
            decoration: BoxDecoration(color: primaryColor),
            child: Expanded(
              child: TextFormField(
                controller: area,
                onChanged: (value) {
                  
                },
                decoration: InputDecoration(
                    hintText: "Your residance area",
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            )),
            ),
              SizedBox(
                height: 10.h,
              ),
                  Card(
              child: Container(
            width: 300.w,
            height: 45.h,
            decoration: BoxDecoration(color: primaryColor),
            child: Expanded(
              child: TextFormField(
                controller: contactPerson,
                onChanged: (value) {
                  
                },
                decoration: InputDecoration(
                    hintText: "Emergency Contact person's name",
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            )),
            ),
        
               
            
              SizedBox(
                height: 10.h,
              ),
                      Card(
              child: Container(
            width: 300.w,
            height: 45.h,
            decoration: BoxDecoration(color: primaryColor),
            child: Expanded(
              child: TextFormField(
                controller: emergencyContact,
                onChanged: (value) {
                  
                },
                decoration: InputDecoration(
                    hintText: "Emergency contact number",
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            )),
            ),
           
              
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 300.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 35.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: navyBlueColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Text(
                          "<< Go Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        Get.to(EmailOtpScreen());
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15.w),
                          height: 35.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: navyBlueColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Text(
                            "NEXT >>",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formWidget(String hintText, controller) {
    return Card(
      child: Container(
          width: 300.w,
          height: 45.h,
          decoration: BoxDecoration(color: primaryColor),
          child: Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: (value) {
                
              },
              decoration: InputDecoration(
                  hintText: hintText,
                  border:
                      const OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )),
    );
  }
}
