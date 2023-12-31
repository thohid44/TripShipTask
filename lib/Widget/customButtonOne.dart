import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomButtonOne extends StatelessWidget {
  String title;
  VoidCallback onTab;
    double? height; 
    double? width;
  Color? textColor;
  Color? btnColor;
  double? fontSize;
  double? radius;
  double? marginLR; 
  FontWeight? fontWeight;
  CustomButtonOne({
    Key? key,
    required this.title,
    required this.onTab,
    this.fontSize,
    this.height, 
    this.width, 
    this.textColor,
    this.marginLR,
    this.fontWeight,
    this.btnColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: marginLR ?? 50.w),
        height: height??45.h,
        width: width??150.w,
        decoration: BoxDecoration(
          color: btnColor ?? Colors.black,
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTab,
            child: Container(
                alignment: Alignment.center,
              //  padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  title,

                style: GoogleFonts.inter(
                        color: textColor ?? Colors.white,
                    fontWeight: fontWeight ?? FontWeight.w700,
                    fontSize: fontSize ?? 15,
                ),
                  // style: TextStyle(
                  //   color: textColor ?? Colors.white,
                  //   fontWeight: fontWeight ?? FontWeight.w700,
                  //   fontSize: fontSize ?? 15,
                  // ),
                )),
          ),
        ));
  }
}




class CustomButtonTwo extends StatelessWidget {
  String title;
  VoidCallback onTab;
    double? height; 
    double? width;
  Color? textColor;
  Color? btnColor;
  double? fontSize;
  double? radius;
  double? marginLR; 
  FontWeight? fontWeight;
  CustomButtonTwo({
    Key? key,
    required this.title,
    required this.onTab,
    this.fontSize,
    this.height, 
    this.width, 
    this.textColor,
    this.marginLR,
    this.fontWeight,
    this.btnColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
        height: height??45.h,
        width: width??150.w,
        decoration: BoxDecoration(
          color: btnColor ?? Colors.black,
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTab,
            child: Container(
                alignment: Alignment.center,
              //  padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  title,

                style: GoogleFonts.inter(
                        color: textColor ?? Colors.white,
                    fontWeight: fontWeight ?? FontWeight.w700,
                    fontSize: fontSize ?? 13,
                ),
                  // style: TextStyle(
                  //   color: textColor ?? Colors.white,
                  //   fontWeight: fontWeight ?? FontWeight.w700,
                  //   fontSize: fontSize ?? 15,
                  // ),
                )),
          ),
        ));
  }
}
