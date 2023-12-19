import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/custom_text_field.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';

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
  void initState() {
    controller.getTrips(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.getTrips();

    return Expanded(
      child: Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Obx(() => controller.isLoading.value == false
              ? ListView.builder(
                  itemCount: controller.tripSearchList.length,
                  itemBuilder: (context, index) {
                    var tripData = controller.tripSearchList[index];
                    return Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  "Start: ",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                Expanded(
                                  child: Text(
                                    "${tripData.startPoint}",
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  "Destination: ",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                Expanded(
                                  child: Text(
                                    "${tripData.destination}",
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
                            Row(
                              children: [
                                CustomText("Offered by : ", Colors.black,
                                    FontWeight.bold, 12.sp),
                                CustomText("M/30/Masters/PrivateJob ",
                                    Colors.black, FontWeight.normal, 12.sp),
                              ],
                            ),
                            Row(
                              children: [
                                CustomText("Vehicle: ", Colors.black,
                                    FontWeight.bold, 12.sp),
                                CustomText("${tripData.vehicleType}",
                                    Colors.black, FontWeight.normal, 12.sp),
                              ],
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomText("Passenger: ", Colors.black,
                                          FontWeight.bold, 12.sp),
                                      CustomText(
                                          "${tripData.vehicleSeat.toString()}",
                                          Colors.black,
                                          FontWeight.normal,
                                          12.sp),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                          "Offered Amt: ${tripData.pay.toString()} ",
                                          Colors.black,
                                          FontWeight.bold,
                                          12.sp),
                                      CustomText("", Colors.black,
                                          FontWeight.normal, 12.sp),
                                    ],
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
                                      alignment: Alignment.center,
                                      height: 25.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          color: navyBlueColor,
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
                                      child: CustomText("Details", Colors.white,
                                          FontWeight.bold, 12.sp),
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
              : Center(child: CircularProgressIndicator()))),
    );
  }
}
