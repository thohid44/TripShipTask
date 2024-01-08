import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/app_bar_widget_1.dart';
import 'package:tripshiptask/Widget/customText.dart';

import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/views/trip_post_details_page.dart';
import 'package:tripshiptask/rating/view/trip_giver_feedback_rating.dart';

class AllTripView extends StatefulWidget {
  const AllTripView({super.key});

  @override
  State<AllTripView> createState() => _AllTripViewState();
}

class _AllTripViewState extends State<AllTripView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: index == 0 ? tealColor : Colors.grey,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      child: CustomText("Posted a Trip", Colors.white,
                          FontWeight.w500, 11.sp)),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: index == 1 ? tealColor : Colors.grey,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      child: CustomText(
                          "Seek a Trip", Colors.white, FontWeight.w500, 11.sp)),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: index == 2 ? tealColor : Colors.grey,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      child: CustomText("Completed Trip", Colors.white,
                          FontWeight.w500, 11.sp)),
                )
              ],
            ),
          ),
          Container(
            height: 500.h,
            child: tripList[index],
          )
        ],
      ),
    );
  }

  List<Widget> tripList = [PostedAllTrip(), SeekAllTrip(), CompletedAllTrip()];
}

class PostedAllTrip extends StatelessWidget {
  var controller = Get.put(TripController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isAllLoading.value == false
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.myTrips!.postedTrips!.length,
            itemBuilder: (context, index) {
              var tripData = controller.myTrips!.postedTrips![index];

              return Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
                          CustomText("M/30/Masters/PrivateJob ", Colors.black,
                              FontWeight.normal, 12.sp),
                        ],
                      ),
                      Row(
                        children: [
                          CustomText("Vehicle: ", Colors.black, FontWeight.bold,
                              12.sp),
                          CustomText("${tripData.vehicleType}", Colors.black,
                              FontWeight.normal, 12.sp),
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomText("Passenger: ", Colors.black,
                                    FontWeight.bold, 12.sp),
                                CustomText("${tripData.vehicleSeat.toString()}",
                                    Colors.black, FontWeight.normal, 12.sp),
                              ],
                            ),
                            //     Row(
                            //   children: [
                            //     CustomText("Offered Amt: ${tripData.pay.toString()} ", Colors.black,
                            //         FontWeight.bold, 12.sp),
                            //     CustomText("",
                            //         Colors.black, FontWeight.normal, 12.sp),
                            //   ],
                            // ),

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
                                    borderRadius: BorderRadius.circular(5.r)),
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
        : Center(
            child: CircularProgressIndicator(),
          ));
  }
}

class SeekAllTrip extends StatelessWidget {
  var controller = Get.put(TripController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isAllLoading.value == false
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.myTrips!.seekedTrips!.length,
            itemBuilder: (context, index) {
              var tripData = controller.myTrips!.seekedTrips![index];

              return Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
                          CustomText("M/30/Masters/PrivateJob ", Colors.black,
                              FontWeight.normal, 12.sp),
                        ],
                      ),
                      Row(
                        children: [
                          CustomText("Vehicle: ", Colors.black, FontWeight.bold,
                              12.sp),
                          CustomText("${tripData.vehicleType}", Colors.black,
                              FontWeight.normal, 12.sp),
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomText("Passenger: ", Colors.black,
                                    FontWeight.bold, 12.sp),
                                CustomText("${tripData.vehicleSeat.toString()}",
                                    Colors.black, FontWeight.normal, 12.sp),
                              ],
                            ),
                            //     Row(
                            //   children: [
                            //     CustomText("Offered Amt: ${tripData.pay.toString()} ", Colors.black,
                            //         FontWeight.bold, 12.sp),
                            //     CustomText("",
                            //         Colors.black, FontWeight.normal, 12.sp),
                            //   ],
                            // ),

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
                                    borderRadius: BorderRadius.circular(5.r)),
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
        : Center(child: CircularProgressIndicator()));
  }
}

class CompletedAllTrip extends StatelessWidget {
  var controller = Get.put(TripController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isAllLoading.value == false
        ? ListView.builder(
            itemCount: controller.myTrips!.completedTrips!.length,
            itemBuilder: (context, index) {
              var tripData = controller.myTrips!.completedTrips![index];
              return Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
                          CustomText("M/30/Masters/PrivateJob ", Colors.black,
                              FontWeight.normal, 12.sp),
                        ],
                      ),
                      Row(
                        children: [
                          CustomText("Vehicle: ", Colors.black, FontWeight.bold,
                              12.sp),
                          CustomText("${tripData.vehicleType}", Colors.black,
                              FontWeight.normal, 12.sp),
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomText("Passenger: ", Colors.black,
                                    FontWeight.bold, 12.sp),
                                CustomText("${tripData.vehicleSeat.toString()}",
                                    Colors.black, FontWeight.normal, 12.sp),
                              ],
                            ),
                            //     Row(
                            //   children: [
                            //     CustomText("Offered Amt: ${tripData.pay.toString()} ", Colors.black,
                            //         FontWeight.bold, 12.sp),
                            //     CustomText("",
                            //         Colors.black, FontWeight.normal, 12.sp),
                            //   ],
                            // ),

                            GestureDetector(
                              onTap: () {
                                controller.getTripPostDetails(
                                    tripData.path.toString());

                                controller.path1.value =
                                    tripData.path.toString();
                                Get.to(
                                    TripGiverFeedBackRating(
                                      path: tripData.path.toString(),
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
                                    borderRadius: BorderRadius.circular(5.r)),
                                child: CustomText("Review", Colors.white,
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
        : Center(
            child: CircularProgressIndicator(),
          ));
  }
}
