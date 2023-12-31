import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Email_Verify/view/email_verification.dart';

import 'package:tripshiptask/Widget/customText.dart';

import 'package:tripshiptask/pages/Trip/views/get_a_ride/get_trip_List_posts.dart';

import 'package:tripshiptask/pages/Trip/views/get_a_ride/get_A_Ride.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/give_trip_post.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_give_search_page.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_List_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/pages/Trip/views/trip_give_search_new23.dart';


class TripPage extends StatefulWidget {
  TripPage({super.key});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UnconstrainedBox(
            child: Container(
              width: 306.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          //E6E7E8
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Text(
                        "Give a Ride",
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
                        index = 3;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 152.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          color: index == 3 ? Color(0xff4CA4C7) : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: Text(
                        "Get a Ride",
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
            height: 3.h,
          ),
          UnconstrainedBox(
            child: Container(
              width: 306.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 4;
                      });
                    },
                    child: Container(
                        width: 85.w,
                        height: 28.h,
                        child: TextField(
                          onTap: () {
                            Get.to(TripGiveSearchNew23());
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 5.w, top: 1.h),
                            hintText: "Search",
                            hintStyle: GoogleFonts.inter(fontSize: 11.sp, fontWeight: FontWeight.w400),
                            suffixIcon: Icon(Icons.search, size: 20.h,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 111.w,
                        height: 28.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: index == 0 ? Color(0xff4CA4C7) : Colors.grey,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: CustomText("Give a Ride Posts", Colors.white,
                            FontWeight.w500, 11.sp)),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 106.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                            color: index == 1 ? Color(0xff4CA4C7) : Colors.grey,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Text(
                          "Get a Ride Posts",
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              height: 500.h,
              child: widgetList[index]),
        ],
      ),
    );
  }

  int index = 0;

  List<Widget> widgetList = [
    TripGivePosts(),
    TripGetPosts(),
    GiveTripPost(),
    GetARide(),
  ];
}

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff272e48),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          )),
      child: InkWell(
        onTap: () {
          Get.to(EmailVerification());
        },
        child: Row(
          children: [
            Container(
                alignment: Alignment.center,
                height: 35.h,
                width: 70.w,
                child: Icon(
                  Icons.person,
                  size: 35.h,
                  color: white,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 110.w,
                  child: CustomText(
                      "Zakir Hossain", white, FontWeight.w500, 13.sp),
                ),
                Container(
                  width: 110.w,
                  child: CustomText(
                      "Acct : Verified", white, FontWeight.w500, 13.sp),
                )
              ],
            ),
            Container(
                width: 150.w,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 15.w),
                height: 30.h,
                decoration: BoxDecoration(
                    color: lightNavyColor,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: navyBlueColor,
                      child: CustomText("\$", white, FontWeight.bold, 13.sp),
                    ),
                    CustomText(
                      "Tab For Balance",
                      white,
                      FontWeight.w400,
                      13.sp,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
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
          hintStyle: TextStyle(fontSize: 12.sp),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 0.0.r)),
          contentPadding: EdgeInsets.only(top: 5.h, left: 3.w)),
    );
  }
}

// AppBar customAppBar() {
//   return AppBar(
//     elevation: 0,
//     title: const Text(
//       "Trip Ship Task",
//       style: TextStyle(color: Colors.black),
//     ),
//     centerTitle: true,
//     backgroundColor: Colors.white,
//     leading: IconButton(
//         onPressed: () {
//           Get.back();
//         },
//         icon: const Icon(
//           Icons.arrow_back_ios_new,
//           color: Colors.black,
//         )),
//     actions: [
//       IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             Icons.menu,
//             color: Colors.black,
//           )),
//     ],
//   );
// }
