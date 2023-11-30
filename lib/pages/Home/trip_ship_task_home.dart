import 'package:tripshiptask/Email_Verify/view/email_verification.dart';

import 'package:tripshiptask/Widget/customText.dart';

import 'package:tripshiptask/pages/Ship/views/shipPage.dart';
import 'package:tripshiptask/pages/Task/views/task_home_page.dart';

import 'package:tripshiptask/pages/Trip/views/trip_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
class TripShipTaskHome extends StatefulWidget {
  var trip;
  var ship;
  var task;
  TripShipTaskHome({super.key, this.trip, this.ship, this.task});

  @override
  State<TripShipTaskHome> createState() => _TripShipTaskHomeState();
}

class _TripShipTaskHomeState extends State<TripShipTaskHome> {
  final TextEditingController search = TextEditingController();

  int index = 0;

  bool tripStatus = true;

  bool shipStatus = true;

  bool taskStatus = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: ListView(
        children: [
          CustomAppBar2(),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  index = 0;
                  tripStatus = true;
                  widget.trip = true;
                  shipStatus = false;
                  taskStatus = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 25.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color:
                          tripStatus == widget.trip ? tealColor : Colors.grey,
                      borderRadius: BorderRadius.circular(5.r)),
                  child:
                      CustomText("Trip", Colors.white, FontWeight.w600, 13.sp),
                ),
              ),
              InkWell(
                onTap: () {
                  index = 1;
                  tripStatus = false;
                  widget.ship = true;
                  shipStatus = true;
                  taskStatus = false;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 25.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color:
                          shipStatus == widget.ship ? tealColor : Colors.grey,
                      borderRadius: BorderRadius.circular(5.r)),
                  child:
                      CustomText("Ship", Colors.white, FontWeight.w600, 13.sp),
                ),
              ),
              InkWell(
                onTap: () {
                  index = 2;
                  tripStatus = false;
                  shipStatus = false;
                  taskStatus = true;
                  widget.task = true;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 25.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color:
                          taskStatus == widget.task ? tealColor : Colors.grey,
                      borderRadius: BorderRadius.circular(5.r)),
                  child:
                      CustomText("Task", Colors.white, FontWeight.w600, 13.sp),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(height: 600.h, child: widgetList[index]),
        ],
      ),
    );
  }

  List<Widget> widgetList = [TripPage(), ShipHomePage(), TaskHomePage()];
}

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: navyBlueColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          )),
      child: InkWell(
        onTap: () {
          Get.to(EmailVerification());
        },
        child: Row(
          children: [
            Container(
                alignment: Alignment.center,
                height: 35.h,
                width: 70.w,
                child: Icon(
                  Icons.person,
                  size: 35.h,
                  color: white,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 110.w,
                  child: CustomText(
                      "Zakir Hossain", white, FontWeight.w500, 13.sp),
                ),
                Container(
                  width: 110.w,
                  child: CustomText(
                      "Acct : Verified", white, FontWeight.w500, 13.sp),
                )
              ],
            ),
            Container(
                width: 150.w,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 15.w),
                height: 30.h,
                decoration: BoxDecoration(
                    color: lightNavyColor,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: navyBlueColor,
                      child: CustomText("\$", white, FontWeight.bold, 13.sp),
                    ),
                    CustomText(
                      "Tab For Balance",
                      white,
                      FontWeight.w400,
                      13.sp,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class CustomForm extends StatelessWidget {
  TextEditingController? textController;
  double? radius;
  String? hinttext;

  CustomForm({super.key, this.hinttext, this.radius, this.textController});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hinttext ?? "Enter Data",
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 0.0.r)),
      ),
    );
  }
}

AppBar customAppBar() {
  return AppBar(
    elevation: 0,
    title: const Text(
      "Trip Ship Task",
      style: TextStyle(color: Colors.black),
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
            Icons.menu,
            color: Colors.black,
          )),
    ],
  );
}
