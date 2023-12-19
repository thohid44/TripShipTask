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
import 'package:tripshiptask/pages/Trip/model/trip_post_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_give_post_edit.dart';

class TripDetailsPage extends StatefulWidget {
  String path;
  TripDetailsPage(this.path);

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
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
  List<DropdownMenuItem<String>> get dropdownItem {
    List<DropdownMenuItem<String>> seatMember = [
      const DropdownMenuItem(child: Text("1"), value: "1"),
      const DropdownMenuItem(child: Text("2"), value: "2"),
      const DropdownMenuItem(child: Text("3"), value: "3"),
    ];
    return seatMember;
  }

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
  void initState() {
    // getTripPostDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(),

     
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
                                title: "Willing Pay",
                                value: trip.pay.toString(),
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
                                      print("index  $index");
                                      return Card(
                                        elevation: 5,
                                        color: Colors.grey,
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${trip.bids[index]['user_id']}'),
                                              //  Text(
                                              //       '${trip.bids[index]['co'].toString()}'),
                                              trip.bids.isNotEmpty
                                                  ? TripDetailsWidget(
                                                      status: false,
                                                      title: "Bider Name",
                                                      value: trip.bids[index]
                                                              ['bidder_name']
                                                          .toString())
                                                  : Container(),
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
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          trip.bids[index][
                                                                      'agree'] ==
                                                                  1
                                                              ? Container()
                                                              : Text(
                                                                  "Counter Offer",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          13.sp),
                                                                ),
                                                          trip.bids[index][
                                                                      'agree'] ==
                                                                  1
                                                              ? Container()
                                                              : Text(
                                                                  "${trip.bids[index]['amount'].toString()}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          13.sp)),
                                                          trip.bids[index][
                                                                      'agree'] ==
                                                                  1
                                                              ? Container()
                                                              : bidButton(
                                                                  ontab: () {
                                                                    acceptOffer(
                                                                        context,
                                                                        trip.bids[index]['id']
                                                                            .toString(),
                                                                        trip.bids[index]['amount']
                                                                            .toString());
                                                                  },
                                                                  title:
                                                                      "Accept",
                                                                  color: const Color(
                                                                      0xff00BC8B),
                                                                ),
                                                          trip.bids[index][
                                                                      'agree'] ==
                                                                  1
                                                              ? Container()
                                                              : bidButton(
                                                                  ontab: () {
                                                                    counterOffer(
                                                                        context,
                                                                        trip.bids[index]
                                                                            [
                                                                            'id']);
                                                                  },
                                                                  title:
                                                                      "Again Bid",
                                                                  color:
                                                                      purplColor,
                                                                )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),

                                              trip.userId ==
                                                      _box.read(
                                                          LocalStoreKey.userId)
                                                  ? Container()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        trip.bids[index][
                                                                    'amount'] !=
                                                                0
                                                            ? Container()
                                                            : UnconstrainedBox(
                                                                child:
                                                                    bidButton(
                                                                title: "Accept",
                                                              )),
                                                        trip.bids[index][
                                                                    'amount'] !=
                                                                0
                                                            ? Container()
                                                            : UnconstrainedBox(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    makeOffer(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      bidButton(),
                                                                ),
                                                              )
                                                      ],
                                                    ),

                                              trip.userId ==
                                                      _box.read(
                                                          LocalStoreKey.userId)
                                                  ? Container()
                                                  : Row(
                                                      children: [
                                                        trip.bids.isNotEmpty
                                                            ? TripDetailsWidget(
                                                                status: false,
                                                                title:
                                                                    "Counter Offer",
                                                                value: trip
                                                                    .bids[index]
                                                                        [
                                                                        'amount']
                                                                    .toString())
                                                            : Container(),
                                                      ],
                                                    ),

                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              trip.bids[index]['co'] == 0
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          trip.userId ==
                                                                  _box.read(
                                                                      LocalStoreKey
                                                                          .userId)
                                                              ? WidgetButton(
                                                                  title:
                                                                      "Counter Offer Sent: ${trip.bids[index]['co'].toString()} BDT",
                                                                )
                                                              : Container(
                                                                  child: Text(
                                                                    "Counter Offer Received: ${trip.bids[index]['co'].toString()} BDT",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                          trip.userId ==
                                                                  _box.read(
                                                                      LocalStoreKey
                                                                          .userId)
                                                              ? bidButton(
                                                                  ontab: () {
                                                                    agreeOffer(
                                                                        context);
                                                                  },
                                                                  title:
                                                                      "Agree",
                                                                  width: 60.w,
                                                                  color: Color(
                                                                      0xff00BC8B),
                                                                )
                                                              : bidButton(
                                                                  title:
                                                                      "Pending",
                                                                  color: Colors
                                                                      .yellow,
                                                                ),
                                                          trip.userId ==
                                                                  _box.read(
                                                                      LocalStoreKey
                                                                          .userId)
                                                              ? bidButton(
                                                                  ontab: () {
                                                                    declineOffer(
                                                                        context);
                                                                  },
                                                                  title:
                                                                      "Decline",
                                                                  color: Colors
                                                                      .red,
                                                                )
                                                              : bidButton(
                                                                  ontab: () {
                                                                    acceptOffer(
                                                                        context,
                                                                        trip.bids[index]['id']
                                                                            .toString(),
                                                                        trip.bids[index]['amount']
                                                                            .toString());
                                                                  },
                                                                  title:
                                                                      "Accept",
                                                                  color: Color(
                                                                      0xff00BC8B),
                                                                )
                                                        ],
                                                      ),
                                                    ),

                                              trip.bids[index]['agree'] == 1
                                                  ? TripDetailsWidget(
                                                      status: false,
                                                      title: "Status",
                                                      value: "Accepted")
                                                  : Container(),

                                              SizedBox(
                                                height: 5.h,
                                              ),

                                              trip.bids[index]['accepted'] == 0
                                                  ? Container()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10.w),
                                                          child: Text(
                                                            "Confirm the Ride? ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        CustomButtonOne(
                                                            width: 70.w,
                                                            height: 30.h,
                                                            marginLR: 5.w,
                                                            radius: 5.r,
                                                            btnColor:
                                                                const Color(
                                                                    0xff039be5),
                                                            title: "Yes",
                                                            onTab: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      content: Container(
                                                                          alignment: Alignment.center,
                                                                          width: 200.w,
                                                                          height: 80.h,
                                                                          child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                'Confirm the Ride?',
                                                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                                                                              ),
                                                                              SizedBox(height: 10.h),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  CustomButtonOne(width: 70.w, height: 30.h, marginLR: 5.w, fontSize: 15.sp, fontWeight: FontWeight.w700, radius: 5.r, btnColor: Color(0xff296557), title: "Yes", onTab: () {}),
                                                                                  CustomButtonOne(
                                                                                      width: 70.w,
                                                                                      height: 30.h,
                                                                                      marginLR: 5.w,
                                                                                      radius: 5.r,
                                                                                      btnColor: Colors.red,
                                                                                      title: "No",
                                                                                      onTab: () {
                                                                                        Get.back();
                                                                                      })
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    );
                                                                  });
                                                            }),
                                                        CustomButtonOne(
                                                            width: 70.w,
                                                            height: 30.h,
                                                            marginLR: 5.w,
                                                            radius: 5.r,
                                                            btnColor: Colors
                                                                .redAccent,
                                                            title: "No",
                                                            onTab: () {})
                                                      ],
                                                    ),

                                              trip.bids[index]['agree'] == 1
                                                  ? Container()
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              trip.bids.length != 0
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        trip.userId ==
                                                _box.read(LocalStoreKey.userId)
                                            ? Container()
                                            : bidButton(
                                                width: 80.w,
                                                color: greenColor,
                                                ontab: () {
                                                  acceptOffer(context, trip.pay,
                                                      trip.id);
                                                },
                                                title: "Accept",
                                              ),
                                              SizedBox(width:30.w),
                                        trip.userId ==
                                                _box.read(LocalStoreKey.userId)
                                            ? Container()
                                            : bidButton(
                                                width: 80.w,
                                                ontab: () {
                                                  makeOffer(context);
                                                },
                                                title: "Make Offer",
                                              ),
                                      ],
                                    ),
                            ],
                          )),
             trip.userId ==_box.read(LocalStoreKey.userId)?  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          bidButton(
                            ontab: () {
                                       Get.to(
                                          TripGivePostEdit(
                                            trip.path.toString(),
                                          ),
                                          duration: Duration(
                                              milliseconds:
                                                  200), //duration of transitions, default 1 sec
                                          transition: Transition.leftToRight);
                     
                            },
                            title: "Edit",
                            width: 80.w,
                            size: 15.sp,
                          ),
                          bidButton(
                            ontab: () {
                              cancelTrip(context);
                            },
                            title: "Cancel Trip",
                            width: 100.w,
                            size: 15.sp,
                            color: Colors.amberAccent,
                          ),
                        ],
                      ):Container(),
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Future<dynamic> makeOffer(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title:const Text("Make Counter Offer"),
          content: Container(
              height: 300.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextFormField(
                        controller: amount,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your amount';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "${trip.pay.toString()}",
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                        width: 300.w,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            isExpanded: true,
                            hint: Text(
                              "${isSelect ? seatNumber : 'How many of you?'}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13.sp),
                            ),
                            underline: SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: seat,
                            items: items
                                .map((e) => DropdownMenuItem(
                                      onTap: () {
                                        setState(() {
                                          seatNumber = e['name'].toString();
                                        });
                                      },
                                      value: e['id'],
                                      child: Text(
                                        "${e['name']}",
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              seatNumber = value;
                              print(seatNumber);
                              isSelect = true;
                            })),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextFormField(
                        controller: shortmessage,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "short message (Optional)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        CustomButtonOne(
                            height: 30.h,
                            width: 100.w,
                            radius: 5.r,
                            marginLR: 10.w,
                            title: "Cancle",
                            btnColor: Colors.red,
                            onTab: () {
                              Get.back();
                            }),
                        CustomButtonOne(
                            width: 100.w,
                            height: 30.h,
                            radius: 5.r,
                            marginLR: 0.w,
                            title: "Submit",
                            btnColor: navyBlueColor,
                            onTab: () {
                              print(trip.pay.toString());
                              print(amount);
                              print(seatNumber);
                              print(shortmessage.text.toString());

                              var _isValid =
                                  _formOfferkey.currentState!.validate();
                              if (_isValid) {
                                controller.bidOnTrip(
                                    amount: amount.text.toString(),
                                    tripId: trip.id.toString(),
                                    seat: seatNumber,
                                    message: shortmessage.text.toString());
                                setState(() {});
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Offer not submitted"),
                                ));
                              }
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Future<dynamic> acceptOffer(BuildContext context, bidsId, acceptAmount) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Do you Want to Accept?")),
          content: Container(
              alignment: Alignment.center,
              height: 85.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Task Amount is :$acceptAmount ",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
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
                              var seat = trip.seatsAvailable;
                              print("seat $seat");
                              var passenger = trip.vehicleSeat;
                              var sum =
                                  int.parse(seat!) + int.parse(passenger!);

                              controller.acceptTrip(
                                  bidId: bidsId.toString(), sum: sum);
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  Future<dynamic> agreeOffer(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Do you Agree?")),
          content: Container(
              alignment: Alignment.center,
              height: 85.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
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
                              controller.tripAgree(bidId: trip.id.toString());
                            })
                      ],
                    )
                  ],
                ),
              ))),
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

  Future<dynamic> declineOffer(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: Text("Do you want to Decline?")),
        content: Container(
          alignment: Alignment.center,
          height: 85.h,
          decoration: BoxDecoration(),
          child: Column(
            children: [
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
                        controller.tripDisAgree(bidId: trip.id.toString());
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // done
  Future<dynamic> cancelTrip(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text("Do you Want to Cancle Trip?")),
          content: Container(
              alignment: Alignment.center,
              height: 85.h,
              decoration: BoxDecoration(),
              child: Form(
                key: _formOfferkey,
                child: Column(
                  children: [
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
                              controller.tripCancle(slug: trip.slug.toString());
                            })
                      ],
                    )
                  ],
                ),
              ))),
    );
  }

  bool selectPassengerStatus = false;
  List<Map<String, dynamic>> items = [
    {
      "id": 1,
      "name": "1",
    },
    {
      "id": 2,
      "name": "2",
    },
    {
      "id": 3,
      "name": "3",
    },
    {
      "id": 4,
      "name": "4",
    },
  ];
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
                width: 200.w,
                child: CustomText(
                    " ${value}", Colors.black, FontWeight.w500, 13.sp),
              )
            : Container(
                width: 200.w,
                child: CustomText(" ${value == "0" ? "NO" : "Yes"}",
                    Colors.black, FontWeight.normal, 13.sp),
              ),
      ],
    );
  }
}
