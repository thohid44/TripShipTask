import 'package:tripshiptask/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Final Form

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
    return UnconstrainedBox(
      child: Container(
        width: width ?? 100.w ,
        height: height?? 30.h,

     
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5.r),
         
          ),
        child: TextField(
         controller: textController,
          autofocus: false,
       
          style: TextStyle(fontSize: 15.sp),
          decoration: InputDecoration(
              hintText: hinttext??'Enter hint text',
              hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp),
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
