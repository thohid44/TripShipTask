import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/rating/view/star_rating_service_receiver_32.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RatingPage30 extends StatelessWidget {
  const RatingPage30({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Rating",
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          elevation: 0.h,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2,
              ),
              Container(
                width: 306.w,
                height: 530.h,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    RatingItemWidget(
                        title:
                            " Did the service receiver wear a mask & maintain safe distance?",
                        imgLink: "assets/man.png"),
                        SizedBox(height: 5.h,), 
                    RatingItemWidget(
                        title:
                            " Was the service receiver willind to give Digital payment?",
                        imgLink: "assets/man.png"),
                           SizedBox(height: 5.h,), 
                    RatingItemWidget(
                        title:
                            " Was the service receiver courteous and pleasant?",
                        imgLink: "assets/man.png"),
                  ],
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
        ),
      ),
    );
  }
}

class RatingItemWidget extends StatefulWidget {
  String title;
  String imgLink;
  RatingItemWidget({required this.title, required this.imgLink});

  @override
  State<RatingItemWidget> createState() => _RatingItemWidgetState();
}

class _RatingItemWidgetState extends State<RatingItemWidget> {
  bool yesBtn = false;

  bool NoBtn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        top: 20.h,
      ),
      height: 130.h,
   
      decoration: BoxDecoration(
        color:primaryColor,
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
      child: Row(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              backgroundColor: lightNavyColor,
              radius: 25.r,
              backgroundImage: AssetImage("assets/man.png"),
            ),
          ),
          SizedBox(
            width: 15.h,
          ),
          Container(
            width: 200.w,
            child: Column(
              children: [
                Container(
                  child: Text(
                    "${widget.title}",
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          yesBtn = true;
                          NoBtn = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: yesBtn == false ? white : Colors.green,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              color: yesBtn == true ? white : Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          yesBtn = false;
                          NoBtn = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: NoBtn == false ? white : Colors.red,
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Text('No',
                            style: TextStyle(
                                color: NoBtn == true ? white : Colors.grey,
                                fontWeight: FontWeight.normal)),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
