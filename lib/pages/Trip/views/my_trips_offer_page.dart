import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/views/trip_offer_negotiate_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';

import 'package:tripshiptask/pages/Ship/views/shipPage.dart';

import 'package:intl/intl.dart';

import '../../Home/trip_ship_task_home.dart';

class MyTripsOfferPage extends StatelessWidget {
  const MyTripsOfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TripController());
    return Scaffold(
      appBar: customAppBar(),
      body: FutureBuilder(
          future: controller.getMyTripsOffer(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index) {
                    var tripOfferData = snapshot.data.data[index];

                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: Container(
                                height: 200.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Start : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${tripOfferData.tripStartPoint}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500))
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Destination: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${tripOfferData.tripDestination}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500))
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Date: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${DateFormat.yMMMd().format(DateTime.parse(tripOfferData.tripDate.toString()))}",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500))
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Sent Offer: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${tripOfferData.amount}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Negotiate Offer:  ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${tripOfferData.co == null ? 'Not yet' : tripOfferData.co}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.normal))
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          tripOfferData.accepted == '0'
                                              ? Container(
                                                  child: Text("Accepted",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600)))
                                              : Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5.h),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          "path ${tripOfferData.path}");
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                TripOfferNegotiatePage(
                                                                    tripOfferData
                                                                        .path
                                                                        .toString()),
                                                          ));

                                                      //     showDialog(
                                                      //   context: context,
                                                      //   builder: (BuildContext context) =>
                                                      //       AlertDialog(
                                                      //           title: Text("Make Offers"),
                                                      //           content: Container(
                                                      //               height: 300.h,
                                                      //               decoration:
                                                      //                   BoxDecoration(),
                                                      //               child: Form(

                                                      //                 child: Column(
                                                      //                   children: [
                                                      //                     Container(
                                                      //                       child:
                                                      //                           CustomTextField(
                                                      //                         onChange:
                                                      //                             (amount) {
                                                      //                           amount =
                                                      //                               amount;
                                                      //                         },
                                                      //                         txt: "Amount",
                                                      //                       ),
                                                      //                     ),

                                                      //                     SizedBox(
                                                      //                       height: 20.h,
                                                      //                     ),

                                                      //                     CustomButtonOne(
                                                      //                         title: "Submit",
                                                      //                         btnColor:
                                                      //                             navyBlueColor,
                                                      //                         onTab: () {

                                                      //                      //     print(amount);

                                                      //                     //  controller.bidOnTrip(amount, );

                                                      //                         })
                                                      //                   ],
                                                      //                 ),
                                                      //               ))),
                                                      // );
                                                    },
                                                    child: Text(
                                                      "Details",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))));
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
