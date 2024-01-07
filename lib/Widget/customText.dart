import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  String? title;
  Color? color;
  FontWeight? fontWeight;
  dynamic size = 0;
  
  CustomText(this.title, this.color, this.fontWeight, this.size);
  @override
  Widget build(BuildContext context) {
    return Text(
      title!.toString(),
      style: GoogleFonts.inter(
        color: color ?? Colors.black,
        fontWeight: fontWeight,
        fontSize: size,
      ),
    );
  }
}

class CustomText2 extends StatelessWidget {
  String? title;
  Color? color;
  FontWeight? fontWeight;
  dynamic size = 0;
  CustomText2(this.title, this.color, this.fontWeight, this.size);
  @override
  Widget build(BuildContext context) {
    return Text(
      title!.toString(),
      style: GoogleFonts.inter(
          color: color ?? Colors.black, fontWeight: fontWeight, fontSize: size),
    );
  }
}
