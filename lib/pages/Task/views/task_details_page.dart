import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';

import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';

import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Ship/views/ship_send_package_details.dart';
import 'package:tripshiptask/pages/Task/controller/task_process_con.dart';

import 'package:tripshiptask/pages/Task/model/my_task_details_model.dart';
import 'package:tripshiptask/pages/Task/views/update_give_task.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_details_page.dart';

import 'package:tripshiptask/pages/Trip/views/trip_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/profile/view/user_deshboard.dart';

import '../../Home/trip_ship_task_home.dart';

class TaskDetailPage extends StatefulWidget {
  String path;
  TaskDetailPage(this.path);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final _box = GetStorage();

  final _formOfferkey = GlobalKey<FormState>();
  final TextEditingController shortmessage = TextEditingController();
  final TextEditingController amount = TextEditingController();

  bool status = false;

  Future<MyTaskDetailsModel> getTaskDetails() async {
    //print("koli path ${widget.path}");
    var token = _box.read(LocalStoreKey.token);

    var response = await http.get(
      Uri.parse("${urlWithOutslash}${widget.path}"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print("koli2 $jsonData");
    }
    return MyTaskDetailsModel.fromJson(jsonData);
  }

  var taskId;
  void initState() {
    getTaskDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //details =  controller.myTaskDetailsModel2!;

    return Scaffold(
        appBar: customAppBar(),
        body: FutureBuilder(
            future: getTaskDetails(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var task = snapshot.data.myTaskDetailsModel;
                taskId = snapshot.data.myTaskDetailsModel.id;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        height: 550.h,
                        child
                            : ListView(
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  TripDetailsWidget(
                                      status: false,
                                      title: "Title",
                                      value:
                                          "${snapshot.data.myTaskDetailsModel.title}"),
                                  TripDetailsWidget(
                                      status: false,
                                      title: "Skills Required",
                                      value: "${task.skills[0]}"),
                                  TripDetailsWidget(
                                      status: false,
                                      title: " Task Location",
                                      value: "${task!.location}"),
                                  TripDetailsWidget(
                                      status: false,
                                      title: " Offered Amount",
                                      value: "${task.amount.toString()}.Tk"),
                                  TripDetailsWidget(
                                      status: false,
                                      title: "Time",
                                      value: "${task.time}"),
                                  TripDetailsWidget(
                                      status: false,
                                      title: "Task Date",
                                      value:
                                          "${DateFormat.yMMMd().format(task.date)}"),
                                  TripDetailsWidget(
                                      status: false,
                                      title: "Hour needed ",
                                      value: "${task.hourNeed} hour"),
                                  task.bids.length != 0
                                      ? Container(
                                          height: 400.h,
                                          child: ListView.builder(
                                              itemCount: snapshot
                                                  .data
                                                  .myTaskDetailsModel
                                                  .bids
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                    margin:
                                                        EdgeInsets.all(10.h),
                                                    padding:
                                                        EdgeInsets.all(5.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        ShipDetailsWidget(
                                                            title: "Post By",
                                                            width: 80.0,
                                                            valueWidth: 180.0,
                                                            value:
                                                                "${snapshot.data!.myTaskDetailsModel!.bids[index]['bidder_name']}",
                                                            status: false),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        ShipDetailsWidget(
                                                            title: "Amount",
                                                            width: 80.0,
                                                            valueWidth: 180.0,
                                                            value:
                                                                "${snapshot.data!.myTaskDetailsModel!.bids[index]['amount']}",
                                                            status: false),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        snapshot.data!.myTaskDetailsModel!
                                                                            .bids[
                                                                        index][
                                                                    'accepted'] ==
                                                                1
                                                            ? Container(
                                                                child:
                                                                    customText(
                                                                  title:
                                                                      "Offer accepted",
                                                                ),
                                                              )
                                                            : Container(),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "Confirm the Shipment?"),
                                                            SizedBox(
                                                              width: 20.w,
                                                            ),
                                                            InkWell(
                                                                onTap: () {},
                                                                child: Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 15
                                                                            .w,
                                                                        vertical: 5
                                                                            .h),
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .green),
                                                                    child: const Text(
                                                                        "Yes"))),
                                                            SizedBox(
                                                              width: 15.w,
                                                            ),
                                                            InkWell(
                                                                onTap: () {},
                                                                child: Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 15
                                                                            .w,
                                                                        vertical: 5
                                                                            .h),
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .orange),
                                                                    child: Text(
                                                                        "No"))),
                                                          ],
                                                        )
                                                      ],
                                                    ));
                                              }),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  task.userId.toString() ==
                                          _box.read(LocalStoreKey.userId)
                                      ? Container()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green),
                                                onPressed: () {},
                                                icon: Icon(Icons.add),
                                                label: Text("Accept")),
                                            SizedBox(width: 10.w),
                                            ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.deepPurple),
                                                onPressed: () {
                                               taskProCon.bidTaskOffer(
                                    amount: "550",
                                    taskId: taskId.toString(),
                                    message: "test ");
                                                },
                                                icon: Icon(Icons.add),
                                                label: Text("Make Offer")),
                                          ],
                                        ),
                                  task.userId == _box.read(LocalStoreKey.userId)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            bidButton(
                                              ontab: () {
                                                Get.to(
                                                    UpdateOfferTask(task.path));
                                              },
                                              title: "Edit Task",
                                              width: 80.w,
                                              size: 15.sp,
                                            ),
                                            bidButton(
                                              ontab: () {},
                                              title: "Cancel Task",
                                              width: 100.w,
                                              size: 15.sp,
                                              color: Colors.amberAccent,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                      )
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  var taskProCon = Get.put(TaskProcessController());
  Future<dynamic> makeOffer(BuildContext context, amt) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text("Make Counter Offer"),
          content: Container(
              height: 180.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 40.h,
                      child: TextFormField(
                        controller: amount,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your amount';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "$amt",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextFormField(
                        controller: shortmessage,
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "short message (Optional)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 80.w,
                            radius: 5.r,
                            marginLR: 10.w,
                            title: "Close",
                            btnColor: Colors.red,
                            onTab: () {
                              Get.back();
                              setState(() {
                                getTaskDetails();
                              });
                            }),
                        CustomButtonOne(
                            width: 80.w,
                            height: 30.h,
                            radius: 5.r,
                            marginLR: 0.w,
                            title: "Submit",
                            btnColor: navyBlueColor,
                            onTab: () {
   taskProCon.bidTaskOffer(
                                    amount: amount.text.toString(),
                                    taskId: taskId.toString(),
                                    message: shortmessage.text.toString());

                              // print(amount.text.toString());

                              // print(shortmessage.text.toString());
                              // var _isValid =
                              //     _formOfferkey.currentState!.validate();
                              // if (_isValid) {
                              //   taskProCon.bidTaskOffer(
                              //       amount: amount.text.toString(),
                              //       taskId: taskId.toString(),
                              //       message: shortmessage.text.toString());
                              // } else {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(const SnackBar(
                              //     content: Text("Offer not submitted"),
                              //   ));
                              // }
                             
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}

class TripDetailsWidget extends StatelessWidget {
  String? title;
  String? value;
  late bool status = false;
  TripDetailsWidget({super.key, this.value, this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100.w,
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: CustomText("$title :", Colors.black, FontWeight.w500, 13.sp),
        ),
        status == false
            ? Container(
                width: 200.w,
                child: CustomText(
                    " ${value}", Colors.black, FontWeight.normal, 13.sp),
              )
            : Container(
                width: 200.w,
                child: CustomText(" ${value == "0" ? "NO" : "Yes"}",
                    Colors.black, FontWeight.normal, 14.sp),
              ),
      ],
    );
  }
}
