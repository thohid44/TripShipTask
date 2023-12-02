import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripshiptask/Utils/colors.dart';

class FinalForm extends StatelessWidget {
  const FinalForm({super.key});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: 300.w,
        height: 30.h,

     
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5.r),
         
          ),
        child: TextField(
        
          autofocus: false,
       
          style: TextStyle(fontSize: 15.sp),
          decoration: InputDecoration(
              hintText: 'Start Point',
              hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
              filled: true,
              fillColor: primaryColor,
              border: InputBorder.none,
            ),
          onChanged: (value) {
        
          },
        ),
      ),
    );
  }
}
