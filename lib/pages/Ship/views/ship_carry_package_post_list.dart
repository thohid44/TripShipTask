import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Ship/controller/shipController.dart';
import 'package:tripshiptask/pages/Ship/views/ship_send_package_details.dart';

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
                shipData = controller.shipCarryPostList;
                return Card(
                  child: Container(
                    width: 300.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(color: primaryColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 285.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "${shipData[index].startPoint}",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "${shipData[index].destination}",
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
                                  CustomText("Pick Up Date: ", Colors.black,
                                      FontWeight.bold, 12.sp),
                                  CustomText(
                                      "${DateFormat.yMMMd().format(DateTime.parse(shipData[index].pickupDate))}",
                                      Colors.black,
                                      FontWeight.normal,
                                      12.sp),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                //     DateFormat.yMMMd().format())
                                children: [
                                  CustomText("Delivery Up Date: ", Colors.black,
                                      FontWeight.bold, 12.sp),
                                  CustomText(
                                      "${DateFormat.yMMMd().format(DateTime.parse(shipData[index].deliveryDate))}",
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
                                        CustomText("2000 ", Colors.black,
                                            FontWeight.normal, 12.sp),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(ShipSendPackageDetails(
                                            path: shipData[index]
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
                                                BorderRadius.circular(5.r)),
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
    );
  }
}
