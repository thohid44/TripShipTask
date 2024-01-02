import 'package:intl/intl.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Task/controller/task_controller.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/pages/Task/views/task_details_page.dart';
import 'package:tripshiptask/rating/view/task_giver_feedback_rating.dart';

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
                         var details =
                              controller.myTaskModel2!.offerTasks[index];
                     
                         
                          return Card(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 280.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                              "Title :",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${details.title}",
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
                                          height: 3.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                              "Location :",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            Expanded(
                                              child: Text(
                                                "${details.location}",
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
                                          height: 3.h,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                              "Date & Time: ",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            Expanded(
                                              child: Text(
                                                "${DateFormat.yMMMd().format(details.date)}",
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
                                                  CustomText(
                                                      "2000 ",
                                                      Colors.black,
                                                      FontWeight.normal,
                                                      12.sp),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var path = details.path!;

                                                  Get.to(TaskDetailPage(path,""),
                                                      duration: Duration(
                                                          milliseconds:
                                                              300), //duration of transitions, default 1 sec
                                                      transition: Transition
                                                          .leftToRight //transition effect

                                                      );
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
                                ],
                              ),
                            ),
                          );
                        
                    
                      })
                  : Center(child: CircularProgressIndicator())),
                  // Start 2nd TabBar
                  
              Obx(() => controller.isLoading.value == false
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.myTaskModel2!.seekedTasks.length,
                      itemBuilder: (context, index) {
                        var details =
                            controller.myTaskModel2!.seekedTasks[index];
                        return Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 280.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Title :",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${details.title}",
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
                                        height: 3.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Location :",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${details.location}",
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
                                        height: 3.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Date & Time: ",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${DateFormat.yMMMd().format(details.date)}",
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
                                                CustomText(
                                                    "2000 ",
                                                    Colors.black,
                                                    FontWeight.normal,
                                                    12.sp),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                var path = details.path!;

                                                Get.to(TaskDetailPage(path,""),
                                                    duration: Duration(
                                                        milliseconds:
                                                            300), //duration of transitions, default 1 sec
                                                    transition: Transition
                                                        .leftToRight //transition effect

                                                    );
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
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator())),
              Obx(() => controller.isLoading.value == false
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.myTaskModel2!.completedTasks.length,
                      itemBuilder: (context, index) {
                        var details =
                            controller.myTaskModel2!.completedTasks[index];

                        return Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 280.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Title :",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${details.title}",
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
                                        height: 3.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Location :",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${details.location}",
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
                                        height: 3.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Date & Time: ",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          Expanded(
                                            child: Text(
                                              "${DateFormat.yMMMd().format(details.date)}",
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
                                                CustomText(
                                                    "2000 ",
                                                    Colors.black,
                                                    FontWeight.normal,
                                                    12.sp),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                var path = details.path!;

                                                Get.to(
                                                    TaskGiverFeedBackRating(
                                                        path: path),
                                                    duration: Duration(
                                                        milliseconds:
                                                            300), //duration of transitions, default 1 sec
                                                    transition: Transition
                                                        .leftToRight //transition effect

                                                    );
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

                                        GestureDetector(
                                    onTap: () {
                                   var path = details.path!;

                                    Get.to(TaskDetailPage(path,""),
                                        duration: Duration(
                                            milliseconds:
                                                300), //duration of transitions, default 1 sec
                                        transition: Transition
                                            .leftToRight //transition effect

                                        );
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
                  : Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}
