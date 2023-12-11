import 'package:intl/intl.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Task/controller/task_controller.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AllTaskPageState();
  }
}

class _AllTaskPageState extends State<AllTaskPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
    controller.getMyTask();
  }

  static const List<Tab> _tabs = [
    Tab(child: const Text('Offer a Task')),
    Tab(text: 'Want a Task'),
    Tab(text: 'Completed Task'),
  ];
  var controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
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
                      itemCount: controller.myTaskModel2!.offerTasks.length,
                      itemBuilder: (context, index) {
                        var details = controller.myTaskModel2!.offerTasks;

                        return Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 190.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: CustomText(
                                            "Title: ${controller.myTaskModel2!.offerTasks[index].title}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Location: ${controller.myTaskModel2!.offerTasks[index].location}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Offers: ${controller.myTaskModel2!.offerTasks[index].hour}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Date : ${controller.myTaskModel2!.offerTasks[index].date} ",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 120.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: CustomText(
                                            "Amount \$ 2400",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          child: CustomText(
                                              "Details",
                                              Colors.black,
                                              FontWeight.normal,
                                              13.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator())),
                  
              FutureBuilder(
                  future: controller.getMyTask(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.data.seekedTrips.length,
                          itemBuilder: (context, index) {
                            var tripData =
                                snapshot.data.data.seekedTrips[index];
                            return Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 190.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: CustomText(
                                                "Start Point:${snapshot.data.data.completedTrips[index].startPoint}",
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
                                                "Offers: ${tripData.postType}",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                          Container(
                                            child: CustomText(
                                                "Posted by:  ${tripData.via}",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                          Container(
                                            child: CustomText(
                                                "Male/25/Bachelor Degree or equivalent/Private job",
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
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: CustomText(
                                                "Amount \$${tripData.amount}",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                          Container(
                                            child: CustomText(
                                                "Details",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          // Container(
                                          //   padding: EdgeInsets.only(
                                          //       left: 10.w,
                                          //       right: 10.w,
                                          //       top: 5.h,
                                          //       bottom: 5.h),
                                          //   decoration: BoxDecoration(
                                          //       color: navyBlueColor,
                                          //       borderRadius:
                                          //           BorderRadius.circular(
                                          //               10.r)),
                                          //   child: CustomText(
                                          //       "Make offer",
                                          //       Colors.white,
                                          //       FontWeight.normal,
                                          //       13.sp),
                                          // ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: CustomText(
                                                "Passenger: ${tripData.vehicleSeat}",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                      color: navyBlueColor,
                    ));
                  }),
              FutureBuilder(
                  future: controller.getMyTask(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.data.completedTrips.length,
                          itemBuilder: (context, index) {
                            var tripData =
                                snapshot.data.data.completedTrips[index];
                            return Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 190.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: CustomText(
                                                "Title:${snapshot.data.data.completedTrips[index].title}",
                                                Colors.black,
                                                FontWeight.bold,
                                                13.sp),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            child: CustomText(
                                                "Start Point:${snapshot.data.data.completedTrips[index].startPoint}",
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
                                                "Offers: ${tripData.postType}",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                          Container(
                                            child: CustomText(
                                                "Posted by:  ${tripData.via}",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                          Container(
                                            child: CustomText(
                                                "Male/25/Bachelor Degree or equivalent/Private job",
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
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: CustomText(
                                                "Amount \$${tripData.amount}",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                          Container(
                                            child: CustomText(
                                                "Details",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: CustomText(
                                                "Passenger:  ${tripData.vehicleSeat}",
                                                Colors.black,
                                                FontWeight.normal,
                                                13.sp),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                      color: navyBlueColor,
                    ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
