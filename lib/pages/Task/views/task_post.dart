import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Task/controller/task_controller.dart';
import 'package:tripshiptask/pages/Task/views/task_details_page.dart';

class TaskPost extends StatelessWidget {
  var controller = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    controller.searchAllGiveTask();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Obx(() => controller.isLoading == false
            ? ListView.builder(
                itemCount: controller.allGiveTaskList.length,
                itemBuilder: (context, index) {
                  var details = controller.allGiveTaskList[index];
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                              Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  "Title :",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                SizedBox(height: 3.h,), 
                                Expanded(
                                  child: Text("${details.title}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                              ],
                            ),
                             SizedBox(height: 3.h,), 
                              Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Text("${details.location}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h,), 
                                Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Text("${DateFormat.yMMMd().format(details.date)}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
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
                                CustomText("Offered Amt: ", Colors.black,
                                    FontWeight.bold, 12.sp),
                                CustomText("2000 ",
                                    Colors.black, FontWeight.normal, 12.sp),
                              ],
                            ),
                              
                                  GestureDetector(
                                    onTap: () {
                                   var path = details.path!;

                                    Get.to(TaskDetailPage(path,"Give a Task"),
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
