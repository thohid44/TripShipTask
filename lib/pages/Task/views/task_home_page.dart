import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/pages/Task/views/offer_a_task.dart';
import 'package:tripshiptask/pages/Task/views/task_post.dart';
import 'package:tripshiptask/pages/Task/views/task_seek_post.dart';
import 'package:tripshiptask/pages/Task/views/want_a_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TaskHomePage extends StatefulWidget {
  TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 160.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: index == 1 ? Color(0xff4CA4C7) : Colors.grey,
                      //E6E7E8
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Text(
                    "Give a task",
                    style: TextStyle(
                      fontSize: 11.sp,
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
                  width: 160.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: index == 2 ? Color(0xff4CA4C7) : Colors.grey,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Text(
                    "Get a task",
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextForm(
                hinttext: "Search",
                width: 100.w,
                height: 35.h,
                textController: search,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    index = 3;
                  });
                },
                child: Container(
                  height: 30.h,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: index == 3 ? Color(0xff4CA4C7) : Colors.grey,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        size: 20.h,
                        color: Colors.white,
                      ),
                      CustomText("Task Seek Posts", Colors.white,
                          FontWeight.w500, 12.sp)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Container(
                  height: 30.h,
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: index == 0 ? Color(0xff4CA4C7) : Colors.grey,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        size: 20.h,
                        color: Colors.white,
                      ),
                      CustomText("Task Give Posts", Colors.white,
                          FontWeight.w500, 12.sp)
                    ],
                  ),
                ),
              )
            ],
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

AppBar customAppBar() {
  return AppBar(
    elevation: 0,
    title: Text(
      "Trip Ship Task",
      style: TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        )),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.filter,
            color: Colors.black,
          )),
    ],
  );
}
