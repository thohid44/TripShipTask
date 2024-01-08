import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Refferal/views/my_referrels_view.dart';
import 'package:tripshiptask/Transaction/controller/transaction_controller.dart';
import 'package:tripshiptask/Transaction/view/my_transaction_page.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/pages/Home/view/faq_page.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tripshiptask/support_Ticket/view/my_tickets_page.dart';
import 'package:tripshiptask/support_Ticket/view/trip_support_ticket.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _box = GetStorage();

  List imgList = [
    'assets/1.PNG',
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
              AccountAppBar(box: _box),
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
                          height: 100.h,
                          width: 220.w,
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
                                      0, 5), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                              ],
                              
                              ),
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
                          decoration:  BoxDecoration(
                                 boxShadow: [
                                BoxShadow(
                                  color: Color(0xffF1F4F9)
                                      .withOpacity(0.3), //color of shadow
                                  spreadRadius: 4, //spread radius
                                  blurRadius: 4, // blur radius
                                  offset: Offset(
                                      0, 8), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                              ],
                          ),
                          child: Image.asset(
                            lowerBannerList[index],
                            fit: BoxFit.fitWidth,
                          )),
                    );
                  },
                ),
              ),

              // Container(
              //   height: 125.h,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: lowerBannerList.length,
              //     itemBuilder: (context, index) {
              //       return   Container(
              //             margin: EdgeInsets.all( 4),
              //             width: 200.w,
                        
              //             decoration: const BoxDecoration(),
              //             child: Image.asset(
              //               lowerBannerList[index],
              //               fit: BoxFit.fitWidth,
              //             ),
              //       );
              //     },
              //   ),
              // ),
              SizedBox(
                height: 2.h,
              ),
             Material(
      elevation: 8,
      color: primaryColor,
      shadowColor: primaryColor,
      borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 81.h,
                            
                    
                            decoration:  BoxDecoration(
                                  color: Colors.amberAccent,
                                //    boxShadow: [
                                //   BoxShadow(
                                //     color: Color(0xffF1F4F9)
                                //         .withOpacity(0.3), //color of shadow
                                //     spreadRadius: 4, //spread radius
                                //     blurRadius: 4, // blur radius
                                //     offset: Offset(
                                //         5, 8), // changes position of shadow
                                //     //first paramerter of offset is left-right
                                //     //second parameter is top to down
                                //   ),
                                // ],
                            ),
                ),
              ),
              SizedBox(
                height: 3.h,
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
                padding: EdgeInsets.only(left: 15.w, top: 13.h),
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(MyReferrelsPage());
                      },
                      child: Container(
                             alignment: Alignment.centerLeft,
                          height: 30.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                              ),
                          child: Image.asset("assets/link.png")),
                    ),
                    Container(
                         alignment: Alignment.centerLeft,
                        height: 30.h,
                        width: 40.w,
                        decoration: const BoxDecoration(
                          ),
                        child: Image.asset("assets/transaction.png")),
                    InkWell(
                        onTap: () {
                        Get.to(FAQPage()); 
                      },
                      child: Container(
                       alignment: Alignment.center,
                          height: 30.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                            ),
                          child: Image.asset("assets/faq.png")),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30.h,
                padding: EdgeInsets.only(
                  left: 15.w,
                ),
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(MyReferrelsPage());
                      },
                      child: Container(
                          alignment: Alignment.centerLeft,
                          width: 90.w,
                          decoration: const BoxDecoration(),
                          child: Text(
                            "Referral Link",
                            style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Container(
                        height: 40.h,
                        width: 90.w,
                       
                        padding: EdgeInsets.only(top: 6.h,),
                        child: Text(
                          "Transactions",
                          style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                          textAlign: TextAlign.center,
                        )),
                    InkWell(
                      onTap: () {
                        Get.to(FAQPage()); 
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 90.w,
                          padding: EdgeInsets.only(top: 0.h),
                          child: Text(
                            "FAQ",
                              style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: Colors.black),
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              gotPage(index);
            });
          },
          items:  [
            BottomNavigationBarItem(
              icon:  Image.asset("assets/home.png", width: 30.w, height: 25.h,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/report.png", width: 30.w, height: 25.h,),
              label: 'Reports',
              
            ),
            BottomNavigationBarItem(
              icon:Image.asset("assets/support.png", width: 30.w, height: 25.h,),
              label: 'Support Ticket',
              
            ),
          ],
        ),
      ),
    );
  }

  gotPage(index) {
    if (index == 2) {
      Get.to(MyTicketsPage());
    }
    if (index == 1) {
      Get.to(MyTransactionPage());
    }
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
        style: GoogleFonts.inter(color: Colors.black, 
        letterSpacing: 1,
        
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Colors.amber,
            )),
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

class AccountAppBar extends StatelessWidget {
  const AccountAppBar({
    super.key,
    required GetStorage box,
  }) : _box = box;

  final GetStorage _box;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff272e48),
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
              padding: EdgeInsets.all(5.h),
              child: CircleAvatar(
                backgroundColor: Colors.white,
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
                width: 120.w,
                padding: EdgeInsets.symmetric(
                    horizontal: 5.w, vertical: 3.h),
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 5.w),
                height: 35.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Icon(Icons.verified, color: Colors.green,),
                    CustomText(
                      "id Verified",
                      Colors.green,
                      FontWeight.bold,
                      13.sp,
                    ),
                  ],
                ),
                )
          ],
        ),
      ),
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
             color: Color(0xff272e48),  borderRadius: BorderRadius.circular(15.r)),
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
                  color: Color(0xff272e48), borderRadius: BorderRadius.circular(15.r)),
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
           color: Color(0xff272e48),  borderRadius: BorderRadius.circular(15.r)),
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
