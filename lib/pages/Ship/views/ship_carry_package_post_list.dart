import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Ship/controller/shipController.dart';
import 'package:tripshiptask/pages/Ship/views/shipDetails/ship_send_package_details.dart';

class ShipCarryPackagePostList extends StatelessWidget {
  var controller = Get.put(ShipController());
  var shipData;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() => controller.isShipCarryLoading.value == false
          ? ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.shipCarryPostList.length,
              itemBuilder: (context, index) {
                shipData = controller.shipCarryPostList[index];
                return Card(
                  child: Container(
                    width: 320.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 210.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: CustomText(
                                    "Pick Up Point: ${controller.shipSearchList[index].startPoint}",
                                    Colors.black,
                                    FontWeight.normal,
                                    12.sp),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                child: CustomText(
                                    "Drop Off Point: ${controller.shipSearchList[index].destination}",
                                    Colors.black,
                                    FontWeight.normal,
                                    13.sp),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //  Container(
                              //       child: CustomText(
                              //           "Amount: ${controller.shipSearchList[index].documents}", Colors.black, FontWeight.normal, 13.sp),
                              //     ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(ShipSendPackageDetails(
                                      path: controller
                                          .shipSearchList[index].path
                                          .toString()));
                                },
                                child: Text(
                                  "Details $index ${controller.shipSearchList.length}",
                                  style: TextStyle(
                                      color: Colors.blue[800],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 7.h),
                                decoration: BoxDecoration(color: navyBlueColor),
                                child: Text(
                                  "Make Offer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
          : Center(child: CircularProgressIndicator())),
    );
  }
}
