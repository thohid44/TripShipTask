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

  List imgList = [
    'assets/1.jpeg',
    'assets/2.png',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.png',
    'assets/6.png',
  ];
  List lowerBannerList = [
    'assets/lowerBanner/lb1.jpg',
    'assets/lowerBanner/lb2.jpg',
    'assets/lowerBanner/lb3.png',
    'assets/lowerBanner/lb4.png',
    'assets/lowerBanner/lb5.png',
    'assets/lowerBanner/lb6.png',
  ];
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
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
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
                    height: 25.h,
                  ),
                  TripShipTaskBar(),
                  SizedBox(
                    height: 25.h,
                  ),
                  Container(
                    height: 100.h,
                
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imgList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                         
                            height: 80.h,
                            width: 250.w,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10.r),
                              
                            ),
                            child: Image.asset(imgList[index], 
                            fit: BoxFit.fill,
                            )
                            
                          );
                        }),
                  ),
                 
                  Container(
                    height: 125.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lowerBannerList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: Container(
                            width: 200.w,
                              decoration:
                                  const BoxDecoration(
                           
                                  ),
                              child: Image.asset(
                                lowerBannerList[index],           
                                fit: BoxFit.fitWidth,
                              )),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 80.h,
                    color: Colors.amberAccent,
                  ),
                  SizedBox(
                    height: 5.h,
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
                    padding: EdgeInsets.only(
                      left: 15.w,
                    ),
                    decoration: BoxDecoration(  color: primaryColor,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 40.h,
                            width: 40.w,
                            decoration:const BoxDecoration(
                                color: navyBlueColor, shape: BoxShape.circle),
                            child: Image.asset("assets/account_bonus.jpeg")),
                        Container(
                            alignment: Alignment.center,
                             height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                color: navyBlueColor, shape: BoxShape.circle),
                            child: Image.asset("assets/rafferal_bonus.jpeg")),
                        Container(
                            alignment: Alignment.center,
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                color: navyBlueColor, shape: BoxShape.circle),
                            child: Image.asset("assets/user_bonus.jpeg")),
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.only(
                      left: 15.w,
                    ),
                    decoration: BoxDecoration(  color: primaryColor,),
                   
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            alignment: Alignment.center,
                           
                            width: 80.w,
                            decoration: BoxDecoration(),
                            child: Text(
                              "New Account Bonus", style: TextStyle(
                                fontSize: 12.sp
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Container(
                           
                            height: 40.h,
                            width: 90.w,
                             padding: EdgeInsets.only(top: 8.h),
                          
                            child: Text(
                              "Referral Bonus",style: TextStyle(
                                fontSize: 12.sp
                              ),
                              textAlign: TextAlign.center,
                            )),
                        Container(
                            alignment: Alignment.center,
                       
                            width: 80.w,
                               padding: EdgeInsets.only(top: 3.h),
                            child: Text(
                              "Frequent User Bonus",style: TextStyle(
                                fontSize: 12.sp
                              ),
                              textAlign: TextAlign.center,
                            )),
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
            onPressed: () {
              Get.to(UserDeshBoard());
            },
            icon: Image.asset("assets/menu_bar.jpeg", height: 15.h, fit: BoxFit.fitHeight,)),
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
