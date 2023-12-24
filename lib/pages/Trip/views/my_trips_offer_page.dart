import 'dart:convert';

import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/model/my_trips_offer_model.dart';
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_details_page.dart';
import 'package:tripshiptask/pages/Trip/views/trip_offer_negotiate_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';

import 'package:tripshiptask/pages/Ship/views/shipPage.dart';

import 'package:intl/intl.dart';
import 'package:tripshiptask/rating/view/trip_bidder_rating.dart';

import '../../Home/trip_ship_task_home.dart';
import 'package:http/http.dart' as http;
class MyTripsOfferPage extends StatefulWidget {
  const MyTripsOfferPage({super.key});

  @override
  State<MyTripsOfferPage> createState() => _MyTripsOfferPageState();
}

class _MyTripsOfferPageState extends State<MyTripsOfferPage> {
final _box = GetStorage(); 
   getMyTripsOffer() async {
    var token = _box.read(LocalStoreKey.token);

    try {
     
      var response = await http.get(
        Uri.parse("${baseUrl}my-trip-offers"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        
        return MyTripsOfferModel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error $e");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TripController());
  
    return Scaffold(
      appBar: customAppBar(),
      body: FutureBuilder(
          future:  getMyTripsOffer() ,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index) {
                    var tripOfferData = snapshot.data.data[index];

                    return Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  "Start: ",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                Expanded(
                                  child: Text(
                                    "${tripOfferData.tripStartPoint}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  "Destination: ",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                                Expanded(
                                  child: Text(
                                    "${tripOfferData.tripDestination}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              children: [
                                CustomText("Offered by : ", Colors.black,
                                    FontWeight.bold, 12.sp),
                                CustomText("M/30/Masters/PrivateJob ",
                                    Colors.black, FontWeight.normal, 12.sp),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.getTripPostDetails(
                                          tripOfferData.path.toString());

                                      controller.path1.value =
                                          tripOfferData.path.toString();
                                      Get.to(
                                          TripDetailsPage(
                                            tripOfferData.path.toString(),
                                          ),
                                          duration: Duration(
                                              milliseconds:
                                                  200), //duration of transitions, default 1 sec
                                          transition: Transition.leftToRight);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 25.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          color: navyBlueColor,
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
                                      child: CustomText("Details", Colors.white,
                                          FontWeight.bold, 12.sp),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          TripBidderRating(
                                            path: tripOfferData.path,
                                          ),
                                          duration: Duration(
                                              milliseconds:
                                                  200), //duration of transitions, default 1 sec
                                          transition: Transition.leftToRight);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 25.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                          color: navyBlueColor,
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
                                      child: CustomText("Review", Colors.white,
                                          FontWeight.bold, 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const Center(
                child: CircularProgressIndicator(
              color: navyBlueColor,
            ));
          }),
    );
  }
}
