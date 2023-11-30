import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 70.h,
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: navyBlueColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        )),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 70.w,
                              child: Icon(
                                Icons.person,
                                size: 60.h,
                                color: white,
                              )),
                          GestureDetector(
                            onTap: () {
                              Get.to(UserDeshBoard());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 130.w,
                                  child: CustomText(
                                      "${_box.read(LocalStoreKey.fullName)}",
                                      white,
                                      FontWeight.w500,
                                      13.sp),
                                ),
                                Container(
                                  width: 130.w,
                                  child: CustomText(
                                      "Acct: ${_box.read(LocalStoreKey.accountNo)}",
                                      white,
                                      FontWeight.w500,
                                      13.sp),
                                )
                              ],
                            ),
                          ),
                          Container(
                              width: 130.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 3.h),
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 15.w),
                              height: 35.h,
                              decoration: BoxDecoration(
                                  color: lightNavyColor,
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomText(
                                    "Balance : 2000TK",
                                    white,
                                    FontWeight.w600,
                                    13.sp,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  TripShipTaskBar(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 100.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                            height: 80.h,
                            width: 250.w,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  child: Image.asset(
                                    "assets/man.png",
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  width: 175.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: CustomText(
                                            "Check Shipping Content",
                                            Colors.black,
                                            FontWeight.w500,
                                            12.sp),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Always check & carry",
                                            Colors.black,
                                            FontWeight.w300,
                                            13.sp),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        child: CustomText(
                                            "open items and legal items",
                                            Colors.black,
                                            FontWeight.w300,
                                            13.sp),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Avoid risks & stay safe",
                                            Colors.black,
                                            FontWeight.w300,
                                            12.sp),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 140.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: Container(
                            width: 290.w,
                            padding: EdgeInsets.all(8.w),
                            decoration: const BoxDecoration(),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 150.w,
                                        padding: EdgeInsets.only(
                                            left: 7.w,
                                            right: 7.w,
                                            top: 7.h,
                                            bottom: 7.h),
                                        decoration: BoxDecoration(
                                            color: navyBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Text(
                                          "Want to give a ride & make money?",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: white),
                                        ),
                                      ),
                                      Container(
                                          width: 80.w,
                                          height: 45.h,
                                          child: Image.asset(
                                            "assets/trip.png",
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 200.w,
                                          height: 60.h,
                                          child: Text(
                                            "Post your destination & choose passengers who are headed the same direction",
                                            style: TextStyle(fontSize: 11.sp),
                                          ),
                                        ),
                                        Container(
                                            height: 50.h,
                                            child: Image.asset(
                                                "assets/mobile.jpg"))
                                      ],
                                    ),
                                    Positioned(
                                        bottom: 10.h,
                                        child: Container(
                                          child: Text(
                                            "Give a ride and make money.",
                                            style: TextStyle(fontSize: 11.sp),
                                          ),
                                        )),
                                    Positioned(
                                        right: 15.w,
                                        bottom: 0.h,
                                        child: Container(
                                            height: 35.h,
                                            child:
                                                Image.asset("assets/car.png"))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 80.h,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      height: 35.h,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.only(
                        left: 30.w,
                        top: 5.h,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r))),
                      child: CustomText(
                        "New offers",
                        skyColor,
                        FontWeight.bold,
                        20.sp,
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(color: primaryColor),
                    child: Text(
                      "- - - - - - - - - - - - - - - - - - - - - - -",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.only(left: 15.w, bottom: 15.h),
                    decoration: BoxDecoration(color: primaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 100.w,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 45.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                    color: navyBlueColor,
                                    shape: BoxShape.circle),
                                child: FaIcon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                  child: Text(
                                "New Account Bonus",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ))
                            ],
                          ),
                        ),
                        Container(
                          width: 100.w,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 45.h,
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: navyBlueColor,
                                    shape: BoxShape.circle),
                                child: const FaIcon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                  child: Text(
                                "Rafferal Bonus",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ))
                            ],
                          ),
                        ),
                        Container(
                          width: 100.w,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 45.h,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: navyBlueColor,
                                    shape: BoxShape.circle),
                                child: FaIcon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                  child: Text(
                                "Frequent User Bonus",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  AppBar customAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          )),
      centerTitle: true,
      title: Text(
        "TripShipTask",
        style: TextStyle(color: Colors.black),
      ),
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
}

class TripShipTaskBar extends StatelessWidget {
  const TripShipTaskBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          height: 30.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: tealColor, borderRadius: BorderRadius.circular(15.r)),
          child: InkWell(
              onTap: () {
                Get.to(
                    TripShipTaskHome(
                      trip: true,
                    ),
                    transition: Transition.leftToRight,
                    duration: Duration(milliseconds: 300));
              },
              child: CustomText("Trip", Colors.white, FontWeight.w600, 17.sp)),
        ),
        Container(
          alignment: Alignment.center,
          height: 30.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: tealColor, borderRadius: BorderRadius.circular(15.r)),
          child: InkWell(
              onTap: () {
                Get.to(TripShipTaskHome(ship: true),
                    transition: Transition.leftToRight,
                    duration: Duration(milliseconds: 300));
              },
              child: CustomText("Ship", Colors.white, FontWeight.w600, 17.sp)),
        ),
        Container(
          alignment: Alignment.center,
          height: 30.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: tealColor, borderRadius: BorderRadius.circular(15.r)),
          child: InkWell(
              onTap: () {
                Get.to(TripShipTaskHome(task: true),
                    transition: Transition.leftToRight,
                    duration: Duration(milliseconds: 300));
              },
              child: CustomText("Task", Colors.white, FontWeight.w600, 17.sp)),
        )
      ],
    );
  }
}
