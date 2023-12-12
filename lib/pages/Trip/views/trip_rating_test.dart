import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';

import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';

import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/custom_text_field.dart';
import 'package:tripshiptask/Widget/widget_button.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';

import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/Controller/trip_rating.dart';
import 'package:tripshiptask/pages/Trip/model/trip_post_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_give_post_edit.dart';

class TripRatingTestPage extends StatefulWidget {
  String path;
  TripRatingTestPage(this.path);

  @override
  State<TripRatingTestPage> createState() => _TripRatingTestPageState();
}

class _TripRatingTestPageState extends State<TripRatingTestPage> {
  final _box = GetStorage();

  TripPostDetailsModel? tripPostDetailsModel;
  var controller = Get.put(TripController());
  final _formOfferkey = GlobalKey<FormState>();
  final TextEditingController shortmessage = TextEditingController();
  final TextEditingController amount = TextEditingController();

  var tripId;
  var seatValue;
  bool seatStatus = false;
  var seat;
 
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
  void initState() {
    // getTripPostDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(),

        // appBar: AppBar(
        //   title: Text("Trip Details "),
        // ),
        body: FutureBuilder(
            future: getTripPostDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                trip = snapshot.data!.tripDetailsModel!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 550.h,
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              TripDetailsWidget(
                                status: false,
                                title: "Title",
                                value: snapshot.data!.tripDetailsModel!.title
                                    .toString(),
                              ),
                              TripDetailsWidget(
                                status: false,
                                title: "Posted By",
                                value: trip.user,
                              ),
                              TripDetailsWidget(
                                status: false,
                                title: "Posted User Id",
                                value: "${_box.read(LocalStoreKey.userId)}",
                              ),
                              TripDetailsWidget(
                                status: false,
                                title: "Trip  Id",
                                value: trip.id.toString(),
                              ),
                              TripDetailsWidget(
                                status: false,
                                title: "Poster Id",
                                value: trip.userId.toString(),
                              ),
                              Container(
                                height: 300.h,
                                child: ListView.builder(
                                    itemCount: trip.bids.length,
                                    itemBuilder: (context, index) {
     bidderId= trip.bids[index]['user_id'];

     bidId= trip.bids[index]['id'];



                                      print("index  $index");
                                      return Card(
                                        elevation: 5,
                                        color: Colors.grey,
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TripDetailsWidget(
                                                    
                                                      status: false,
                                                      title: "Bid Id",
                                                      value: trip.bids[index]
                                                              ['id']
                                                          .toString()),
                                     TripDetailsWidget(
                                                    
                                                      status: false,
                                                      title: "Bider Id",
                                                      value: trip.bids[index]
                                                              ['user_id']
                                                          .toString()),
                                                         
                                       TripDetailsWidget(
                                                    
                                                      status: false,
                                                      title: "Bider Name",
                                                      value: trip.bids[index]
                                                              ['bidder_name']
                                                          .toString()),
                                            
                                              SizedBox(
                                                height: 5.h,
                                              ),

                                              // Own unser Part Start
                                              trip.userId ==
                                                      _box.read(
                                                          LocalStoreKey.userId)
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child:const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                      
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )),
                       ElevatedButton(onPressed: (){

    var posterId= trip.userId.toString();
    var tripId=  trip.id.toString();
   
    var rating= "3.5";
   ratingController.tripGiverFeedback(bidderId:bidderId , bidId:posterId , tripId:tripId , rating:rating , review:"3" );


                          }, child: Text("Give Review"))
   
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }



  Future<dynamic> counterOffer(BuildContext context, id) {
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
                      hinttext: "amount",
                      radius: 10.r,
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
                          controller.counterTripOffer(
                              bidId: id, amount: amount.text.toString());
                          Get.back();
                        })
                  ],
                )
              ],
            )),
          )),
    );
  }




  bool selectPassengerStatus = false;

  bool isSelect = false;

  var seatNumber;

  String? selectPassenger;
}

class bidButton extends StatelessWidget {
  var height;
  var width;
  var title;
  VoidCallback? ontab;
  Color? color;
  var size;
  bidButton(
      {super.key,
      this.height,
      this.width,
      this.title,
      this.color,
      this.size,
      this.ontab});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontab,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 30.h,
        width: width ?? 60.w,
        decoration: BoxDecoration(
            color: color ?? const Color(0xff7a15f7),
            borderRadius: BorderRadius.circular(5.r)),
        child: Text(
          "$title",
          style: TextStyle(
              color: Colors.white,
              fontSize: size ?? 12.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class TripDetailsWidget extends StatelessWidget {
  String? title;
  String? value;
  late bool status = false;
  TripDetailsWidget({super.key, this.value, this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100.w,
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: CustomText("$title :", Colors.black, FontWeight.w500, 14.sp),
        ),
        status == false
            ? Container(
                width: 180.w,
                child: CustomText(
                    " ${value}", Colors.black, FontWeight.w500, 13.sp),
              )
            : Container(
                width: 180.w,
                child: CustomText(" ${value == "0" ? "NO" : "Yes"}",
                    Colors.black, FontWeight.normal, 13.sp),
              ),
      ],
    );
  }
}
