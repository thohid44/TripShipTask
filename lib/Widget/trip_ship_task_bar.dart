import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Task/views/task_home_page.dart';
import 'package:tripshiptask/pages/Trip/views/trip_page.dart';
import '../pages/Ship/views/shipPage.dart';

class TripShipTaskBar extends StatefulWidget {
  @override
  State<TripShipTaskBar> createState() => _TripShipTaskBarState();
}

class _TripShipTaskBarState extends State<TripShipTaskBar> {
  bool tripStatus = false;

  bool shipStatus = false;

  bool taskStatus = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          height: 25.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: tripStatus == true ? tealColor : Colors.grey,
              borderRadius: BorderRadius.circular(5.r)),
          child: InkWell(
              onTap: () {
                Get.to(TripPage());
                tripStatus = true;
                shipStatus = false;
                taskStatus = false;
                setState(() {});
              },
              child: CustomText("Trip", Colors.white, FontWeight.w600, 13.sp)),
        ),
        Container(
          alignment: Alignment.center,
          height: 25.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: shipStatus == true ? tealColor : Colors.grey,
              borderRadius: BorderRadius.circular(5.r)),
          child: InkWell(
              onTap: () {
                Get.to(ShipHomePage());
                tripStatus = false;
                shipStatus = true;
                taskStatus = false;
                setState(() {});
              },
              child: CustomText("Ship", Colors.white, FontWeight.w600, 13.sp)),
        ),
        Container(
          alignment: Alignment.center,
          height: 25.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: taskStatus == true ? tealColor : Colors.grey,
              borderRadius: BorderRadius.circular(5.r)),
          child: InkWell(
              onTap: () {
                Get.to(TaskHomePage());
                tripStatus = false;
                shipStatus = false;
                taskStatus = true;
                setState(() {});
              },
              child: CustomText("Task", Colors.white, FontWeight.w600, 13.sp)),
        )
      ],
    );
  }
}
