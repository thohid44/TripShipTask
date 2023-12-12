import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/Controller/trip_rating.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_details_page.dart';
import 'package:tripshiptask/pages/Trip/views/trip_rating_test.dart';
import 'package:tripshiptask/profile/view/my_posted_trip_details.dart';

class AllTripsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AllTripsPageState();
  }
}

class _AllTripsPageState extends State<AllTripsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var controller = Get.put(TripController());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
    controller.getMyTrips();
  }

  static const List<Tab> _tabs = [
    const Tab(child: const Text('Posted Trip')),
    const Tab(text: 'Seek Trip'),
    const Tab(text: 'Completed Trip'),
  ];

var ratingContr = Get.put(TripRatingController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
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
              // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
              // controller: _tabController,
              tabs: _tabs,
            ),
            title: const Text('TripShipTask',style: TextStyle(color: Colors.white),),
            backgroundColor: navyBlueColor,
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
            //     controller: _tabController,
            children: [
          Obx(() => controller.isAllLoading.value ==false? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.myTrips!.postedTrips!.length,
                          itemBuilder: (context, index) {
                            var tripData =
                               controller.myTrips!.postedTrips![index];

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        CustomText(
                                            "Offered by : ",
                                            Colors.black,
                                            FontWeight.bold,
                                            12.sp),
                                        CustomText(
                                            "M/30/Masters/PrivateJob ",
                                            Colors.black,
                                            FontWeight.normal,
                                            12.sp),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText("Vehicle: ", Colors.black,
                                            FontWeight.bold, 12.sp),
                                        CustomText(
                                            "${tripData.vehicleType}",
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
                                                  "Passenger: ",
                                                  Colors.black,
                                                  FontWeight.bold,
                                                  12.sp),
                                              CustomText(
                                                  "${tripData.vehicleSeat.toString()}",
                                                  Colors.black,
                                                  FontWeight.normal,
                                                  12.sp),
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
                                                  transition:
                                                      Transition.leftToRight);
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
                            );
                          }) :Center(child: CircularProgressIndicator(),)),

              Obx(() => controller.isAllLoading.value==false? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.myTrips!.seekedTrips!.length,
                          itemBuilder: (context, index) {
                            var tripData =
                                 controller.myTrips!.seekedTrips![index];

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        CustomText(
                                            "Offered by : ",
                                            Colors.black,
                                            FontWeight.bold,
                                            12.sp),
                                        CustomText(
                                            "M/30/Masters/PrivateJob ",
                                            Colors.black,
                                            FontWeight.normal,
                                            12.sp),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText("Vehicle: ", Colors.black,
                                            FontWeight.bold, 12.sp),
                                        CustomText(
                                            "${tripData.vehicleType}",
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
                                                  "Passenger: ",
                                                  Colors.black,
                                                  FontWeight.bold,
                                                  12.sp),
                                              CustomText(
                                                  "${tripData.vehicleSeat.toString()}",
                                                  Colors.black,
                                                  FontWeight.normal,
                                                  12.sp),
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
                                                  transition:
                                                      Transition.leftToRight);
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
                            );
                          }) :Center(child:CircularProgressIndicator())),
             
          Obx(() => controller.isAllLoading.value ==false?  ListView.builder(
                          itemCount: controller.myTrips!.completedTrips!.length,
                          itemBuilder: (context, index) {
                            var tripData =
                                controller.myTrips!.completedTrips![index];
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        CustomText(
                                            "Offered by : ",
                                            Colors.black,
                                            FontWeight.bold,
                                            12.sp),
                                        CustomText(
                                            "M/30/Masters/PrivateJob ",
                                            Colors.black,
                                            FontWeight.normal,
                                            12.sp),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText("Vehicle: ", Colors.black,
                                            FontWeight.bold, 12.sp),
                                        CustomText(
                                            "${tripData.vehicleType}",
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
                                                  "Passenger: ",
                                                  Colors.black,
                                                  FontWeight.bold,
                                                  12.sp),
                                              CustomText(
                                                  "${tripData.vehicleSeat.toString()}",
                                                  Colors.black,
                                                  FontWeight.normal,
                                                  12.sp),
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
                                                  TripRatingTestPage(
                                                    tripData.path.toString(),

                                                  ),
                                                  duration: Duration(
                                                      milliseconds:
                                                          200), //duration of transitions, default 1 sec
                                                  transition:
                                                      Transition.leftToRight);
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
                                                  "Review",
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
                            );
                          }):Center(child: CircularProgressIndicator(),))
            ],
          ),
        ),
      ),
    );
  }
}
