import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/pages/Ship/controller/shipController.dart';
import 'package:tripshiptask/pages/Ship/controller/ship_rating_controller.dart';
import 'package:tripshiptask/pages/Ship/model/sh_Snd_Package_Details_M.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/Controller/trip_rating.dart';
import 'package:tripshiptask/pages/Trip/model/trip_post_details_model.dart';
import 'package:http/http.dart' as http;

class ShipGiverFeedBackRating extends StatefulWidget {
  String path;
  ShipGiverFeedBackRating({super.key, required this.path});

  @override
  State<ShipGiverFeedBackRating> createState() =>
      _ShipGiverFeedBackRatingState();
}

class _ShipGiverFeedBackRatingState extends State<ShipGiverFeedBackRating> {
  var value = 1.0;
  var convertValue = 1;
  List<String> experienceList = [
    '',
    "Poor",
    "Somewhat Okay",
    "Good",
    "Very Good",
    "Great!"
  ];
  final _box = GetStorage();

  TripPostDetailsModel? tripPostDetailsModel;

  final _formOfferkey = GlobalKey<FormState>();

  var ratingController = Get.put(ShipRatingController());

  var controller = Get.put(ShipController());

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

  bool status = false;
  var ship;
  var bidderId;

  var bidId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          title: Text(
            "Rating",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          elevation: 0.h,
        ),
        body: FutureBuilder(
            future: shipSendPackageDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ship = snapshot.data!.data!;

                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15.w,
                          right: 15.w,
                        ),
                        child: Card(
                          color: Color(0xffF2F2F2),
                          elevation: 5,
                          child: Container(
                            width: 300.w,
                            child: Column(
                              children: [
                                Container(
                                  height: 140.h,
                                  child: ListView.builder(
                                      itemCount: ship.bids.length,
                                      itemBuilder: (context, index) {
                                        bidderId = ship.bids[index]['user_id'];

                                        bidId = ship.bids[index]['id'];

                                        return Container(
                                          padding: EdgeInsets.only(
                                              left: 20.w,
                                              right: 20.w,
                                              top: 20.h,
                                              bottom: 20.h),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.r)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  alignment: Alignment.topLeft,
                                                  width: 160.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "${ship.bids[index]['bidder_name'].toString()}",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "service Receiver",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12.sp),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          " ${DateFormat.yMMMd().format(DateTime.parse(ship.deliveryDate.toString()))},",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Container(
                                                width: 60.w,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "${ship.bids[index]['amount'].toString()}.TK",
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 140.h,
                                      width: 280.w,
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                              left: 20.w,
                                              right: 20.w,
                                              top: 20.h,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 25.w,
                                                vertical: 15.h),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.white,
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "How was the experience?",
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: RatingStars(
                                                    value: value,
                                                    onValueChanged: (v) {
                                                      //
                                                      setState(() {
                                                        value = v;
                                                        convertValue =
                                                            value.toInt();
                                                        print(convertValue);
                                                        experienceList[
                                                            convertValue];
                                                      });
                                                    },
                                                    starBuilder:
                                                        (index, color) => Icon(
                                                      Icons.star,
                                                      color: color,
                                                      size: 30,
                                                    ),
                                                    starCount: 5,
                                                    starSize: 20,
                                                    maxValue: 5,
                                                    starSpacing: 4,
                                                    valueLabelVisibility: false,
                                                    animationDuration: Duration(
                                                        milliseconds: 1000),
                                                    valueLabelMargin:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    starOffColor:
                                                        const Color(0xffe7e8ea),
                                                    starColor: Colors.yellow,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Container(
                                                  child: Text(
                                                    "${experienceList[convertValue]}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 100,
                                      right: 100,
                                      top: -30,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: CircleAvatar(
                                          radius: 30.r,
                                          backgroundImage:
                                              AssetImage("assets/man.png"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  child: Text(
                                    "What did you like?",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: 15.h),
                                    height: 130.h,
                                    child: ListView.builder(
                                      itemCount: (items.length / 2).ceil(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              buildItemTile(index * 2),
                                              SizedBox(width: 5.w),
                                              buildItemTile(index * 2 + 1),
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InkWell(
                        onTap: () {
                          var shipperId = ship.userId.toString();
                          var shipId = ship.id.toString();

                          ratingController.shipGiverFeedback(
                              bidderId: bidderId,
                              shipperId: shipperId,
                              bidId: bidId,
                              shipId: shipId,
                              rating: convertValue.toString(),
                              reviews: reviews);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: navyBlueColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.w, vertical: 10.h),
                          child: Text(
                            "Submit",
                            style: TextStyle(color: white, fontSize: 14.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget buildItemTile(int itemIndex) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            toggleSelection(items[itemIndex]);
          });
        },
        child: Container(
          height: 30.h,
          decoration: BoxDecoration(
            color:
                reviews.contains(items[itemIndex]) ? greenColor : Colors.white,
            borderRadius: BorderRadius.circular(5.r),
          ),
          padding: EdgeInsets.all(5.r),
          child: Center(
            child: Text(
              items[itemIndex],
              style: TextStyle(
                color: reviews.contains(items[itemIndex])
                    ? Colors.white
                    : Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> reviews = [];

  final List<String> items = [
    'Professionalism',
    'Behavior',
    'Punctuality',
    'Vehicle Quality',
    'Navigation',
    'Cleanliness',
  ];
  void toggleSelection(String item) {
    if (reviews.contains(item)) {
      reviews.remove(item);
      print("Remove $reviews");
    } else {
      reviews.add(item);
      print(reviews);
    }
  }
}
