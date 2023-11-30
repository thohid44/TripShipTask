import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WantATask2 extends StatelessWidget {
  WantATask2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            margin: EdgeInsets.all(3.0.w),
            padding: EdgeInsets.all(8.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pick UP",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
                Text(
                  "Drop Off",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
                Text(
                  "Material",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
                Text(
                  "Pick Up Date",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
                Text(
                  "Delivery Date",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
                Text(
                  "Action",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Note",
              border: OutlineInputBorder(),
            ),
            maxLines: 10,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Note",
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        CustomButtonOne(
          title: "Sumbit",
          onTab: () {},
          height: 40.h,
          width: 150.w,
          btnColor: navyBlueColor,
          radius: 10.r,
        )
      ],
    );
  }
}
