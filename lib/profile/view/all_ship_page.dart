import 'package:intl/intl.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Home/view/home_screen.dart';
import 'package:tripshiptask/pages/Ship/controller/shipController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/rating/view/ship_giver_feedback_rating.dart';

import '../../pages/Ship/views/ship_send_package_details.dart';

class AllShipPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AllShipPageState();
  }
}

class _AllShipPageState extends State<AllShipPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var controller = Get.put(ShipController());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
    controller.getMyShips();
  }

  static const List<Tab> _tabs = [
    Tab(child: const Text('Send Package')),
    Tab(text: 'Carry Package'),
    Tab(text: 'Completed Shipments'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Get.to(HomeScreen());
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            centerTitle: true,
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              isScrollable: true,
              physics: BouncingScrollPhysics(),
              onTap: (int index) {
                print('Tab $index is tapped');
              },
              enableFeedback: true,
              tabs: _tabs,
            ),
            title: const Text('TripShipTask'),
            backgroundColor: navyBlueColor,
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              Obx(() => controller.isLoading.value == false
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.myShip!.sendPackages!.length,
                      itemBuilder: (context, index) {
                        var details = controller.myShip!.sendPackages;

                        return Card(
                          child: Container(
                            width: 300.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(color: primaryColor),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 285.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Pick Up Point :",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${controller.myShip!.sendPackages![index].startPoint}",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Drop Off Point: ",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${controller.myShip!.sendPackages![index].destination}",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.h),
                                      Row(
                                        children: [
                                          CustomText(
                                              "Pick Up Date: ",
                                              Colors.black,
                                              FontWeight.bold,
                                              12.sp),
                                          CustomText(
                                              "${controller.myShip!.sendPackages![index].pickupDate} ",
                                              Colors.black,
                                              FontWeight.normal,
                                              12.sp),
                                        ],
                                      ),
                                      SizedBox(height: 3.h),
                                      Row(
                                        children: [
                                          CustomText(
                                              "Delivery Up Date: ",
                                              Colors.black,
                                              FontWeight.bold,
                                              12.sp),
                                          CustomText(
                                              "${controller.myShip!.sendPackages![index].deliveryDateTime} ",
                                              Colors.black,
                                              FontWeight.normal,
                                              12.sp),
                                        ],
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CustomText(
                                                    "Offered Amt: ",
                                                    Colors.black,
                                                    FontWeight.bold,
                                                    12.sp),
                                                CustomText(
                                                    "2000 ",
                                                    Colors.black,
                                                    FontWeight.normal,
                                                    12.sp),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(ShipSendPackageDetails(
                                                    path: controller
                                                        .myShip!
                                                        .sendPackages![index]
                                                        .path
                                                        .toString()));
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 25.h,
                                                width: 60.w,
                                                decoration: BoxDecoration(
                                                    color: navyBlueColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r)),
                                                child: CustomText(
                                                    "Details",
                                                    Colors.white,
                                                    FontWeight.bold,
                                                    12.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator())),

              // 2nd TabBar
              Obx(() => controller.isLoading.value == false
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.myShip!.carryPackages!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            width: 300.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(color: primaryColor),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 285.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Pick Up Point :",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${controller.myShip!.carryPackages![index].startPoint}",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Drop Off Point: ",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${controller.myShip!.carryPackages![index].destination}",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.h),
                                      Row(
                                        children: [
                                          CustomText(
                                              "Pick Up Date: ",
                                              Colors.black,
                                              FontWeight.bold,
                                              12.sp),
                                          CustomText(
                                              "${controller.myShip!.carryPackages![index].pickupDate} ",
                                              Colors.black,
                                              FontWeight.normal,
                                              12.sp),
                                        ],
                                      ),
                                      SizedBox(height: 3.h),
                                      Row(
                                        children: [
                                          CustomText(
                                              "Delivery Up Date: ",
                                              Colors.black,
                                              FontWeight.bold,
                                              12.sp),
                                          CustomText(
                                              "${controller.myShip!.carryPackages![index].deliveryDateTime} ",
                                              Colors.black,
                                              FontWeight.normal,
                                              12.sp),
                                        ],
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(ShipSendPackageDetails(
                                                    path: controller
                                                        .myShip!
                                                        .carryPackages![index]
                                                        .path
                                                        .toString()));
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 25.h,
                                                width: 60.w,
                                                decoration: BoxDecoration(
                                                    color: navyBlueColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r)),
                                                child: CustomText(
                                                    "Details",
                                                    Colors.white,
                                                    FontWeight.bold,
                                                    12.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator())),
                  // 3rd Barbar
              Obx(() => controller.isLoading.value == false
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.myShip!.completedShipments!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            width: 300.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(color: primaryColor),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 285.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Pick Up Point :",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${controller.myShip!.completedShipments![index].title}",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Drop Off Point: ",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${controller.myShip!.completedShipments![index].destination}",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.h),
                                      Row(
                                        children: [
                                          CustomText(
                                              "Pick Up Date: ",
                                              Colors.black,
                                              FontWeight.bold,
                                              12.sp),
                                          CustomText(
                                              "${controller.myShip!.completedShipments![index].deliveryDateTime} ",
                                              Colors.black,
                                              FontWeight.normal,
                                              12.sp),
                                        ],
                                      ),
                                      SizedBox(height: 3.h),
                                      Row(
                                        children: [
                                          CustomText(
                                              "Amount: ",
                                              Colors.black,
                                              FontWeight.bold,
                                              12.sp),
                                          CustomText(
                                              "${controller.myShip!.completedShipments![index].amount} ",
                                              Colors.black,
                                              FontWeight.normal,
                                              12.sp),
                                        ],
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(ShipSendPackageDetails(
                                                    path: controller
                                                        .myShip!
                                                        .completedShipments![
                                                            index]
                                                        .path
                                                        .toString(),
                                                        module: "ship",
                                                        ));
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 25.h,
                                                width: 60.w,
                                                decoration: BoxDecoration(
                                                    color: navyBlueColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r)),
                                                child: CustomText(
                                                    "Details",
                                                    Colors.white,
                                                    FontWeight.bold,
                                                    12.sp),
                                              ),
                                            ),

                                              GestureDetector(
                                              onTap: () {
                                                Get.to(ShipGiverFeedBackRating(
                                                    path: controller
                                                        .myShip!
                                                        .completedShipments![
                                                            index]
                                                        .path
                                                        .toString()));
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 25.h,
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                    color: navyBlueColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r)),
                                                child: CustomText(
                                                    "Rating",
                                                    Colors.white,
                                                    FontWeight.bold,
                                                    12.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}
