import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/rating/view/rating_page_30.dart';
import 'package:tripshiptask/rating/view/service_provider_rating.dart';
import 'package:tripshiptask/rating/view/trip_giver_feedback_rating.dart';
import 'package:tripshiptask/rating/view/star_rating_service_receiver_32.dart';

class PageList extends StatefulWidget {
  const PageList({super.key});

  @override
  State<PageList> createState() => _PageListState();
}

class _PageListState extends State<PageList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            tileColor: Colors.teal,
            
            onTap: () {
              Get.to(ServiceProviderRatig());
            },
            title: Text("Page 1"),
          ),
          SizedBox(height: 10.h,), 
          ListTile(
            tileColor: Colors.teal,
            
            onTap: () {
              Get.to(TripGiverFeedBackRating(path: '',));
            },
            title: Text("ServiceProviderRatig2 "),
          ),
SizedBox(height: 10.h,), 

           ListTile(
            tileColor: Colors.teal,
            
            onTap: () {
              Get.to(StarRating32());
            },
            title: Text("ServiceProviderRatig2 "),
          ),
SizedBox(height: 10.h,), 

             ListTile(
            tileColor: Colors.teal,
            
            onTap: () {
              Get.to(RatingPage30());
            },
            title: Text("RatingPage30 "),
          ),
        ],
      ),
    );
  }
}
