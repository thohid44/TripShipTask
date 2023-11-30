import 'package:tripshiptask/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatelessWidget {
  TextEditingController? textController;
  double? width;
  double? height;
  double? left;
  double? right;
  String? hinttext;

  CustomTextForm(
      {super.key, this.hinttext, this.width, this.height, this.textController});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: width ?? 100.w,
      height: height ?? 40.h,
      //  margin: EdgeInsets.only(left:left?? 20.w, right: right??20.w),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: primaryColor,
              blurStyle: BlurStyle.outer,
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 5  horizontally
                5.0, // Move to bottom 5 Vertically
              ),
            )
          ]),
      child: TextFormField(
        controller: textController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: hinttext ?? "Enter Data",
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 10.w)),
      ),
    );
  }
}
