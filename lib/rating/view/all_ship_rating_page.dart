import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/rating/controller/Rating_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AllShipRatingPage extends StatefulWidget {
  @override
  State<AllShipRatingPage> createState() => _AllShipRatingPageState();
}

class _AllShipRatingPageState extends State<AllShipRatingPage> {
  bool btnStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  btnStatus = false;

                  setState(() {
                    index = 0;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: btnStatus == false
                        ? Colors.deepPurple
                        : Colors.deepPurple.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Text(
                    "Send Ship Ratings",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  btnStatus = true;

                  setState(() {
                    index = 1;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: btnStatus == true
                        ? Colors.deepPurple
                        : Colors.deepPurple.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Text(
                    "Carry Ship Ratings",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: rating[index],
          ))
        ],
      ),
    );
  }

  int index = 0;
  List<Widget> rating = [
    SendShipRatingWidget(),
    CarryShipRatingWidget(),
  ];
}

class CarryShipRatingWidget extends StatelessWidget {
  var controller = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading2.value == false
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.shipRatingModel!.carryPackageRating!.length,
            itemBuilder: (context, index) {
              var rat = controller.shipRatingModel!.carryPackageRating![index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: rat.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // Do something with the rating (if needed)
                      },
                    ),
                    SizedBox(height: 8.0),
                    Text('Reviewer: ${rat.reviewer}'),
                    Text('Feedback: ${rat.feedbacks}'),
                    Text('Date: ${rat.date}'),
                  ],
                ),
              );
            })
        : Center(child: CircularProgressIndicator()));
  }
}

class SendShipRatingWidget extends StatelessWidget {
  var controller = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading2.value == false
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.shipRatingModel!.sendPackageRating!.length,
            itemBuilder: (context, index) {
              var rat = controller.shipRatingModel!.sendPackageRating![index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: rat.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // Do something with the rating (if needed)
                      },
                    ),
                    SizedBox(height: 8.0),
                    Text('Reviewer: ${rat.reviewer}'),
                    Text('Feedback: ${rat.feedbacks}'),
                    Text('Date: ${rat.date}'),
                  ],
                ),
              );
            })
        : Center(child: CircularProgressIndicator()));
  }
}
