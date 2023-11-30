import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_details_page.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
  }

  static const List<Tab> _tabs = [
    const Tab(child: const Text('Posted Trip')),
    const Tab(text: 'Seek Trip'),
    const Tab(text: 'Completed Trip'),
  ];
  var controller = Get.put(TripController());

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
            title: const Text('TripShipTask'),
            backgroundColor: navyBlueColor,
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
            //     controller: _tabController,
            children: [
              FutureBuilder(
                  future: controller.getMyTrips(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.data.postedTrips.length,
                          itemBuilder: (context, index) {
                            var tripData =
                                snapshot.data.data.postedTrips[index];

                            return Card(
                              child: GestureDetector(
                                onTap: () {
                                  var path = snapshot
                                      .data.data.postedTrips[index].path;
                                  Get.to(TripDetailsPage(path));
                                },
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
                                                  "Start Point:${snapshot.data.data.postedTrips[index].startPoint}",
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
                              ),
                            );
                          });
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: navyBlueColor,
                      ));
                    }
                    return const Center(child: Text("data"));
                  }),
              FutureBuilder(
                  future: controller.getMyTrips(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
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
                  future: controller.getMyTrips(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
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
