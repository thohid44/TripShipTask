import 'package:intl/intl.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/pages/Task/controller/task_controller.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/pages/Task/views/task_details_page.dart';


class MyTaskOffersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTaskOffersPageState();
  }
}

class _MyTaskOffersPageState extends State<MyTaskOffersPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
  
  }

 
  var controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: customAppBar(),
          body:   Obx(() => controller.isLoading.value == false
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.myTaskOfferList.length,
                      itemBuilder: (context, index) {
                        if (controller.myTaskOfferList.isEmpty) {
                          var details =
                              controller.myTaskOfferList[index];
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
                                            // Expanded(
                                            //   child: Text(
                                            //     "${DateFormat.yMMMd().format(details[index])}",
                                            //     style: TextStyle(
                                            //       fontSize: 12.sp,
                                            //       fontWeight: FontWeight.normal,
                                            //     ),
                                            //     maxLines: 1,
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // ),
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
                        }
                        return Center(
                          child: Text("No Data"),
                        );
                      })
                  : Center(child: CircularProgressIndicator())),
   
             
       
        )
      
    ;
  }
}
