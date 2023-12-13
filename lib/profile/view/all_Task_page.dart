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
            
                Obx(() => controller.isLoading.value == false
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.myTaskModel2!.seekedTasks.length,
                      itemBuilder: (context, index) {
                       var details = controller.myTaskModel2!.seekedTasks;

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
                                            "Title: ${details[index].title}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Location: ${details[index].location}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Offers: ${details[index].hour}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Date : ${details[index].date} ",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
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
                       var completed =controller.myTaskModel2!.completedTasks;

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
                                            "Title: ${completed[index].title}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Location: ${completed[index].location}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Offers: ${completed[index].hour}",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
                                      ),
                                      Container(
                                        child: CustomText(
                                            "Date : ${completed[index].date} ",
                                            Colors.black,
                                            FontWeight.normal,
                                            13.sp),
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
