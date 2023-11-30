import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';

import 'package:tripshiptask/Widget/custom_text_field.dart';

import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_details_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/pages/Trip/views/trip_search_details.dart';

class TripGivePosts extends StatefulWidget {
  @override
  State<TripGivePosts> createState() => _TripGivePostsState();
}

class _TripGivePostsState extends State<TripGivePosts> {
  var controller = Get.put(TripController());

  final _formOfferkey = GlobalKey<FormState>();

  final TextEditingController shortmessage = TextEditingController();

  var amount = '';

  var tripId;

  bool selectPassengerStatus = false;
  List<Map<String, dynamic>> items = [
    {
      "id": 1,
      "name": "1",
    },
    {
      "id": 2,
      "name": "2",
    },
    {
      "id": 3,
      "name": "3",
    },
    {
      "id": 4,
      "name": "4",
    },
  ];
  bool isSelect = false;
  String? seat;
  var seatNumber;

  String? selectPassenger;

  @override
  Widget build(BuildContext context) {
    controller.getTrips();

    return Expanded(
      child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 20.h),
          child: Obx(() => controller.isLoading.value == false
              ? ListView.builder(
                  itemCount: controller.tripSearchList.length,
                  itemBuilder: (context, index) {
                    var tripData = controller.tripSearchList[index];
                    return Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 225.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: CustomText(
                                        "Start Point1: ${tripData.startPoint} $index ${controller.tripSearchList.length}",
                                        Colors.black,
                                        FontWeight.normal,
                                        13.sp),
                                  ),
                                  Container(
                                    child: CustomText(
                                        "Destination: ${tripData.destination}",
                                        Colors.black,
                                        FontWeight.normal,
                                        13.sp),
                                  ),
                                  Container(
                                    child: CustomText(
                                        "Offers: ${tripData.bidsCount} ",
                                        Colors.black,
                                        FontWeight.normal,
                                        13.sp),
                                  ),
                                  Container(
                                    child: CustomText(
                                        "Vehicle:  ${tripData.vehicleType}",
                                        Colors.black,
                                        FontWeight.normal,
                                        13.sp),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: CustomText(
                                        "Passenger: ${tripData.vehicleSeat.toString()}",
                                        Colors.black,
                                        FontWeight.normal,
                                        13.sp),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 90.w,
                              child: Column(
                                children: [
                                  Container(
                                    child: CustomText(
                                        "Amount \$${tripData.pay.toString()}",
                                        Colors.black,
                                        FontWeight.normal,
                                        13.sp),
                                  ),
                                  SizedBox(
                                    height: 35.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.getTripPostDetails(
                                          tripData.path.toString());

                                      controller.path1.value =
                                          tripData.path.toString();
                                      Get.to(
                                          TripDetailsPage(
                                            tripData.path.toString(),
                                          ),
                                          duration: Duration(
                                              milliseconds:
                                                  200), //duration of transitions, default 1 sec
                                          transition: Transition.leftToRight);
                                    },
                                    child: Container(
                                      child: CustomText("Details", Colors.black,
                                          FontWeight.normal, 13.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                title:
                                                    Text("Make Counter Offer"),
                                                content: Container(
                                                    height: 300.h,
                                                    decoration: BoxDecoration(),
                                                    child: Form(
                                                      key: _formOfferkey,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20.w),
                                                            child:
                                                                CustomTextField(
                                                              onChange:
                                                                  (amount) {
                                                                amount = amount;
                                                              },
                                                              txt: "Amount",
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                          Container(
                                                              width: 300.w,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              height: 45,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .lightBlue),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: DropdownButton(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                                  isExpanded: true,
                                                                  hint: Text(
                                                                    "${isSelect ? seatNumber : 'How many of you?'}",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            13.sp),
                                                                  ),
                                                                  underline: SizedBox(),
                                                                  icon: const Icon(Icons.keyboard_arrow_down),
                                                                  value: seat,
                                                                  items: items
                                                                      .map((e) => DropdownMenuItem(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                seatNumber = e['name'].toString();
                                                                              });
                                                                            },
                                                                            value:
                                                                                e['id'],
                                                                            child:
                                                                                Text(
                                                                              "${e['name']}",
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                  onChanged: (value) {
                                                                    seatNumber =
                                                                        value;
                                                                    print(
                                                                        seatNumber);
                                                                    isSelect =
                                                                        true;
                                                                  })),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20.w),
                                                            child: TextField(
                                                              controller:
                                                                  shortmessage,
                                                              maxLines: 3,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "short message (Optional)",
                                                                  border:
                                                                      OutlineInputBorder()),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20.h,
                                                          ),
                                                          Row(
                                                            children: [
                                                              CustomButtonOne(
                                                                  height: 30.h,
                                                                  width: 100.w,
                                                                  radius: 5.r,
                                                                  marginLR:
                                                                      10.w,
                                                                  title:
                                                                      "Cancle",
                                                                  btnColor:
                                                                      Colors
                                                                          .red,
                                                                  onTab: () {
                                                                    Get.back();
                                                                  }),
                                                              CustomButtonOne(
                                                                  width: 100.w,
                                                                  height: 30.h,
                                                                  radius: 5.r,
                                                                  marginLR: 0.w,
                                                                  title:
                                                                      "Submit",
                                                                  btnColor:
                                                                      navyBlueColor,
                                                                  onTab: () {
                                                                    print(tripData
                                                                        .pay
                                                                        .toString());
                                                                    print(
                                                                        amount);
                                                                    print(
                                                                        seatNumber);
                                                                    print(shortmessage
                                                                        .text
                                                                        .toString());
                                                                    var _isValid =
                                                                        _formOfferkey
                                                                            .currentState!
                                                                            .validate();
                                                                    if (_isValid) {
                                                                      controller.bidOnTrip(
                                                                          amount:
                                                                              amount,
                                                                          tripId:
                                                                              "63",
                                                                          seat:
                                                                              seatNumber,
                                                                          message: shortmessage
                                                                              .text
                                                                              .toString());
                                                                    } else {
                                                                      Get.snackbar(
                                                                          "",
                                                                          "Offer not submitted");
                                                                    }
                                                                  })
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ))),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w,
                                          right: 10.w,
                                          top: 5.h,
                                          bottom: 5.h),
                                      decoration: BoxDecoration(
                                          color: navyBlueColor,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: CustomText(
                                          "Make offer",
                                          Colors.white,
                                          FontWeight.normal,
                                          12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Center(child: CircularProgressIndicator()))),
    );
  }
}
