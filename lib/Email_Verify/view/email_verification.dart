import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:tripshiptask/Email_Verify/scan_work_id.dart';
import 'package:tripshiptask/pages/Login/view/email_pin_option_screen.dart';
import 'package:tripshiptask/Email_Verify/view/scan_nid_page.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Email_Verify/view/profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/Widget/custom_text_field.dart';
import 'package:tripshiptask/pages/Login/controller/LoginController.dart';
import 'package:tripshiptask/text_constant_file.dart';

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
  List<Map<String, dynamic>> professionList = [
    {"id": 1, "name": "Engr", "slug": "Engr"},
    {"id": 2, "name": "Doctor", "slug": "Doctor"},
    {"id": 3, "name": "Army", "slug": "Army"},
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
  List<Map<String, dynamic>> bloodList = [
    {"id": 1, "name": "A+", "slug": "A+"},
    {"id": 2, "name": "B+", "slug": "B+"},
    {"id": 3, "name": "B+", "slug": "O+"},
    {"id": 4, "name": "AB+", "slug": "AB+"},
  ];
var selectBlood;
  String? bloodValue;

  var selectEducationType;

  String? educationValue;
  bool isEducation = false;

  var selectProfessionType;
  String? professionLValue;
  bool isProfession = false;

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
  var width = 260.w;
  var height = 36.h;
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
                icon: Image.asset(
                  "assets/menu_bar.jpeg",
                  height: 15.h,
                  fit: BoxFit.fitHeight,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20.w, right: 5.w),
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      //    Get.to(ProfilePhoto());
                    },
                    child: Column(
                      children: [
                        Container(
                            height: 80.h,
                            color: Colors.amber,
                            child: Image.asset(
                              "assets/logo2.png",
                            )),
                        Text(
                          "TripShipTask",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        ),
                        Text(
                          "Connect Assist Earn",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 9.sp),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 300.w,
                  child: SuperTooltip(
                    content: const Text(
                      "$facebookText",
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onHide: () {},
                    child: Text(
                      "Why do I need to provide the following information ?",
                      style: TextStyle(
                          color: Color(0xffFFBF00),
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp),
                    ),
                  ),
                ),
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
                  height: 2.h,
                ),
                Text("Upload Photo"),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "NID/Passport/DL is required!",
                              hinttext: "NID/Passport/DL/BirthCert",
                              onChanged: (value) {
                                controller.identityNo.value = value;

                                print(
                                    "NId Number ${controller.identityNo.value}");
                              },
                            ),
                            Container(
                              width: 17.w,
                              child: SuperTooltip(
                                content: const Text(
                                  "$nidText",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onHide: () {},
                                child: Icon(
                                  Icons.question_mark,
                                  color: Color(0xffFFBF00),
                                  size: 20.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(ScanNIDPage());
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 36.h,
                                  width: 128.w,
                                  decoration: BoxDecoration(
                                      color: offWhite,
                                      borderRadius: BorderRadius.circular(5.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffF1F4F9).withOpacity(
                                              0.5), //color of shadow
                                          spreadRadius: 8, //spread radius
                                          blurRadius: 7, // blur radius
                                          offset: Offset(3, 5),
                                        ),
                                      ]),
                                  child: Text(
                                    "ID Photo using Camera",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.sp,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(ScanNIDPage());
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 36.h,
                                  width: 128.w,
                                  decoration: BoxDecoration(
                                      color: offWhite,
                                      borderRadius: BorderRadius.circular(5.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffF1F4F9).withOpacity(
                                              0.5), //color of shadow
                                          spreadRadius: 8, //spread radius
                                          blurRadius: 7, // blur radius
                                          offset: Offset(3, 5),
                                        ),
                                      ]),
                                  child: Text(
                                    "ID Photo from Gallery",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.sp,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 2.h,
                      ),

                      Row(
                        children: [
                          CustomDropDown(
                              width: 212.w,
                              height: 35.h,
                              selectEducationType: selectEducationType,
                              title: "Education",
                              items: educationList,
                              selectedValue: selectEducationType,
                              onChanged: (value) {
                                controller.education.value = value;
                                print(
                                    "Education ${controller.education.value}");
                                print("object $selectEducationType");
                              },
                              labelText: "Education"),
                          Container(
                            width: 15.w,
                            child: SuperTooltip(
                              content: const Text(
                                "$educationText",
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onHide: () {},
                              child: Icon(
                                Icons.question_mark,
                                color: Color(0xffFFBF00),
                                size: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 2nd section
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          CustomDropDown(
                              width: 212.w,
                              height: 35.h,
                              selectEducationType: selectEducationType,
                              title: "Profession",
                              items: professionList,
                              selectedValue: selectProfessionType,
                              onChanged: (value) {
                                controller.education.value = value;
                                print(
                                    "Profession ${controller.education.value}");
                                print("object $selectEducationType");
                              },
                              labelText: "Profession"),
                          Container(
                            width: 17.w,
                            child: SuperTooltip(
                              content: const Text(
                                "$professionText",
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onHide: () {},
                              child: Icon(
                                Icons.question_mark,
                                color: Color(0xffFFBF00),
                                size: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "Company Name is Required!",
                              hinttext: "Company Name",
                              onChanged: (value) {
                                controller.companyName.value = value;
                                print(
                                    "Company Name ${controller.companyName.value}");
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "Designation is Required!",
                              hinttext: "Designation",
                              onChanged: (value) {
                                controller.designation.value = value;
                                print(
                                    "Designation ${controller.designation.value}");
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                alignment: Alignment.center,
                                height: 36.h,
                                width: 125.w,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xffF1F4F9)
                                            .withOpacity(0.5), //color of shadow
                                        spreadRadius: 8, //spread radius
                                        blurRadius: 7, // blur radius
                                        offset: Offset(
                                            3, 5), // changes position of shadow
                                        //first paramerter of offset is left-right
                                        //second parameter is top to down
                                      ),
                                    ]),
                                child: Text(
                                  "Work ID using Camera (Optional)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10.sp,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Card(
                              elevation: 5,
                              child: InkWell(
                                onTap: () {
                                  Get.to(ScanWorkId());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 36.h,
                                  width: 125.w,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffF1F4F9).withOpacity(
                                              0.5), //color of shadow
                                          spreadRadius: 8, //spread radius
                                          blurRadius: 7, // blur radius
                                          offset: Offset(3,
                                              5), // changes position of shadow
                                          //first paramerter of offset is left-right
                                          //second parameter is top to down
                                        ),
                                      ]),
                                  child: Text(
                                    "Work ID from Gallery \n(Optional)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.sp,
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "Nominee Name is Required!",
                              hinttext: "Nominee Name",
                              onChanged: (value) {
                                controller.nomineeName.value = value;
                                print(
                                    "Nominee Name ${controller.nomineeName.value}");
                              },
                            ),
                            Container(
                              width: 17.w,
                              child: SuperTooltip(
                                content: const Text(
                                  "$nomineeText",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onHide: () {},
                                child: Icon(
                                  Icons.question_mark,
                                  color: Color(0xffFFBF00),
                                  size: 20.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "Nominee Contact is Required!",
                              hinttext: "Nominee Contact",
                              onChanged: (value) {
                                controller.nomineeName.value = value;
                                print(
                                    "Nominee Name ${controller.nomineeName.value}");
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg:
                                  "Relationship with Nominee is Required!",
                              hinttext: "Relationship with Nominee",
                              onChanged: (value) {
                                controller.nominneeRelation.value = value;
                                print(
                                    "Relationship with Nominee  ${controller.nominneeRelation.value}");
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          CustomDropDown(
                              width: 212.w,
                              height: 35,
                              selectEducationType: selectEducationType,
                              title: "Question",
                              items: securityQuestionList,
                              selectedValue: selectEducationType,
                              onChanged: (value) {
                                controller.question.value = value;
                                print("Question ${controller.question.value}");
                              },
                              labelText: " Security Question"),
                          Container(
                            width: 17.w,
                            child: SuperTooltip(
                              content: const Text(
                                "$securityQesText",
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onHide: () {},
                              child: Icon(
                                Icons.question_mark,
                                color: Color(0xffFFBF00),
                                size: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          CustomDropDown(
                              width: 212.w,
                              height: 35,
                              selectEducationType: selectEducationType,
                              title: "Answer",
                              items: sequrityAnswerList,
                              selectedValue: selectEducationType,
                              onChanged: (value) {
                                controller.answer.value = value;
                                print("Month ${controller.answer.value}");
                                print("object $selectEducationType");
                              },
                              labelText: "Security Answer"),
                          Container(
                            width: 17.w,
                            child: SuperTooltip(
                              content: const Text(
                                "$securityAnsText",
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onHide: () {},
                              child: Icon(
                                Icons.question_mark,
                                color: Color(0xffFFBF00),
                                size: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 70.w,
                            margin: EdgeInsets.only(left: 5.w),
                            decoration: const BoxDecoration(),
                            child: Text(
                              "Date of Birth",
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ),
                          CustomDropDown(
                              width: 43.w,
                              height: 35.h,
                              selectEducationType: selecDay,
                              title: "Day",
                              items: dayList,
                              selectedValue: dayValue,
                              onChanged: (value) {
                                controller.day.value = value;
                                print("Day ${controller.day.value}");
                                print("object $selecDay");
                              },
                              labelText: "Day"),
                          CustomDropDown(
                              width: 55.w,
                              height: 35,
                              selectEducationType: selectMonth,
                              title: "Month",
                              items: monthList,
                              selectedValue: monthValue,
                              onChanged: (value) {
                                controller.month.value = value;
                                print("Month ${controller.month.value}");
                                print("object $selectMonth");
                              },
                              labelText: "Month"),
                          CustomDropDown(
                              width: 48.w,
                              height: 35.h,
                              selectEducationType: selectYear,
                              title: "Year",
                              items: yearList,
                              selectedValue: yearValue,
                              onChanged: (value) {
                                print("object $selectYear");
                                controller.year.value = value;
                              },
                              labelText: "Year"),
                          Container(
                            width: 17.w,
                            child: SuperTooltip(
                              content: const Text(
                                "$nidText",
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onHide: () {},
                              child: Icon(
                                Icons.question_mark,
                                color: Color(0xffFFBF00),
                                size: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "Emergency Contact Name is Required!",
                              hinttext: "Emergency Contact Name",
                              onChanged: (value) {
                                controller.emergencyContactName.value = value;
                                print(
                                    "Emergency Contact Name  ${controller.emergencyContactName.value}");
                              },
                            ),
                            Container(
                              width: 17.w,
                              child: SuperTooltip(
                                content: const Text(
                                  "$emergencyPersonName",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onHide: () {},
                                child: Icon(
                                  Icons.question_mark,
                                  color: Color(0xffFFBF00),
                                  size: 20.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "Emergency Contact Number is Required!",
                              hinttext: "Emergency Contact Number",
                              onChanged: (value) {
                                controller.emergencyContactNumber.value = value;
                                print(
                                    "Emergency Contact Number  ${controller.emergencyContactNumber.value}");
                              },
                            ),
                            Container(
                              width: 17.w,
                              child: SuperTooltip(
                                content: const Text(
                                  "$emergencyPersonNumer",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onHide: () {},
                                child: Icon(
                                  Icons.question_mark,
                                  color: Color(0xffFFBF00),
                                  size: 20.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "Residence Area",
                              hinttext: "Residence Area (Optional)",
                              onChanged: (value) {
                                controller.residanceArea.value = value;
                                print(
                                    "Residence Area  ${controller.residanceArea.value}");
                              },
                            ),
                            Container(
                              width: 17.w,
                              child: SuperTooltip(
                                content: const Text(
                                  "$residenceText",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onHide: () {},
                                child: Icon(
                                  Icons.question_mark,
                                  color: Color(0xffFFBF00),
                                  size: 20.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [

                             CustomDropDown(
                              width: 205.w,
                              height: 35.h,
                              selectEducationType: selectBlood,
                              title: "Blood",
                              items: bloodList,
                              selectedValue: bloodValue,
                              onChanged: (value) {
                                print("object $selectBlood");
                                controller.bloodGroup.value = value;
                              },
                              labelText: "Blood"),
                         
                          Container(
                            width: 17.w,
                            child: SuperTooltip(
                              content: const Text(
                                "$bloodText",
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onHide: () {},
                              child: Icon(
                                Icons.question_mark,
                                color: Color(0xffFFBF00),
                                size: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CustomTextForm(
                              width: width,
                              height: 36.h,
                              fontSize: 12.sp,
                              errorMsg: "Facebook Link ()",
                              hinttext: "Facebook Link (Optional)",
                              onChanged: (value) {
                                controller.facebookLink.value = value;
                                print(
                                    "Facebook Link   ${controller.facebookLink.value}");
                              },
                            ),
                            Container(
                              width: 17.w,
                              child: SuperTooltip(
                                content: const Text(
                                  "$facebookText",
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onHide: () {},
                                child: Icon(
                                  Icons.question_mark,
                                  color: Color(0xffFFBF00),
                                  size: 20.h,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                          title: "Submit",
                          onTab: () {
                            print("Edu ${controller.education.value}");
                            if (controller.profilePic.value.isEmpty) {
                              //    Get.snackbar("Profile", "Filed is required");
                              Fluttertoast.showToast(
                                  msg: "Profile Field is required",
                                  gravity: ToastGravity.CENTER);
                            }
                            if (controller.nidPic1.value.isEmpty) {
                              //  Get.snackbar("NID", "Filed is required");
                              Fluttertoast.showToast(
                                  msg: "NID Field is required");
                            }
                            if (controller.nidPic2.value.isEmpty) {
                              Get.snackbar("NID", "Field is required");
                            } else if (controller.education.value.isEmpty) {
                              Get.snackbar("Education", "Field is required");
                            } else if (controller.question.value.isEmpty) {
                              Get.snackbar("Question", "Field is required");
                            } else if (controller.answer.value.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Answer Field is required");
                            } else if (controller.idPic1.value.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Work ID Front Field is required");
                            } else if (controller.idPic2.value.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Work ID Back Field is required");
                            } else if (controller.day.value.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Day Field is required");
                            } else if (controller.month.value.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Month Field is required");
                            } else if (controller.year.value.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Year Field is required");
                            } else {
                              controller.registrationTwo();
                            }
                          }),

                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
      elevation: 5,
      child: Container(
          padding: EdgeInsets.only(left: 10.w),
          decoration: BoxDecoration(color: primaryColor, boxShadow: [
            BoxShadow(
              color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
              spreadRadius: 8, //spread radius
              blurRadius: 7, // blur radius
              offset: Offset(3, 5), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
          ]),
          alignment: Alignment.center,
          height: widget.height.h ?? 35.h,
          width: widget.width.w ?? 290.w,
          child: DropdownButton(
              isExpanded: true,
              hint: Text(
                "${isEducation ? valueName : widget.labelText}",
                style:
                    TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
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
                          if (widget.title == "Profession") {
                            con.profession.value = valueName = e['name'];
                            print(con.profession.value);
                          }
                          if (widget.title == "Question") {
                            con.question.value = valueName = e['name'];
                            print(con.question.value);
                          }
                          if (widget.title == "Answer") {
                            con.answer.value = valueName = e['name'];
                            print(con.answer.value);
                          }
                          if (widget.title == "Day") {
                            con.day.value = valueName = e['name'];
                            print(con.day.value);
                          }
                          if (widget.title == "Month") {
                            con.month.value = valueName = e['name'];
                            print(con.month.value);
                          }
                          if (widget.title == "Year") {
                            con.year.value = valueName = e['name'];
                            print(con.year.value);
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
