import 'dart:async';
import 'dart:convert';

import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/custom_text_field.dart';
import 'package:tripshiptask/pages/Task/views/task_home_page.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/model/trip_post_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TripOfferNegotiatePage extends StatefulWidget {
  String? path;
  TripOfferNegotiatePage(this.path);

  @override
  State<TripOfferNegotiatePage> createState() => _TripOfferNegotiatePageState();
}

class _TripOfferNegotiatePageState extends State<TripOfferNegotiatePage> {
  final _box = GetStorage();

  TripPostDetailsModel? tripPostDetailsModel;
  var controller = Get.put(TripController());
  final _formOfferkey = GlobalKey<FormState>();
  final TextEditingController shortmessage = TextEditingController();
  final TextEditingController amount = TextEditingController();

  var tripId;
  var seatValue;
  bool seatStatus = false;
  var seat;
  List<DropdownMenuItem<String>> get dropdownItem {
    List<DropdownMenuItem<String>> seatMember = [
      const DropdownMenuItem(child: Text("1"), value: "1"),
      const DropdownMenuItem(child: Text("2"), value: "2"),
      const DropdownMenuItem(child: Text("3"), value: "3"),
    ];
    return seatMember;
  }

  getTripPostDetails() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      var response = await http.get(
        Uri.parse("${urlWithOutslash}${widget.path}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("detail ${jsonData}");
        tripPostDetailsModel = TripPostDetailsModel.fromJson(jsonData);
        return TripPostDetailsModel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  bool status = false;
  void initState() {
    getTripPostDetails();
    Timer(Duration(seconds: 2), () {
      setState(() {
        status = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // controller.getTripPostDetails(widget.path);
    // //  print("toh detail ${controller.tripPostDetailsModel!.data!.title}");
    // var details = controller.tripPostDetailsModel!.data!;
    print("koli ${widget.path}");
    return Scaffold(
      appBar: customAppBar(),
      body: status == true
          ? FutureBuilder(
              future: getTripPostDetails(),
              builder: (context, AsyncSnapshot snapshot) {
                var details = tripPostDetailsModel!.tripDetailsModel!;
                //  var details = snapshot.data.data;
                if (details == 0) {
                  return Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: ListView(
                    children: [
                      TripDetailsWidget(
                        title: "Title",
                        value: details.title,
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Posted By",
                        value: details.user,
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Post Type",
                        value: details.postType,
                        status: false,
                      ),
                      TripDetailsWidget(
                          title: "Start Point",
                          value: details.startPoint,
                          status: false),
                      TripDetailsWidget(
                        title: "Destination",
                        value: details.destination,
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Passenger",
                        value: details.bids![0].passenger.toString(),
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Preferred Passenger",
                        value: " ${details.preferredPassenger} ",
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Vehicle Type",
                        value:
                            " ${details.pay} ${details.currency.toString()} ",
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Duration",
                        value: " ${details.duration} ",
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Distance",
                        value: " ${details.distance}  ",
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Pay",
                        value:
                            " ${details.pay} ${details.currency.toString()} ",
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Bid Amount",
                        value:
                            "${details.bids![0].amount.toString()} ${details.currency.toString()} ",
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Negotiate Amount",
                        value:
                            "${details.bids![0].co.toString()} ${details.currency.toString()} ",
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Agree",
                        value: details.bids![0].agree.toString(),
                        status: true,
                      ),
                      TripDetailsWidget(
                        title: "Number Of Bid",
                        value: details.bidsCount.toString(),
                        status: false,
                      ),
                      TripDetailsWidget(
                        title: "Status",
                        value: details.status.toString(),
                        status: false,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButtonOne(
                              title: "Decline",
                              btnColor: Colors.amber,
                              marginLR: 10,
                              width: 100.w,
                              height: 45.h,
                              onTab: () {}),
                          CustomButtonOne(
                              title: "Agree",
                              marginLR: 10,
                              width: 100.w,
                              height: 45.h,
                              fontSize: 15.sp,
                              btnColor: Colors.green,
                              onTab: () {
                                print(
                                    "agree id ${details.bids![0].id.toString()}");
                                // controller
                                //     .tripAgree(details.bids![0].id.toString());
                              })
                        ],
                      )
                    ],
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
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
          width: 120.w,
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: CustomText("$title :", Colors.black, FontWeight.bold, 14.sp),
        ),
        status == false
            ? Container(
                width: 200.w,
                child: CustomText(
                    " ${value}", Colors.black, FontWeight.w500, 15.sp),
              )
            : Container(
                width: 200.w,
                child: CustomText(" ${value == "0" ? "No" : "Yes"}",
                    Colors.black, FontWeight.w500, 14.sp),
              ),
      ],
    );
  }
}
