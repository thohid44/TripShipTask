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
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/Controller/trip_rating.dart';
import 'package:tripshiptask/pages/Trip/model/trip_post_details_model.dart';
import 'package:tripshiptask/rating/view/star_rating_service_receiver_32.dart';
import 'package:http/http.dart' as http;

class TripBidderRating extends StatefulWidget {
  String path;
  TripBidderRating({required this.path});

  @override
  State<TripBidderRating> createState() => _TripBidderRatingState();
}

class _TripBidderRatingState extends State<TripBidderRating> {
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
  var controller = Get.put(TripController());
  final _formOfferkey = GlobalKey<FormState>();
  final TextEditingController shortmessage = TextEditingController();
  final TextEditingController amount = TextEditingController();

  bool seatStatus = false;
  var seat;
  bool statusButton = false;
  var ratingController = Get.put(TripRatingController());
  var details;
  bool isLoading = false;
  Future<TripPostDetailsModel> getTripPostDetails() async {
    var token = _box.read(LocalStoreKey.token);

    isLoading = true;
    var response = await http.get(
      Uri.parse("${urlWithOutslash}${widget.path}"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(" trip detail ${jsonData}");
    }
    return tripPostDetailsModel = TripPostDetailsModel.fromJson(jsonData);
  }

  bool status = false;
  var trip;
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
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          elevation: 0.h,
        ),
        body: FutureBuilder(
            future: getTripPostDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                trip = snapshot.data!.tripDetailsModel!;
                bidId = trip.id;
                print("Koli $bidId");
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity.w,
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                      margin: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: lightNavyColor.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
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
                          SizedBox(
                            height: 60.h,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 90.h,
                                width: 280.w,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 20.h,
                                      ),
                                      margin: EdgeInsets.only(top: 20.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: [
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
                                                fontSize: 15.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
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
                                                });
                                              },
                                              starBuilder: (index, color) =>
                                                  Icon(
                                                Icons.star,
                                                color: color,
                                                size: 30,
                                              ),
                                              starCount: 5,
                                              starSize: 20,
                                              maxValue: 5,
                                              starSpacing: 4,
                                              valueLabelVisibility: false,
                                              animationDuration:
                                                  Duration(milliseconds: 1000),
                                              valueLabelMargin:
                                                  const EdgeInsets.only(
                                                      right: 8),
                                              starOffColor:
                                                  const Color(0xffe7e8ea),
                                              starColor: Colors.yellow,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
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
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  width: 150.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: const Text(
                                          "Johan Ferguson",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: const Text(
                                          "service Provider",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "15 Jan 2023, 01:53 PM",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                width: 75.w,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "148.57",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        ratingController.biderGiveRating(
                            bidId: bidId,
                            rating: convertValue.toString(),
                            review: reviews);
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
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
