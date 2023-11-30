import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Task/controller/task_controller.dart';
import 'package:tripshiptask/pages/Task/views/task_details_page.dart';

class TaskSeekPost extends StatelessWidget {
  var controller = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    controller.allSeekTask();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Obx(() => controller.seekIsLoading == false
            ? ListView.builder(
                itemCount: controller.seekTaskList.length,
                itemBuilder: (context, index) {
                  var details = controller.seekTaskList[index];
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: CustomText("Title: ${details.title}",
                                      Colors.black, FontWeight.normal, 13.sp),
                                ),
                                Container(
                                  child: CustomText(
                                      "Location: ${details.location}]",
                                      Colors.black,
                                      FontWeight.normal,
                                      13.sp),
                                ),
                                Container(
                                  child: CustomText(
                                      "Offers: ${details.bidsCount}",
                                      Colors.black,
                                      FontWeight.normal,
                                      13.sp),
                                ),
                                Container(
                                  child: CustomText(
                                      "Date & Time: ${DateFormat.yMMMd().format(details.date)}",
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
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: CustomText("Amount ${details.amount}",
                                      Colors.black, FontWeight.normal, 13.sp),
                                ),
                                InkWell(
                                  onTap: () {
                                    var path = details.path!;

                                    Get.to(TaskDetailPage(path),
                                        duration: Duration(
                                            milliseconds:
                                                300), //duration of transitions, default 1 sec
                                        transition: Transition
                                            .leftToRight //transition effect

                                        );
                                  },
                                  child: Container(
                                    child: CustomText("Details", Colors.black,
                                        FontWeight.normal, 13.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                      top: 5.h,
                                      bottom: 5.h),
                                  decoration: BoxDecoration(
                                      color: navyBlueColor,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: CustomText("Make offer", Colors.white,
                                      FontWeight.normal, 13.sp),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }
}
