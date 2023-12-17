import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/widget_button.dart';
import 'package:tripshiptask/pages/Ship/controller/shipController.dart';
import 'package:tripshiptask/pages/Ship/model/sh_Snd_Package_Details_M.dart';
import 'package:tripshiptask/pages/Ship/views/shipPage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Ship/views/ship_send_package_edit.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';

import '../../../Home/trip_ship_task_home.dart';

class ShipSendPackageDetails extends StatefulWidget {
  String? path;
  ShipSendPackageDetails({super.key, this.path});

  @override
  State<ShipSendPackageDetails> createState() => _ShipSendPackageDetailsState();
}

class _ShipSendPackageDetailsState extends State<ShipSendPackageDetails> {
  final _box = GetStorage();
  var controller = Get.put(ShipController());
  var shipId;
  var ships;
  Future<ShipSendPackageDetailsModel> shipSendPackageDetails() async {
    print("koli path ${widget.path}");
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
      print("koli2 $jsonData");
    }
    return ShipSendPackageDetailsModel.fromJson(jsonData);
  }

  void initState() {
    shipSendPackageDetails();
    super.initState();
  }
var path; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: FutureBuilder(
          future: shipSendPackageDetails(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              shipId = snapshot.data!.data!.id;
              path = snapshot.data!.data!.path;
              return Container(
                margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 20.h),
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          ShipDetailsWidget(
                              title: "PickUp",
                              value: "${snapshot.data!.data!.startPoint}",
                              status: false),
                          ShipDetailsWidget(
                              title: "Drop Off",
                              value: "${snapshot.data!.data!.destination}",
                              status: false),
                          ShipDetailsWidget(
                              title: "Post By",
                              value: "${snapshot.data!.data!.user}",
                              status: false),
                          ShipDetailsWidget(
                              title: "Package Type",
                              value: "${snapshot.data!.data!.packageType}",
                              status: false),
                          ShipDetailsWidget(
                              title: "Status",
                              value: "${snapshot.data!.data!.status}",
                              status: false),
                          ShipDetailsWidget(
                              title: "Meterial",
                              value: "${snapshot.data!.data!.documents}",
                              status: false),
                          ShipDetailsWidget(
                              title: "Bid Count",
                              value: "${snapshot.data!.data!.bidsCount}",
                              status: false),
                          ShipDetailsWidget(
                              title: "Willing to pay",
                              value: "${snapshot.data!.data!.amount}",
                              status: false),
                          ShipDetailsWidget(
                              title: "Document Price",
                              value: "${snapshot.data!.data!.documentPrice}",
                              status: false),
                        ],
                      ),
                    ),
                    Container(
                      height: 300.h,
                      child: ListView.builder(
                          itemCount: snapshot.data!.data!.bids.length,
                          itemBuilder: (context, index) {
                            ships = snapshot.data!.data!.bids;
                            return Container(
                                margin: EdgeInsets.all(10.h),
                                padding: EdgeInsets.all(5.h),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                                child: Column(
                                  children: [
                                    ShipDetailsWidget(
                                        title: "Offer By",
                                        width: 80.0,
                                        valueWidth: 180.0,
                                        value:
                                            "${snapshot.data!.data!.bids[index]['bidder_name']}",
                                        status: false),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    ShipDetailsWidget(
                                        title: "Amount",
                                        width: 80.0,
                                        valueWidth: 180.0,
                                        value:
                                            "${snapshot.data!.data!.bids[index]['co']}",
                                        status: false),
                                    ships[index]['co'] == null
                                        ? Container()
                                        : ShipDetailsWidget(
                                            title: "Counter Offer",
                                            width: 80.0,
                                            valueWidth: 180.0,
                                            value:
                                                "${snapshot.data!.data!.bids[index]['co']}",
                                            status: false),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    snapshot.data!.data!.bids[index]['co'] ==
                                            null
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ships[index]['agree'] == 1
                                                  ? Container()
                                                  : Container(
                                                      child: Text(
                                                        "Counter Offer send",
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                              ships[index]['agree'] == 1
                                                  ? Container()
                                                  : InkWell(
                                                      onTap: () {
                                                        controller
                                                            .giveShipAgree(
                                                                shipId);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 30.h,
                                                        width: 80.w,
                                                        decoration: BoxDecoration(
                                                            color: greenColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r)),
                                                        child: Text(
                                                          "Agree",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ),
                                              ships[index]['agree'] == 1
                                                  ? Container()
                                                  : InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 30.h,
                                                        width: 80.w,
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r)),
                                                        child: Text(
                                                          "Decline",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                    Row(
                                      children: [
                                        Text("Agree"),
                                        ships[index]['agree'] == 0
                                            ? Container(
                                                child: customText(
                                                  title: "Not Agree",
                                                ),
                                              )
                                            : customText(
                                                title: "Agreed",
                                              ),
                                      ],
                                    ),
                                    ships[index]['accepted'] == 1
                                        ? Container(
                                            child: customText(
                                              title: "Offer accepted",
                                            ),
                                          )
                                        : Container(),
                                    ships[index]['accepted'] == 0
                                        ? Container()
                                        : Row(
                                            children: [
                                              Text("Confirm the Shipment?"),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.w,
                                                              vertical: 5.h),
                                                      decoration: BoxDecoration(
                                                          color: Colors.green),
                                                      child: Text("Yes"))),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.w,
                                                              vertical: 5.h),
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange),
                                                      child: Text("No"))),
                                            ],
                                          ),
                                  ],
                                ));
                          }),
                    ),
                     CustomButtonOne(
                        height: 30.h,
                        width: 100.w,
                        radius: 5.r,
                        marginLR: 10.w,
                        title: "Edit",
                        btnColor: Colors.green,
                        onTab: () {
                          Get.to(ShipSendPackgeEdit(path));
                        }),
                    _box.read(LocalStoreKey.userId) ==
                            snapshot.data!.data.userId
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButtonOne(
                                  width: 100.w,
                                  height: 35.h,
                                  title: "Accept",
                                  btnColor: navyBlueColor,
                                  marginLR: 5.w,
                                  radius: 5.r,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  onTab: () {}),
                              CustomButtonOne(
                                  width: 120.w,
                                  height: 35.h,
                                  title: "Make Offer",
                                  btnColor: navyBlueColor,
                                  marginLR: 5.w,
                                  radius: 5.r,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  onTab: () {
                                    makeOffer(context);
                                  }),
                            ],
                          )
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  final _formOfferkey = GlobalKey<FormState>();
  final TextEditingController amount = TextEditingController();
  final TextEditingController shortmessage = TextEditingController();
  Future<dynamic> makeOffer(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text("Make Counter Offer"),
          content: Container(
              height: 300.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextFormField(
                        controller: amount,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your amount';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "amount",
                        ),
                      ),
                    ),
                     
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextFormField(
                        controller: shortmessage,
                        maxLines: 3,
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
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 100.w,
                            radius: 5.r,
                            marginLR: 10.w,
                            title: "Close",
                            btnColor: Colors.red,
                            onTab: () {
                              Get.back();
                            }),
                        CustomButtonOne(
                            width: 100.w,
                            height: 30.h,
                            radius: 5.r,
                            marginLR: 0.w,
                            title: "Submit",
                            btnColor: navyBlueColor,
                            onTab: () {
                              print(amount.text.toString());

                              print(shortmessage.text.toString());
                              var _isValid =
                                  _formOfferkey.currentState!.validate();
                              if (_isValid) {
                                controller.bidOnGivenShip(
                                    amount: amount.text.toString(),
                                    shipId: shipId.toString(),
                                    message: shortmessage.text.toString());
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Offer not submitted"),
                                ));
                              }
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}

class ShipDetailsWidget extends StatelessWidget {
  String? title;
  String? value;
  dynamic width;
  dynamic valueWidth;
  late bool status = false;
  ShipDetailsWidget(
      {super.key,
      this.value,
      this.title,
      this.width,
      this.valueWidth,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              alignment: Alignment.topLeft,
              width: width ?? 100.w,
              child: Text(
                "$title",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )),
          status == false
              ? Container(
                  width: valueWidth ?? 200.w,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "$value  ",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ))
              : Container(
                  width: 200.w,
                  child: CustomText(" ${value == "0" ? "NO" : "Yes"}",
                      Colors.black, FontWeight.w500, 13.sp),
                ),
        ],
      ),
    );
  }
}
