import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Final Form

class CustomTextForm1 extends StatelessWidget {
  TextEditingController? textController;
  double? width;
  double? height;
  double? left;
  double? right;
  String? hinttext;
  String? errorMsg;
  double? fontSize;
  final ValueChanged<String>? onChanged;
  CustomTextForm1(
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
          height: 38,
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
              hintStyle: TextStyle(
                  fontWeight: FontWeight.normal, fontSize: fontSize ?? 11.sp),
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
    return Material(
      elevation: 8,
      color: primaryColor,
      shadowColor: primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        alignment: Alignment.center,
        width: width ?? 100.w,
          height: 38.h,
        child: TextFormField(
          textAlign: TextAlign.left,
          style: TextStyle(
            height: 1.5, // Line height
          ),
          controller: textController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            hintText: hinttext ?? 'Enter hint text',
            hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.normal, fontSize: fontSize ?? 13.sp),
            filled: true,
            fillColor: primaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.0),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.0),
              borderSide: BorderSide.none,
            ),
            errorStyle:
                TextStyle(height: 0), // Removes extra space for error text
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
    );
  }
}
