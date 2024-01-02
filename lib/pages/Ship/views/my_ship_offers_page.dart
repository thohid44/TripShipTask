import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/pages/Ship/controller/shipController.dart';
import 'ship_send_package_details.dart';


class MyShipOfferPage extends StatefulWidget {
  const MyShipOfferPage({super.key});

  @override
  State<MyShipOfferPage> createState() => _MyShipOfferPageState();
}

class _MyShipOfferPageState extends State<MyShipOfferPage> {

  var controller = Get.put(ShipController());
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      appBar: customAppBar(),
      body:  Obx(() => controller.isMyOfferLoading.value == false
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.myShipOfferList.length,
                      itemBuilder: (context, index) {
                        var details = controller.myShipOfferList;

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
                                              "${details[index].pickupPoint}",
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
                                              "${details[index].dropoffPoint}",
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
                                              "${details[index].pickupDate} ",
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
                                              "${details[index].pickupDate} ",
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
                                                  "${details[index].amount} ",
                                                    Colors.black,
                                                    FontWeight.normal,
                                                    12.sp),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(ShipSendPackageDetails(
                                                    module:"Ship",
                                                    path: details[index]
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

    ));
  }
}