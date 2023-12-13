import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/pages/Login/view/login_screen.dart';
import 'package:tripshiptask/pages/Trip/views/my_trips_offer_page.dart';
import 'package:tripshiptask/profile/view/all_Task_page.dart';
import 'package:tripshiptask/profile/view/all_Trips_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/profile/view/all_ship_page.dart';
import 'package:tripshiptask/rating/view/all_ship_rating_page.dart';
import 'package:tripshiptask/rating/view/all_task_rating_page.dart';
import 'package:tripshiptask/rating/view/all_trip_rating_page.dart';

import '../../pages/Task/views/task_home_page.dart';

class UserDeshBoard extends StatefulWidget {
  const UserDeshBoard();
  @override
  State<UserDeshBoard> createState() => _UserDeshBoardState();
}

class _UserDeshBoardState extends State<UserDeshBoard> {
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: customAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Container(
                
                height: 600.h,
                width: 190.w,
                decoration: BoxDecoration(
                  color: primaryColor
                ),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    ExpansionTile(
     trailing: SizedBox(),
                      title: Text(
                        "Dashboard",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15.sp),
                      ),
                     
                    ),
                    ExpansionTile(
                     expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                      title: Text(
                        "Trip",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15.sp),
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40.w),
                          //   height: 40.h,
                          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5.w))
                          ),
                          child: Text(
                            "Post a Trip",
                            style: TextStyle(
                                fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(AllTripsPage(),
                                transition: Transition.rightToLeft);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 40.w),
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                               decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5.w))
                          ),
                            //      height: 40.h,
                            child: Text(
                              "My Trips",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(MyTripsOfferPage(),
                                transition: Transition.leftToRight);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 40.w),
                            //   height: 40.h,
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
   decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5.w))
                          ),
                            child: Text(
                              "My Trip offers",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(AllTripRatingPage(),
                                transition: Transition.leftToRight);
                          },
                          child: Row(
                            children: [
                              // Icon(Icons.rate_review),
                              Container(
                            margin: EdgeInsets.only(left: 40.w),
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                               decoration: BoxDecoration(
                      //      border: Border(bottom: BorderSide(width: 0.5.w, color: Colors.black38))
                          ),
                            //      height: 40.h,
                            child: Text(
                              "My Trip Ratings ",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                            ],
                          )
                        )
                      ],
                    ),
                    ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                      title: Text(
                        "Ship",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15.sp),
                      ),
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40.w),
                          //   height: 40.h,
                          padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
   decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5.w, color: Colors.black38))
                          ),
                          child: Text(
                            "Post a Ship",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(AllShipPage(),
                                transition: Transition.leftToRight);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 40.w),
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                               decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5.w, color: Colors.black38))
                          ),
                            //      height: 40.h,
                            child: Text(
                              "My Ships",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                 fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(MyTripsOfferPage(),
                                transition: Transition.leftToRight);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 40.w),
                            //   height: 40.h,
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
   decoration: BoxDecoration(
                             border: Border(bottom: BorderSide(width: 0.5.w, color: Colors.black38))
                          ),
                            child: Text(
                              "My Ship offers",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(AllShipRatingPage(),
                                transition: Transition.leftToRight);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 40.w),
                            padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            //      height: 40.h,
                               decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5.w))
                          ),
                            child: Text(
                              "My Ship Ratings ",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                 fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                     expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                      title: Text(
                        "Task",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15.sp),
                      ),
                      children: [
                        customText(title: "Post a Task",
                        
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(AllTaskPage(),
                                transition: Transition.leftToRight);
                          },
                          child: customText(
                            title: "My Task",
                          ),
                        ),
                        customText(title: "My Task Offers"),
                        
                        InkWell(
                          onTap: () {
                            Get.to(AllTaskRatingPage(),
                                transition: Transition.leftToRight);
                          },
                          child: customText(
                            title: "My Task Ratings",
                          ),
                        )
                      ],
                    ),

                    Container(
                    margin: EdgeInsets.only(left: 18.w, top: 0.h),
                      child: Text(
                        "Referral",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 13.sp),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 18.w, top: 5.h),
                      child: Text(
                        "My Transactions",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 13.sp),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 18.w, top: 5.h),
                      child: Text(
                        "Payment Method",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 13.sp),
                      ),
                    ),
                  
                    ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                      title: Text(
                        "Support",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15.sp),
                      ),
                      children: [
                        customText(title: "Open a Ticket"),
                        customText(
                          title: "My Tickets",
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 18.w, top: 10.h),
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15.sp),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _box.remove(LocalStoreKey.token);
                        Get.offAll(LoginScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 18.w, top: 10.h),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class customText extends StatelessWidget {
  String? title;

  customText({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40.w),
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
         decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 0.5.w))
                          ),
      child: Text(
        "$title",
        style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 15.sp),
      ),
    );
  }
}
