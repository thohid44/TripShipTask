import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                        margin: EdgeInsets.only(left: 10.w),
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage("assets/Thohid.jpg"),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 110.w,
                              child: CustomText(
                                  "${_box.read(LocalStoreKey.fullName)}",
                                  white,
                                  FontWeight.w500,
                                  13.sp),
                            ),
                            Container(
                              width: 110.w,
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
                          // width: 120.w,
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 5.w, vertical: 3.h),
                          // alignment: Alignment.center,
                          // margin: EdgeInsets.only(right: 5.w),
                          // height: 35.h,
                          // decoration: BoxDecoration(
                          //     color: lightNavyColor,
                          //     borderRadius: BorderRadius.circular(20.r)),
                          // child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     CustomText(
                          //       "BAL (TK): 2000",
                          //       white,
                          //       FontWeight.w600,
                          //       13.sp,
                          //     ),
                          //   ],
                          // ),
                          )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              TripShipTaskBar(),
              SizedBox(
                height: 30.h,
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
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffF1F4F9)
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 4, //spread radius
                                  blurRadius: 4, // blur radius
                                  offset: Offset(
                                      0, 8), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                              ]),
                          child: Image.asset(
                            imgList[index],
                            fit: BoxFit.fill,
                          ));
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
                          decoration: const BoxDecoration(),
                          child: Image.asset(
                            lowerBannerList[index],
                            fit: BoxFit.fitWidth,
                          )),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                height: 80.h,
                color: Colors.amberAccent,
              ),
              SizedBox(
                height: 5.h,
              ),
              // Container(
              //     height: 28.h,

              //     padding: EdgeInsets.only(
              //       left: 20.w,
              //       top: 10.h,
              //       bottom: 0.w
              //     ),
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //         color: primaryColor,
              //         borderRadius: BorderRadius.only(
              //             bottomLeft: Radius.circular(10.r),
              //             bottomRight: Radius.circular(10.r))),
              //     child: CustomText(
              //       "New offers",
              //       skyColor,
              //       FontWeight.bold,
              //       16.sp,
              //     )),
            
              Container(
                padding: EdgeInsets.only(
                  left: 15.w, top: 5.h
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 40.h,
                        width: 40.w,
                        decoration: const BoxDecoration(
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
                padding: EdgeInsets.only(
                  left: 15.w,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: 90.w,
                        decoration: BoxDecoration(),
                        child: Text(
                          "Referral Link",
                          style: TextStyle(fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        height: 40.h,
                        width: 90.w,
                        padding: EdgeInsets.only(top: 12.h),
                        child: Text(
                          "Transactions",
                          style: TextStyle(fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        alignment: Alignment.center,
                        width: 80.w,
                        padding: EdgeInsets.only(top: 0.h),
                        child: Text(
                          "Green Pass",
                          style: TextStyle(fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
               BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            
               
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Payment',
            ),
       
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Support Ticket',
              
            ),
          ],
        ),
      ),
    );
  }

  int _currentIndex = 0;
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
        IconButton(onPressed: (){

        }, icon: Icon(Icons.notifications, color: Colors.grey,)),
        IconButton(
            onPressed: () {
              Get.to(UserDeshBoard());
            },
            icon: Image.asset(
              "assets/menu_bar.jpeg",
              height: 15.h,
              fit: BoxFit.fitHeight,
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
