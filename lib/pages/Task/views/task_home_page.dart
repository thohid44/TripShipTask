import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/pages/Home/view/home_screen.dart';
import 'package:tripshiptask/pages/Task/views/offer_a_task.dart';
import 'package:tripshiptask/pages/Task/views/task_give_search.dart';
import 'package:tripshiptask/pages/Task/views/task_post.dart';
import 'package:tripshiptask/pages/Task/views/task_seek_post.dart';
import 'package:tripshiptask/pages/Task/views/want_a_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';

class TaskHomePage extends StatefulWidget {
  TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final TextEditingController search = TextEditingController();
  var fullWidth = 306.w;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UnconstrainedBox(
            child: Container(
              width: fullWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 152.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          color: index == 1 ? Color(0xff4CA4C7) : Colors.grey,
                          //E6E7E8
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Text(
                        "Give a task",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 2;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 152.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          color: index == 2 ? Color(0xff4CA4C7) : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Text(
                        "Get a task",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          UnconstrainedBox(
            child: Container(
              width: fullWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 100.w,
                      height: 28.h,
                      child: TextField(
                        onTap: () {
                         Get.to(TaskGiveSearch());
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.w, top: 5.h),
                          hintText: "Search",
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.r)),
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 3;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 28.h,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: index == 3 ? Color(0xff4CA4C7) : Colors.grey,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: CustomText("Get a Task Posts", Colors.white,
                            FontWeight.w500, 11.sp)),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 28.h,
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: index == 0 ? Color(0xff4CA4C7) : Colors.grey,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: CustomText("Give a Task Posts", Colors.white,
                            FontWeight.w500, 11.sp)),
                  )
                ],
              ),
            ),
          ),
          Container(height: 600.h, child: widgetList[index])
        ],
      ),
    );
  }

  int index = 0;

  List<Widget> widgetList = [
    TaskPost(),
    OfferATask(),
    WantATask(),
    TaskSeekPost()
  ];
}

class CustomForm extends StatelessWidget {
  TextEditingController? textController;
  double? radius;
  String? hinttext;

  CustomForm({super.key, this.hinttext, this.radius, this.textController});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hinttext ?? "Enter Data",
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 0.0.r)),
      ),
    );
  }
}



