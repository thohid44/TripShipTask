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
import 'package:tripshiptask/pages/Ship/controller/ship_process_controller.dart';
import 'package:tripshiptask/pages/Ship/model/sh_Snd_Package_Details_M.dart';
import 'package:tripshiptask/pages/Ship/views/shipPage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Ship/views/ship_send_package_edit.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_details_page.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';

import '../../Home/trip_ship_task_home.dart';

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

  var space = 3;
  var path;
  var shipProController = Get.put(ShipProcessController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: FutureBuilder(
          future: shipSendPackageDetails(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              shipId = snapshot.data!.data!.id;
              ships = snapshot.data!.data!;
              path = snapshot.data!.data!.path;
              return Container(
                margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h),
                child: ListView(
                  children: [
                    Container(
                      width: 300.w,
                      alignment: Alignment.center,
                      child: Text("Send A Package",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          ShipDetailsWidget(
                              title: "PickUp:",
                              value: "${snapshot.data!.data!.startPoint}",
                              status: false),
                          SizedBox(height: space.h),
                          ShipDetailsWidget(
                              title: "Drop Off:",
                              value: "${snapshot.data!.data!.destination}",
                              status: false),
                          SizedBox(height: space.h),
                          ShipDetailsWidget(
                              title: "Post By:",
                              value: "${snapshot.data!.data!.user}",
                              status: false),
                          SizedBox(height: space.h),
                          ShipDetailsWidget(
                              title: "Package Type:",
                              value: "${snapshot.data!.data!.packageType}",
                              status: false),
                          SizedBox(height: space.h),
                          ShipDetailsWidget(
                              title: "Status:",
                              value: "${snapshot.data!.data!.status}",
                              status: false),
                          SizedBox(height: space.h),
                          ShipDetailsWidget(
                              title: "Meterial:",
                              value: "${snapshot.data!.data!.documents}",
                              status: false),
                          SizedBox(height: space.h),
                          ShipDetailsWidget(
                              title: "Bid Count:",
                              value: "${snapshot.data!.data!.bidsCount}",
                              status: false),
                          SizedBox(height: space.h),
                          ShipDetailsWidget(
                              title: "Willing to pay",
                              value: "${snapshot.data!.data!.amount}",
                              status: false),
                          SizedBox(height: space.h),
                          ShipDetailsWidget(
                              title: "Document Price",
                              value: "${snapshot.data!.data!.documentPrice}",
                              status: false),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 300.h,
                      child: ListView.builder(
                          itemCount: snapshot.data!.data!.bids.length,
                          itemBuilder: (context, index) {
                            ships = snapshot.data!.data!;
                            return Container(
                                padding: EdgeInsets.all(5.h),
                                margin: EdgeInsets.all(5.h),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShipDetailsWidget(
                                        title: "Offer By:",
                                        width: 80.0,
                                        valueWidth: 180.0,
                                        value:
                                            "${snapshot.data!.data!.bids[index]['bidder_name']}",
                                        status: false),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    ShipDetailsWidget(
                                        title: "Counter Offer Received:",
                                        width: 180.0,
                                        valueWidth: 60.0,
                                        value:
                                            "${snapshot.data!.data!.bids[index]['amount']}",
                                        status: false),
                                    ships.bids[index]['co'] == null
                                        ? Container()
                                        : ShipDetailsWidget(
                                            title: "Counter Offer",
                                            width: 100.0,
                                            valueWidth: 200.0,
                                            value:
                                                "${snapshot.data!.data!.bids[index]['co']}",
                                            status: false),
                                    SizedBox(
                                      height: 5.h,
                                    ),
// Bidder Part
                                    snapshot.data!.data!.userId ==
                                            _box.read(LocalStoreKey.userId)
                                        ? Container()
                                        : Container(
                                            child: Column(
                                              children: [
                                                snapshot.data!.data!.bids[index]
                                                            ['co'] ==
                                                        null
                                                    ? Container()
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              "Counter Offer Received ${ships.bids[index]['co']} BDT",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          ships.bids[index][
                                                                      'agree'] ==
                                                                  1
                                                              ? Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 30.h,
                                                                  width: 50.w,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          greenColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.r)),
                                                                  child: Text(
                                                                    "Agreed",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    shipId = ships
                                                                            .bids[
                                                                        index]['id'];
                                                                    agreeOffer(
                                                                        context,
                                                                        shipId);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    height:
                                                                        30.h,
                                                                    width: 50.w,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            greenColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.r)),
                                                                    child: Text(
                                                                      "Agree",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                          ships.bids[index][
                                                                      'agree'] ==
                                                                  1
                                                              ? Container()
                                                              : InkWell(
                                                                  onTap: () {},
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    height:
                                                                        30.h,
                                                                    width: 50.w,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.r)),
                                                                    child: Text(
                                                                      "Decline",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                        ],
                                                      ),

                                                // Accept Part
                                                ships.bids[index]['accepted'] ==
                                                        1
                                                    ? ShipDetailsWidget(
                                                        title: "Offer Status",
                                                        width: 100.0,
                                                        valueWidth: 180.0,
                                                        value: "Accepted",
                                                        status: false)
                                                    : Container(),

                                                ships.bids[index]['accepted'] ==
                                                        0
                                                    ? Container()
                                                    : Row(
                                                        children: [
                                                          Text(
                                                            "Click on 'Finish Shipment' after \ncompleting your shipment",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent,
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                    finishShipment(context,ships.bids[index]['id']
                                                        );
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10.w,
                                                                      vertical:
                                                                          5.h),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color:
                                                                              Colors.green),
                                                                  child: Text(
                                                                    "Finish Shipment",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ))),
                                                        ],
                                                      ),
                                                //End Accept Part
                                              ],
                                            ),
                                          ),

// Poster Part
                                    snapshot.data!.data!.userId !=
                                            _box.read(LocalStoreKey.userId)
                                        ? Container()
                                        : Container(
                                          height: 100.h,
                                            child: Column(
                                              children: [
                                                ships.bids[index]['co'] == null
                                                    ? Container()
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.w),
                                                        child: Row(
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Counter Offer Sent: ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12.sp,
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        '${ships.bids[index]['co'].toString()} BDT',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            ships.bids[index][
                                                                        'agree'] ==
                                                                    1
                                                                ? Container(
                                                                    child: Text(
                                                                      "Agreed",
                                                                      style: TextStyle(
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    "Pending",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            ships.bids[index][
                                                                        'accepted'] ==
                                                                    1
                                                                ? bidButton(
                                                                    ontab: () {
                                                                      // acceptOffer(context, trip.bids[index]['id'].toString(), trip.bids[index]['co'].toString());
                                                                    },
                                                                    title:
                                                                        "Accepted",
                                                                    color: Color(
                                                                        0xff00BC8B),
                                                                  )
                                                                : bidButton(
                                                                    ontab: () {
                                                                      acceptOffer(
                                                                          context,
                                                                          ships.bids[index]['id']
                                                                              .toString(),
                                                                          ships
                                                                              .bids[index]['co']
                                                                              .toString());
                                                                    },
                                                                    title:
                                                                        "Accept",
                                                                    width: 50.w,
                                                                    color: Color(
                                                                        0xff00BC8B),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ships.bids[index]
                                                                  ['agree'] ==
                                                              1
                                                          ? Container()
                                                          : Text(
                                                              "Counter Offer",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      13.sp),
                                                            ),
                                                      ships.bids[index]
                                                                  ['agree'] ==
                                                              1
                                                          ? Container()
                                                          : Text(
                                                              "${ships.bids[index]['amount'].toString()}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      13.sp)),
                                                      ships.bids[index]
                                                                  ['agree'] ==
                                                              1
                                                          ? Container()
                                                          : bidButton(
                                                              ontab: () {
                                                              
                                                                acceptOffer(
                                                                    context,
                                                                    ships.bids[
                                                                            index]
                                                                            [
                                                                            'id']
                                                                        .toString(),
                                                                    ships.bids[
                                                                            index]
                                                                            [
                                                                            'amount']
                                                                        .toString());
                                                              },
                                                              title: "Accept",
                                                              color: const Color(
                                                                  0xff00BC8B),
                                                            ),
                                                      ships.bids[index]
                                                                  ['agree'] ==
                                                              1
                                                          ? Container()
                                                          : bidButton(
                                                              width: 90.w,
                                                              ontab: () {
                                                             
                                                                counterOffer(
                                                                    context,
                                                                    ships.bids[
                                                                            index]
                                                                        ['id'],
                                                                    ships.bids[
                                                                            index]
                                                                        ['amount']);
                                                              },
                                                              title:
                                                                  "Counter Offer",
                                                              color: purplColor,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                ships.bids[index]['complete'] ==
                                                        0
                                                    ? Container()
                                                    : Row(
                                                        children: [
                                                          Text(
                                                              "Shipment Completed.\nProceed to Pay?",style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color:Colors.black),),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                               shipPayment(context, ships.bids[index]['id'],ships.bids[index]['co'] );
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          12.w,
                                                                      
                                                                      vertical:
                                                                          5.h),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green),
                                                                  child: Text(
                                                                      "Yes",style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color:Colors.white),))),
                                                          SizedBox(
                                                            width: 7.w,
                                                          ),
                                                          InkWell(
                                                              onTap: () {},
                                                              child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          12.w,
                                                                      vertical:
                                                                          5.h),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .orange),
                                                                  child: Text(
                                                                      "No",style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color:Colors.white),))),
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          ),
                                  ],
                                ));
                          }),
                    ),
                    _box.read(LocalStoreKey.userId) ==
                            snapshot.data!.data.userId
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bidButton(
                                ontab: () {
                                  Get.to(ShipSendPackgeEdit(path));
                                },
                                title: "Edit",
                                width: 80.w,
                                size: 13.sp,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              bidButton(
                                ontab: () {
                                  shipProController.shipCancle(
                                      slug: ships.slug);
                                },
                                title: "Cancel Trip",
                                width: 100.w,
                                size: 13.sp,
                                color: Colors.amber,
                              ),
                            ],
                          )
                        : Container(),
                    _box.read(LocalStoreKey.userId) ==
                            snapshot.data!.data!.userId
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
                                    makeOffer(context, ships.amount);
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
                                shipSendPackageDetails();
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
                              print(amount.text.toString());

                              print(shortmessage.text.toString());
                              var _isValid =
                                  _formOfferkey.currentState!.validate();
                              if (_isValid) {
                                shipProController.bidOnGivenShip(
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

  Future<dynamic> shipPayment(BuildContext context, bidsId, acceptAmount) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(
              child: Text("Select payment method",
                  style: TextStyle(
                    fontSize: 13.sp,
                  ))),
          content: Container(
              alignment: Alignment.center,
              height: 130.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Payable amount :$acceptAmount BDT",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500),
                        )),
                    Container(
                        child: Text(
                      "Select a payment method to pay the amount",
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.normal),
                    )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 90.w,
                            radius: 5.r,
                            marginLR: 5.w,
                            fontSize: 13.sp,
                            title: "By Cash",
                            btnColor: Colors.green,
                            onTab: () {
                              var bidId = bidsId;
                              shipCashPaymet(context, bidId);
                             
                            }),
                        SizedBox(
                          width: 20.w,
                        ),
                        CustomButtonOne(
                            height: 30.h,
                            width: 90.w,
                            radius: 5.r,
                            marginLR: 0.w,
                            fontSize: 13.sp,
                            title: "E-Pay",
                            btnColor: navyBlueColor,
                            onTab: () {})
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Future<dynamic> shipCashPaymet(BuildContext context, bidId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Make Payment?")),
          content: Container(
              alignment: Alignment.center,
              height: 85.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          "I give consent to this transaction.",
                          style: TextStyle(
                              fontSize: 11.sp, fontWeight: FontWeight.normal),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 70.w,
                            radius: 5.r,
                            marginLR: 10.w,
                            fontSize: 14.sp,
                            title: "No",
                            btnColor: Colors.red,
                            onTab: () {
                              Get.back();
                            }),
                        SizedBox(
                          width: 30.w,
                        ),
                        CustomButtonOne(
                            width: 70.w,
                            height: 30.h,
                            radius: 5.r,
                            marginLR: 0.w,
                            title: "Yes",
                            btnColor: navyBlueColor,
                            onTab: () {
                              shipProController.shipCashPayment(bidId: bidId);
                              Navigator.pop(context);
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Future<dynamic> agreeOffer(BuildContext context, shipId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Do you Agree?")),
          content: Container(
              alignment: Alignment.center,
              height: 85.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 70.w,
                            radius: 5.r,
                            marginLR: 10.w,
                            fontSize: 14.sp,
                            title: "No",
                            btnColor: Colors.red,
                            onTab: () {
                              Get.back();
                            }),
                        SizedBox(
                          width: 30.w,
                        ),
                        CustomButtonOne(
                            width: 70.w,
                            height: 30.h,
                            radius: 5.r,
                            marginLR: 0.w,
                            title: "Yes",
                            btnColor: navyBlueColor,
                            onTab: () {
                              shipProController.giveShipAgree(bidId: shipId);
                            
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Future<dynamic> counterOffer(BuildContext context, id, amt) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Sent Counter Offer")),
          content: Container(
            alignment: Alignment.center,
            height: 90.h,
            decoration: BoxDecoration(),
            child: Form(
                child: Column(
              children: [
                Container(
                  height: 40.h,
                  child: CustomForm(
                    textController: amount,
                    hinttext: "$amt",
                    radius: 10.r,
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
                        width: 70.w,
                        radius: 5.r,
                        marginLR: 10.w,
                        fontSize: 14.sp,
                        title: "No",
                        btnColor: Colors.red,
                        onTab: () {
                          Get.back();
                        }),
                    SizedBox(
                      width: 30.w,
                    ),
                    CustomButtonOne(
                        width: 70.w,
                        height: 30.h,
                        radius: 5.r,
                        marginLR: 0.w,
                        title: "Yes",
                        btnColor: navyBlueColor,
                        onTab: () {
                          shipProController.counterShipOffer(
                              bidId: id, amount: amt.toString());
                        })
                  ],
                )
              ],
            )),
          )),
    );
  }

  Future<dynamic> acceptOffer(BuildContext context, bidsId, acceptAmount) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Center(child: Text("Do you Want to Accept?")),
          content: Container(
              alignment: Alignment.center,
              height: 85.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Task Amount is :$acceptAmount ",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 70.w,
                            radius: 5.r,
                            marginLR: 10.w,
                            fontSize: 14.sp,
                            title: "No",
                            btnColor: Colors.red,
                            onTab: () {
                              Get.back();
                            }),
                        SizedBox(
                          width: 30.w,
                        ),
                        CustomButtonOne(
                            width: 70.w,
                            height: 30.h,
                            radius: 5.r,
                            marginLR: 0.w,
                            title: "Yes",
                            btnColor: navyBlueColor,
                            onTab: () {
                              shipProController.acceptShip(
                                  bidId: bidsId.toString());
                              setState(() {
                                Get.back();
                              });
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Future<dynamic> declineOffer(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: Text("Do you want to Decline?")),
        content: Container(
          alignment: Alignment.center,
          height: 85.h,
          decoration: BoxDecoration(),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonOne(
                      height: 30.h,
                      width: 70.w,
                      radius: 5.r,
                      marginLR: 10.w,
                      fontSize: 14.sp,
                      title: "No",
                      btnColor: Colors.red,
                      onTab: () {
                        Get.back();
                      }),
                  SizedBox(
                    width: 30.w,
                  ),
                  CustomButtonOne(
                      width: 70.w,
                      height: 30.h,
                      radius: 5.r,
                      marginLR: 0.w,
                      title: "Yes",
                      btnColor: navyBlueColor,
                      onTab: () {
                        shipProController.shipDisAgree(
                            bidId: ships.id.toString());
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> confirmShip(BuildContext context, bidsId) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
                alignment: Alignment.center,
                width: 200.w,
                height: 80.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm the Ship?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.sp),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonOne(
                            width: 70.w,
                            height: 30.h,
                            marginLR: 5.w,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            radius: 5.r,
                            btnColor: Color(0xff296557),
                            title: "Yes",
                            onTab: () {
                              // controller.confirmRide(
                              //     bidId: bidsId,
                              //     seat: trip.seatsAvailable.toString());
                            }),
                        CustomButtonOne(
                            width: 70.w,
                            height: 30.h,
                            marginLR: 5.w,
                            radius: 5.r,
                            btnColor: Colors.red,
                            title: "No",
                            onTab: () {
                              Get.back();
                            })
                      ],
                    ),
                  ],
                )),
          );
        });
  }


  Future<dynamic> cancelShip(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Do you Want to Cancle Ship?")),
          content: Container(
              alignment: Alignment.center,
              height: 85.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 70.w,
                            radius: 5.r,
                            marginLR: 10.w,
                            fontSize: 14.sp,
                            title: "No",
                            btnColor: Colors.red,
                            onTab: () {
                              Get.back();
                            }),
                        SizedBox(
                          width: 30.w,
                        ),
                        CustomButtonOne(
                            width: 70.w,
                            height: 30.h,
                            radius: 5.r,
                            marginLR: 0.w,
                            title: "Yes",
                            btnColor: navyBlueColor,
                            onTab: () {
                           shipProController.shipCancle(slug:ships.slug );
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Future<dynamic> finishShipment(BuildContext context,bidId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Want to finish this shipment?",style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),)),
          content: Container(
              alignment: Alignment.center,
              height: 75.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 70.w,
                            radius: 5.r,
                            marginLR: 10.w,
                            fontSize: 14.sp,
                            title: "No",
                            btnColor: Colors.red,
                            onTab: () {
                           setState(() {
                                Get.back();
                           });
                            }),
                        SizedBox(
                          width: 30.w,
                        ),
                        CustomButtonOne(
                            width: 70.w,
                            height: 30.h,
                            radius: 5.r,
                            marginLR: 0.w,
                            title: "Yes",
                            btnColor: navyBlueColor,
                            onTab: () {
                             shipProController.finishShip(bidId: bidId);
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
  FontWeight? fontWeight;
  late bool status = false;
  ShipDetailsWidget(
      {super.key,
      this.value,
      this.title,
      this.width,
      this.valueWidth,
      this.fontWeight,
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
                    fontWeight: fontWeight ?? FontWeight.w500,
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

class CustomForm extends StatelessWidget {
  TextEditingController? textController;
  double? radius;
  String? hinttext;

  CustomForm({super.key, this.hinttext, this.radius, this.textController});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hinttext ?? "Enter Data",
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 0.0.r)),
      ),
    );
  }
}
