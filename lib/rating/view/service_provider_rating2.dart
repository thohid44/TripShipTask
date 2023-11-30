import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/rating/view/star_rating_service_receiver_32.dart';

class ServiceProviderRatig2 extends StatefulWidget {
  const ServiceProviderRatig2({super.key});

  @override
  State<ServiceProviderRatig2> createState() => _ServiceProviderRatig2State();
}

class _ServiceProviderRatig2State extends State<ServiceProviderRatig2> {
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
        body: Center(
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
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  width: 160.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Cathy Ferguson",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "service Receiver",
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
                                width: 60.w,
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "148.57",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
                              decoration: BoxDecoration(color: Colors.white),
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
                                        horizontal: 25.w, vertical: 15.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.r),
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
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
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
                                                convertValue = value.toInt();
                                                print(convertValue);
                                                experienceList[convertValue];
                                              });
                                            },
                                            starBuilder: (index, color) => Icon(
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
                                                const EdgeInsets.only(right: 8),
                                            starOffColor:
                                                const Color(0xffe7e8ea),
                                            starColor: Colors.yellow,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          child: Text(
                                            "${experienceList[convertValue]}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
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
                                  backgroundImage: AssetImage("assets/man.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
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
                          margin: EdgeInsets.only(bottom: 20.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 120.w,
                                child: Column(
                                  children: [
                                    customLikeWidget(
                                      title: "Professionalism",
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    customLikeWidget(
                                      title: "Responsibility",
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.w,
                                child: Column(
                                  children: [
                                    customLikeWidget(
                                      title: "Behaviour",
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    customLikeWidget(
                                      title: "Cleanliness",
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    StarRating32(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: navyBlueColor,
                      borderRadius: BorderRadius.circular(10.r)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                  child: Text(
                    "Next",
                    style: TextStyle(color: white, fontSize: 14.sp),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class customLikeWidget extends StatefulWidget {
  late String title;
  customLikeWidget({super.key, required this.title});

  @override
  State<customLikeWidget> createState() => _customLikeWidgetState();
}

class _customLikeWidgetState extends State<customLikeWidget> {
  bool yesBtn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 30.h,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: yesBtn == false ? Colors.white : Colors.green),
      child: InkWell(
        onTap: () {
          setState(() {
            yesBtn = true;
          });
        },
        child: Text(
          "${widget.title}",
          style: TextStyle(
            fontSize: 14.sp,
            color: yesBtn == false ? Colors.black : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
