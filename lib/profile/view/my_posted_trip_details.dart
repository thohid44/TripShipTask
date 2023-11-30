import 'dart:async';
import 'dart:convert';

import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/custom_text_field.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/model/trip_post_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MyPostedTripDetails extends StatefulWidget {
  String path;
  MyPostedTripDetails(this.path);

  @override
  State<MyPostedTripDetails> createState() => _MyPostedTripDetailsState();
}

class _MyPostedTripDetailsState extends State<MyPostedTripDetails> {
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
  var bidId;
  getTripPostDetails() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      var response = await http.get(
        Uri.parse("${urlWithOutslash}${widget.path}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("detail ${jsonData}");
        tripPostDetailsModel = TripPostDetailsModel.fromJson(jsonData);
        return TripPostDetailsModel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  bool status = false;
  void initState() {
    getTripPostDetails();
    Timer(Duration(seconds: 2), () {
      setState(() {
        status = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(status);
    print("path ${widget.path}");

    return Scaffold(
        appBar: AppBar(),
        body: status == true
            ? FutureBuilder(
                future: getTripPostDetails(),
                builder: (context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  var details = tripPostDetailsModel!.tripDetailsModel!;
                  bidId = details.bids![0].id;
                  print("dtails $details");

                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      children: [
                        TripDetailsWidget(
                            title: "Title",
                            value:
                                tripPostDetailsModel!.tripDetailsModel!.title),
                        TripDetailsWidget(
                            title: "Start Point", value: details.startPoint),

                        // TripDetailsWidget(
                        //     title: "Bid Id",
                        //     value: details.bids![0].amount.toString()),
                        // TripDetailsWidget(
                        //     title: "Bid Id", value: details.bids![0].co.toString()),
                        details.bids!.isNotEmpty
                            ? TripDetailsWidget(
                                title: "Destination",
                                value: details.destination)
                            : Container(),
                        details.bids!.isNotEmpty
                            ? TripDetailsWidget(
                                title: "Passenger",
                                value: details.bids![0].passenger.toString())
                            : Container(),
                        details.bids!.isNotEmpty
                            ? TripDetailsWidget(
                                title: "Pay", value: details.pay)
                            : Container(),
                        details.bids!.isNotEmpty
                            ? TripDetailsWidget(
                                title: "Bid Amount",
                                value: details.bids![0].amount.toString())
                            : Container(),
                        details.bids!.isNotEmpty
                            ? TripDetailsWidget(
                                title: "Agree",
                                value: details.bids![0].agree.toString())
                            : Container(),

                        details.bids!.isNotEmpty
                            ? TripDetailsWidget(
                                title: "Accept", value: "Offer Accepted")
                            : Container(),

                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            details.bids![0].accepted == 0
                                ? ElevatedButton(
                                    onPressed: () {
                                      openModel();
                                    },
                                    child: Text("Counter Offer"))
                                : Container(),
                            details.bids![0].accepted == 0
                                ? ElevatedButton(
                                    onPressed: () {
                                      var bidId =
                                          details.bids![0].id.toString();
                                      var seat = details.seatsAvailable;
                                      print(seat);
                                      var passenger =
                                          details.bids![0].passenger;
                                      var sum = int.parse(seat!) + passenger;
                                      print(sum);
                                      print(passenger);
                                      print(bidId);
                                      controller.acceptTrip(
                                          bidId: bidId, sum: sum);
                                    },
                                    child: Text("Accept"))
                                : ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Offer Accepted")),
                          ],
                        )
                      ],
                    ),
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }

  openModel() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Counter Offers"),
        content: Container(
          height: 80.h,
          decoration: BoxDecoration(),
          child: Form(
            key: _formOfferkey,
            child: Column(
              children: [
                Container(
                    child: TextFormField(
                  controller: amount,
                  decoration: InputDecoration(
                      hintText: "write your counter amount",
                      border: OutlineInputBorder()),
                )),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    print(amount.text.toString());
                    print("Bid Id $bidId");

                    controller.counterTripOffer();
                  }),
            ],
          )
        ],
      ),
    );
  }
}

class TripDetailsWidget extends StatelessWidget {
  String? title;
  String? value;
  TripDetailsWidget({super.key, this.value, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5.h),
          width: 100.w,
          child: CustomText("$title :", Colors.black, FontWeight.w600, 14.sp),
        ),
        Container(
          width: 220.w,
          child: CustomText(" ${value}", Colors.black, FontWeight.w500, 13.sp),
        ),
      ],
    );
  }
}
