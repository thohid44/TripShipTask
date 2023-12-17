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
  String? errorMsg;
  double? fontSize;
   final ValueChanged<String>? onChanged;
  CustomTextForm(
      {super.key,
      this.hinttext,
      this.width,
      this.height,
      this.fontSize,
      this.textController,
      this.onChanged,
      this.errorMsg});
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Card(
        elevation: 5,
        child: Container(
          width: width ?? 100.w,
          height: height ?? 25.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
              ]),
          child: TextFormField(
            controller: textController,
            autofocus: false,
            style: TextStyle(fontSize: 11.sp),
            decoration: InputDecoration(
              hintText: hinttext ?? 'Enter hint text',
              hintStyle:
                  TextStyle(fontWeight: FontWeight.normal, fontSize: fontSize?? 11.sp),
              filled: true,
              fillColor: primaryColor,
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return errorMsg;
              }
              return null;
            },
        onChanged: onChanged,

          ),
        ),
      ),
    );
  }
}
