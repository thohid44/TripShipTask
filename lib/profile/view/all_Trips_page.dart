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
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.data.seekedTrips.length,
                          itemBuilder: (context, index) {
                            var tripData =
                                snapshot.data.data.postedTrips[index];

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
