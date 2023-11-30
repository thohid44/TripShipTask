import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetButton extends StatelessWidget {
  String title;
   WidgetButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Text(
        "$title",
        style: TextStyle(
            color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}
