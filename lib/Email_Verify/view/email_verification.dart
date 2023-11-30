import 'package:tripshiptask/Email_Verify/view/email_pin_option_screen.dart';
import 'package:tripshiptask/Email_Verify/view/scan_nid_page.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Email_Verify/view/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/pages/Login/controller/LoginController.dart';

import 'email_verification_optional_information.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  List<Map<String, dynamic>> educationList = [
    {"id": 1, "name": "SSC", "slug": "vaccination"},
    {"id": 2, "name": "HSC", "slug": "deworming"},
    {"id": 3, "name": "Diploma", "slug": "tick_flea"},
    {"id": 4, "name": "Degree", "slug": "measurement"},
    {"id": 5, "name": "Honours", "slug": "hygiene"},
    {"id": 6, "name": "BBA", "slug": "medicine"},
    {"id": 7, "name": "MBA", "slug": "vet_visit"},
    {"id": 8, "name": "MA", "slug": "reports"},
  ];
  List<Map<String, dynamic>> securityQuestionList = [
    {"id": 1, "name": "What is your pet name", "slug": "petname"},
    {"id": 2, "name": "What is your nick name", "slug": "deworming"},
    {"id": 3, "name": "Which city do you live", "slug": "tick_flea"},
  ];
  List<Map<String, dynamic>> sequrityAnswerList = [
    {"id": 1, "name": "Cat", "slug": "vaccination"},
    {"id": 2, "name": "Chittagong", "slug": "deworming"},
    {"id": 3, "name": "Johan", "slug": "tick_flea"},
  ];
  List<Map<String, dynamic>> yearList = [
    {"id": 1, "name": "1980", "slug": "1980"},
    {"id": 2, "name": "1981", "slug": "1981"},
    {"id": 3, "name": "1982", "slug": "1982"},
    {"id": 4, "name": "1983", "slug": "1983"},
    {"id": 5, "name": "1984", "slug": "1984"},
    {"id": 6, "name": "1985", "slug": "1985"},
    {"id": 7, "name": "1986", "slug": "1986"},
    {"id": 8, "name": "1987", "slug": "1987"},
  ];

  List<Map<String, dynamic>> monthList = [
    {"id": 1, "name": "January", "slug": "January"},
    {"id": 2, "name": "February", "slug": "February"},
    {"id": 3, "name": "March", "slug": "March"},
    {"id": 4, "name": "April", "slug": "April"},
    {"id": 5, "name": "May", "slug": "May"},
    {"id": 6, "name": "June", "slug": "June"},
    {"id": 7, "name": "July", "slug": "July"},
    {"id": 8, "name": "August", "slug": "August"},
    {"id": 9, "name": "September", "slug": "September"},
    {"id": 10, "name": "October", "slug": "October"},
    {"id": 11, "name": "November", "slug": "November"},
    {"id": 12, "name": "December", "slug": "December"},
  ];

  List<Map<String, dynamic>> dayList = [
    {"id": 1, "name": "1", "slug": "vaccination"},
    {"id": 2, "name": "2", "slug": "deworming"},
    {"id": 3, "name": "3", "slug": "tick_flea"},
    {"id": 4, "name": "4", "slug": "measurement"},
    {"id": 5, "name": "5", "slug": "hygiene"},
    {"id": 6, "name": "6", "slug": "medicine"},
    {"id": 7, "name": "7", "slug": "vet_visit"},
    {"id": 8, "name": "8", "slug": "reports"},
    {"id": 9, "name": "9", "slug": "deworming"},
    {"id": 10, "name": "10", "slug": "tick_flea"},
    {"id": 11, "name": "11", "slug": "measurement"},
    {"id": 12, "name": "12", "slug": "hygiene"},
    {"id": 13, "name": "13", "slug": "medicine"},
    {"id": 14, "name": "14", "slug": "vet_visit"},
    {"id": 15, "name": "15", "slug": "reports"},
    {"id": 16, "name": "16", "slug": "vaccination"},
    {"id": 17, "name": "17", "slug": "deworming"},
    {"id": 18, "name": "18", "slug": "tick_flea"},
    {"id": 19, "name": "19", "slug": "measurement"},
    {"id": 20, "name": "20", "slug": "hygiene"},
    {"id": 21, "name": "21", "slug": "medicine"},
    {"id": 22, "name": "22", "slug": "vet_visit"},
    {"id": 23, "name": "23", "slug": "reports"},
    {"id": 24, "name": "24", "slug": "tick_flea"},
    {"id": 25, "name": "25", "slug": "measurement"},
    {"id": 26, "name": "26", "slug": "hygiene"},
    {"id": 27, "name": "27", "slug": "medicine"},
    {"id": 28, "name": "28", "slug": "vet_visit"},
    {"id": 29, "name": "29", "slug": "reports"},
    {"id": 30, "name": "30", "slug": "vet_visit"},
    {"id": 31, "name": "31", "slug": "reports"},
  ];

  var selectEducationType;
  String? educationValue;
  bool isEducation = false;
  var selectQuestionType;
  String? questionValue;
  bool isQuestion = false;
  var selectAnswerType;
  String? answerValue;
  bool isAnswer = false;
  var selecDay;
  String? dayValue;
  bool isDay = false;
  var selectMonth;
  String? monthValue;
  bool isMonth = false;
  var selectYear;
  String? yearValue;
  bool isYear = false;
  var controller = Get.put(LoginController());

