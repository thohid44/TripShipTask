import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tripshiptask/Widget/customText.dart';

import 'package:tripshiptask/pages/Ship/views/carry_a_package.dart';
import 'package:tripshiptask/pages/Ship/views/send_a_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/pages/Ship/views/shipDetails/ship_send_package_details.dart';
import 'package:tripshiptask/pages/Ship/views/ship_carry_package_post_list.dart';
import 'package:tripshiptask/pages/Trip/views/trip_search/trip_single_search.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';
import 'ship_send_package_post_list_page.dart';

class ShipHomePage extends StatefulWidget {
  ShipHomePage({super.key});

  @override
  State<ShipHomePage> createState() => _ShipHomePageState();
}

class _ShipHomePageState extends State<ShipHomePage> {
  final TextEditingController search = TextEditingController();
    var fullWidth=306.w;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                          index = 1;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                     width: 152.w,
                      height: 25.h,
                        decoration: BoxDecoration(
                            color: index == 1 ? Color(0xff4CA4C7) : Colors.grey,
                            //E6E7E8
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Text(
                          "Send a Package",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    
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
                             borderRadius: BorderRadius.circular(5.r)),
                        child: Text(
                          "Carry a Package",
                          style: TextStyle(
                            fontSize: 11.sp,
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
              height: 5.h,
            ),
            Container(
              width: fullWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Container(
                        width: 99.w,
                        height: 28.h,
                        child: TextField(
                          onTap: () {
                            Get.to(TripSingleSearchPage());
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5.w, top: 5.h),
                            hintText: "Search",
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                          ),
                        )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 3;
                      });
                    },
                    child: Container(
                       alignment: Alignment.center,
                      height: 28.h,
                      width: 99.w,
                     
                      decoration: BoxDecoration(
                          color: index == 3 ? Color(0xff4CA4C7) : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: CustomText("Carry Package Posts", Colors.white,
                              FontWeight.w700, 10.sp)
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 28.h,
                      width: 99.w,
                    
                      decoration: BoxDecoration(
                          color: index == 0 ? Color(0xff4CA4C7) : Colors.grey,
                          borderRadius: BorderRadius.circular(5.r)),
                      child:   CustomText("Send Package Posts", Colors.white,
                              FontWeight.w700, 10.sp)
                    ),
                  )
                ],
              ),
            ),
            Container(height: 550.h, child: widgetList[index])
          ],
        ),
      ),
    );
  }

  int index = 0;

  List<Widget> widgetList = [
    ShipsendPackagePostList(),
    SendAPackage(),
    CarryAPackage(),
    ShipCarryPackagePostList(),
  ];
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
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hinttext ?? "Enter Data",
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14.sp),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 0.0.r)),
      ),
    );
  }

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
        child: Container(
          height: 100.w,
          width: double.infinity,
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!);
  }
}

class ShipPostItemWidget extends StatelessWidget {
  String? startPoint;
  String? destination;
  dynamic amount;
  var shipData;

  String? weight;
  var pickUpDate;
  var dropUpDate;

  ShipPostItemWidget(
      {this.startPoint,
      this.destination,
      this.amount,
      this.weight,
      this.pickUpDate,
      this.dropUpDate,
      this.shipData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 180.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CustomText("Pick Up Point: $startPoint", Colors.black,
                      FontWeight.w500, 13.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: CustomText("Drop Off Point: $destination",
                      Colors.black, FontWeight.w500, 13.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: CustomText(
                      "Weight: $weight", Colors.black, FontWeight.w500, 13.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: CustomText(
                      "Pick Up Date: ${DateFormat.yMMMd().format(pickUpDate)} ",
                      Colors.black,
                      FontWeight.w500,
                      13.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: dropUpDate != null
                      ? CustomText(
                          "Delivery Date : ${DateFormat.yMMMd().format(dropUpDate)} ",
                          Colors.black,
                          FontWeight.w500,
                          13.sp)
                      : Container(),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              customText(
                title: "Amount: $amount",
              ),
              InkWell(
                onTap: () {
                  Get.to(ShipSendPackageDetails(), arguments: shipData);
                },
                child: Text(
                  "Details",
                  style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

