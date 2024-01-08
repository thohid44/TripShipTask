import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Email_Verify/view/email_verification.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/app_bar_widget_1.dart';

import 'package:tripshiptask/Widget/customText.dart';

import 'package:tripshiptask/pages/Ship/views/shipPage.dart';
import 'package:tripshiptask/pages/Task/views/task_home_page.dart';

import 'package:tripshiptask/pages/Trip/views/trip_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';

class TripShipTaskHome extends StatefulWidget {
  var trip;
  var ship;
  var task;
  var t;
  TripShipTaskHome({super.key, this.trip,this.t, this.ship, this.task});

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
      appBar: customAppBar1(),
      body: ListView(
        children: [
          CustomAppBar2(),
          SizedBox(
            height: 3.h,
          ),
          UnconstrainedBox(
            child: Container(
              width: 306.w,
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      height: 30.h,
                      width: 99.w,
                      decoration: BoxDecoration(
                          color: tripStatus == widget.trip
                              ? Color(0xff272e48)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Text("Trip",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              letterSpacing: 1.0)),
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
                        height: 30.h,
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: shipStatus == widget.ship
                                ? Color(0xff272e48)
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Text(
                          "Ship",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              letterSpacing: 1.0),
                        )),
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
                      height: 30.h,
                      width: 99.w,
                      decoration: BoxDecoration(
                          color: taskStatus == widget.task
                              ? Color(0xff272e48)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Text(
                        "Task",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            letterSpacing: 1.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(height: 600.h, child: widgetList[index]),
        ],
      ),
    );
  }

  List<Widget> widgetList = [TripPage(), ShipHomePage(), TaskHomePage()];
}

class CustomAppBar2 extends StatelessWidget {
  final _box = GetStorage();
  CustomAppBar2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff272e48),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          )),
      child: InkWell(
        onTap: () {},
        child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: CircleAvatar(
                radius: 25.r,
                backgroundImage: AssetImage("assets/Thohid.jpg"),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110.w,
                    child: CustomText("${_box.read(LocalStoreKey.fullName)}",
                        white, FontWeight.w500, 13.sp),
                  ),
                  Container(
                    width: 110.w,
                    child: CustomText(
                        "Acct: ${_box.read(LocalStoreKey.accountNo)}",
                        white,
                        FontWeight.w500,
                        13.sp),
                  )
                ],
              ),
            ),
            Container(
                // width: 120.w,
                // padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                // alignment: Alignment.center,
                // margin: EdgeInsets.only(right: 5.w),
                // height: 35.h,
                // decoration: BoxDecoration(
                //     color: lightNavyColor,
                //     borderRadius: BorderRadius.circular(20.r)),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     CustomText(
                //       "BAL (TK): 2000",
                //       white,
                //       FontWeight.w600,
                //       13.sp,
                //     ),
                //   ],
                // ),
                )
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
        border: OutlineInputBorder(),
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
      "TripShipTask",
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
          onPressed: () {
            Get.to(UserDeshBoard());
          },
          icon: Image.asset(
            "assets/menu_bar.jpeg",
            height: 15.h,
            fit: BoxFit.fitHeight,
          )),
    ],
  );
}