//  var image;
//   final ImagePicker _picker = ImagePicker();

//   XFile? file;

//   int showComment = 0;
//   var gender;
//   var petBreedId;

//   Future galleryImage() async {
//     final XFile tempImage =
//         (await _picker.pickImage(source: ImageSource.gallery))!;

//     setState(() {
//       image = tempImage.path;
//       file = tempImage;
//       print(tempImage.name);
//       print("iamge $image");
//     });
//   }
  String? _selectedValue;

  String day = "Education";
  String month = "Month";
  String year = "Year";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              InkWell(
                onTap: () {
                  Get.to(ProfilePhoto());
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/logo.jpg",
                      height: 100.h,
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomText("Why do I need to provide the following information?",
                  Colors.grey, FontWeight.bold, 13.sp),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(ProfilePhoto());
                },
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: cameraColor,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Icon(
                    Icons.camera_enhance,
                    size: 40.h,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 50.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: offWhite,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              "Govt Id/NID/Passport/DL",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            )),
                        InkWell(
                          onTap: () {
                            Get.to(ScanNIDPage());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: offWhite,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              "Front Photo",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: offWhite,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            "Front Photo",
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    // 2nd section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 40.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: offWhite,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              "Profession",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                            )),
                        Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: offWhite,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                size: 20.h,
                              ),
                              Text(
                                "ID front \n(Optional)",
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: offWhite,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                size: 20.h,
                              ),
                              Text(
                                "ID Back \n(Optional)",
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),

                    CustomDropDown(
                        width: 320,
                           height: 35,
                        selectEducationType: selectEducationType,
                        title: "Education",
                        items: educationList,
                        selectedValue: selectEducationType,
                        onChanged: (value) {
                          print("object $selectEducationType");
                        },
                        labelText: "Education"),
                    CustomDropDown(
                        width: 320,
                           height: 35,
                        selectEducationType: selectEducationType,
                        title: "Question",
                        items: securityQuestionList,
                        selectedValue: selectEducationType,
                        onChanged: (value) {
                          print("object $selectEducationType");
                        },
                        labelText: "Security Question"),
                    CustomDropDown(
                        width: 320,
                           height: 35,
                        selectEducationType: selectEducationType,
                        title: "Answer",
                        items: sequrityAnswerList,
                        selectedValue: selectEducationType,
                        onChanged: (value) {
                          print("object $selectEducationType");
                        },
                        labelText: "Security Answer"),

                    Row(
                      children: [
                        Container(
                          width: 80.w,
                          decoration: const BoxDecoration(),
                          child: Text(
                            "Date of Birth",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                        CustomDropDown(
                            width: 60.w,
                               height: 35,
                            selectEducationType: selecDay,
                            title: "Day",
                            items: dayList,
                            selectedValue: dayValue,
                            onChanged: (value) {
                              print("object $selecDay");
                            },
                            labelText: "Day"),
                        CustomDropDown(
                            width: 85.w,
                               height: 35,
                            selectEducationType: selectMonth,
                            title: "Month",
                            items: monthList,
                            selectedValue: monthValue,
                            onChanged: (value) {
                              print("object $selectMonth");
                            },
                            labelText: "Month"),
                        CustomDropDown(
                            width: 70.w,
                            height: 35,
                            selectEducationType: selectYear,
                            title: "Year",
                            items: yearList,
                            selectedValue: yearValue,
                            onChanged: (value) {
                              print("object $selectYear");
                            },
                            labelText: "Year"),
                      ],
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButtonOne(
                        marginLR: 80.w,
                        width: 100.w,
                        btnColor: navyBlueColor,
                        radius: 15.r,
                        height: 35.h,
                        title: "NEXT",
                        onTab: () {
                          //   if (controller.profilePic.value.isEmpty) {
                          //     Get.snackbar("Profile", "Filed is required");
                          //   }
                          //   if (controller.nidPic1.value.isEmpty) {
                          //     Get.snackbar("NID", "Filed is required");
                          //   }
                          //   if (controller.nidPic2.value.isEmpty) {
                          //     Get.snackbar("NID", "Filed is required");
                          //   } else if (educationValue == null) {
                          //     Get.snackbar("Education", "Filed is required");
                          //   } else if (questionValue == null) {
                          //     Get.snackbar("Education", "Filed is required");
                          //   } else if (answerValue == null) {
                          //     Get.snackbar("Education", "Filed is required");
                          //   } else {
                          //     Get.to(EmailVerificationOptionalInfo());
                          //   }
                          Get.to(EmailVerificationOptionalInfo());
                        }),

                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomDropDown extends StatefulWidget {
  double width;
  double height; 
  var title;
  var selectEducationType;
  final List<Map<String, dynamic>> items;
  final selectedValue;
  final Function onChanged;
  final String labelText;

  CustomDropDown(
      {required this.width,
      required this.height, 
      required this.title,
      required this.items,
      required this.selectedValue,
      required this.onChanged,
      required this.labelText,
      this.selectEducationType});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool isEducation = false;
  String? valueName;
  var con = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.only(left: 4.w),
          decoration: BoxDecoration(color: primaryColor),
          alignment: Alignment.center,
          height:widget.height.h?? 35.h,
          width: widget.width.w ?? 340.w,
          child: DropdownButton(
              isExpanded: true,
              hint: Text(
                "${isEducation ? valueName : widget.labelText}",
                style: TextStyle(fontSize: 12.sp),
              ),
              underline: SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              value: widget.selectedValue,
              items: widget.items
                  .map((e) => DropdownMenuItem(
                        onTap: () {
                          if (widget.title == "Education") {
                            con.education.value = valueName = e['name'];
                            print(con.education.value);
                          }
                          if (widget.title == "Question") {
                            con.education.value = valueName = e['name'];
                            print(con.education.value);
                          }
                          if (widget.title == "Answer") {
                            con.education.value = valueName = e['name'];
                            print(con.education.value);
                          }
                          if (widget.title == "Day") {
                            con.education.value = valueName = e['name'];
                            print(con.education.value);
                          }
                          if (widget.title == "Month") {
                            con.education.value = valueName = e['name'];
                            print(con.education.value);
                          }
                          if (widget.title == "Year") {
                            con.education.value = valueName = e['name'];
                            print(con.education.value);
                          }
                          if (widget.title == "Blood") {
                            con.bloodGroup.value = valueName = e['name'];
                            print(con.bloodGroup.value);
                          }
                        },
                        value: e['id'],
                        child: Text(
                          "${e['name']}",
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                var id = value;

                print("$valueName Id $id");

                setState(() {
                  isEducation = true;
                });
              })),
    );
  }
}
