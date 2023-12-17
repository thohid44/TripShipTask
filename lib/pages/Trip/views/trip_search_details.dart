// import 'dart:async';
// import 'dart:convert';

// import 'package:tripshiptask/Api_services/base_url.dart';

// import 'package:tripshiptask/Utils/localstorekey.dart';

// import 'package:tripshiptask/Widget/customText.dart';

// import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
// import 'package:tripshiptask/pages/Trip/model/trip_give_post_details_model.dart';
// import 'package:tripshiptask/pages/Trip/model/trip_post_details_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// import 'package:tripshiptask/Utils/colors.dart';


// import 'package:tripshiptask/Widget/customButtonOne.dart';


// import 'package:tripshiptask/Widget/widget_button.dart';


// import 'package:http/http.dart' as http;
// class TripSearchDeatailsPage extends StatefulWidget {
//   String path;
//   TripSearchDeatailsPage(this.path);

//   @override
//   State<TripSearchDeatailsPage> createState() => _TripSearchDeatailsPageState();
// }


// class _TripSearchDeatailsPageState extends State<TripSearchDeatailsPage> {
//   final _box = GetStorage();

//   TripPostDetailsModel? tripPostDetailsModel;
//   var controller = Get.put(TripController());
//   final _formOfferkey = GlobalKey<FormState>();
//   final TextEditingController shortmessage = TextEditingController();
//   final TextEditingController amount = TextEditingController();

//   var tripId;
//   var seatValue;
//   bool seatStatus = false;
//   var seat;
//   List<DropdownMenuItem<String>> get dropdownItem {
//     List<DropdownMenuItem<String>> seatMember = [
//       const DropdownMenuItem(child: Text("1"), value: "1"),
//       const DropdownMenuItem(child: Text("2"), value: "2"),
//       const DropdownMenuItem(child: Text("3"), value: "3"),
//     ];
//     return seatMember;
//   }

//   var details;
//   bool isLoading = false;
//   Future<TripPostDetailsModel> getTripPostDetails() async {
//     var token = _box.read(LocalStoreKey.token);

//     isLoading = true;
//     var response = await http.get(
//       Uri.parse("${urlWithOutslash}${widget.path}"),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ' + token,
//       },
//     );
//     var jsonData = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       print(" trip detail ${jsonData}");
//     }
//     return tripPostDetailsModel = TripPostDetailsModel.fromJson(jsonData);
//   }

//   bool status = false;
//   var trip;
//   void initState() {
//     getTripPostDetails();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         //   appBar: customAppBar(),
//         appBar: AppBar(
//           title: Text("Trip Details "),
//         ),
//         body: FutureBuilder(
//             future: getTripPostDetails(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 trip = snapshot.data!.tripDetailsModel!;
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Container(
//                           height: 550.h,
//                           margin: EdgeInsets.symmetric(horizontal: 15.w),
//                           child: ListView(
//                             children: [
//                               SizedBox(
//                                 height: 15.h,
//                               ),
//                               TripDetailsWidget(
//                                 status: false,
//                                 title: "Title",
//                                 value: snapshot.data!.tripDetailsModel!.id
//                                     .toString(),
//                               ),
//                               TripDetailsWidget(
//                                 status: false,
//                                 title: "Posted By",
//                                 value: trip.user,
//                               ),
//                               TripDetailsWidget(
//                                 status: false,
//                                 title: "Posted User Id",
//                                 value: "${_box.read(LocalStoreKey.userId)}",
//                               ),
//                               TripDetailsWidget(
//                                 status: false,
//                                 title: "Willing Pay",
//                                 value: trip.pay.toString(),
//                               ),
//                               TripDetailsWidget(
//                                 status: false,
//                                 title: "Poster Id",
//                                 value: trip.userId.toString(),
//                               ),
//                               Container(
//                                 height: 300.h,
//                                 child: ListView.builder(
//                                     itemCount: trip.bids.length,
//                                     itemBuilder: (context, index) {
//                                       print("index  $index");
//                                       return Card(
//                                         elevation: 5,
//                                         color: Colors.grey,
//                                         child: Container(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                   '${trip.bids[index]['user_id']}'),
//                                               // Text(
//                                               //     '${trip.bids[index]['trip_username']}'),
//                                               trip.bids.isNotEmpty
//                                                   ? TripDetailsWidget(
//                                                       status: false,
//                                                       title: "Passenger",
//                                                       value: trip.bids[index]
//                                                               ['bidder_name']
//                                                           .toString())
//                                                   : Container(),
//                                               trip.bids.isNotEmpty
//                                                   ? TripDetailsWidget(
//                                                       status: false,
//                                                       title: "Amount",
//                                                       value: trip.bids[index]
//                                                               ['amount']
//                                                           .toString())
//                                                   : Container(),
//                                               SizedBox(
//                                                 height: 5.h,
//                                               ),

//                                               trip.userId ==
//                                                       _box.read(
//                                                           LocalStoreKey.userId)
//                                                   ? Container()
//                                                   : Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceAround,
//                                                       children: [
//                                                         trip.bids[index][
//                                                                     'amount'] !=
//                                                                 0
//                                                             ? Container()
//                                                             : UnconstrainedBox(
//                                                                 child:
//                                                                     Container(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .center,
//                                                                   height: 30.h,
//                                                                   width: 80.w,
//                                                                   decoration: BoxDecoration(
//                                                                       color: Color(
//                                                                           0xff00BC8B),
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               5.r)),
//                                                                   child: Text(
//                                                                     "Accept",
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontSize: 15
//                                                                             .sp,
//                                                                         fontWeight:
//                                                                             FontWeight.w700),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                         trip.bids[index][
//                                                                     'amount'] !=
//                                                                 0
//                                                             ? Container()
//                                                             : UnconstrainedBox(
//                                                                 child: InkWell(
//                                                                   onTap: () {
//                                                                     makeOffer(
//                                                                         context);
//                                                                   },
//                                                                   child:
//                                                                       Container(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .center,
//                                                                     height:
//                                                                         30.h,
//                                                                     width:
//                                                                         100.w,
//                                                                     decoration: BoxDecoration(
//                                                                         color:const Color(
//                                                                             0xff7a15f7),
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(5.r)),
//                                                                     child: Text(
//                                                                       "Make Offer",
//                                                                       style: TextStyle(
//                                                                           color: Colors
//                                                                               .white,
//                                                                           fontSize: 15
//                                                                               .sp,
//                                                                           fontWeight:
//                                                                               FontWeight.w700),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                       ],
//                                                     ),

//                                               // Container(
//                                               //   alignment: Alignment.center,
//                                               //   height: 35.h,
//                                               //   width: 80.w,
//                                               //   decoration: BoxDecoration(
//                                               //       color: Color(0xff039be5),
//                                               //       borderRadius:
//                                               //           BorderRadius.circular(
//                                               //               15.r)),
//                                               //   child: Text(
//                                               //     "No",
//                                               //     style: TextStyle(
//                                               //         color: Colors.white,
//                                               //         fontSize: 15.sp,
//                                               //         fontWeight:
//                                               //             FontWeight.w700),
//                                               //   ),
//                                               // ),

//                                               trip.bids[index]['agree'] == 0
//                                                   ? Container()
//                                                   : Container(
//                                                       margin: EdgeInsets.only(
//                                                           left: 10.w),
//                                                       child: Text(
//                                                         "Counter Offer Received: ${trip.bids[index]['co'].toString()} BDT",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 15.sp,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w500),
//                                                       ),
//                                                     ),
//                                               SizedBox(
//                                                 height: 5.h,
//                                               ),
//                                               trip.bids[index]['co'] == 0
//                                                   ? Container()
//                                                   : Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         trip.userId ==
//                                                                 _box.read(
//                                                                     LocalStoreKey
//                                                                         .userId)
//                                                             ? WidgetButton(
//                                                                 title:
//                                                                     "Counter Offer Received: ${trip.bids[index]['co'].toString()}BDT",
//                                                               )
//                                                             : Container(
//                                                                 margin: EdgeInsets
//                                                                     .only(
//                                                                         left: 10
//                                                                             .w),
//                                                                 child: Text(
//                                                                   "Counter Offer sent: ${trip.bids[index]['co'].toString()} BDT",
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           13.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500),
//                                                                 ),
//                                                               ),
//                                                         trip.userId ==
//                                                                 _box.read(
//                                                                     LocalStoreKey
//                                                                         .userId)
//                                                             ? Container(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 height: 30.h,
//                                                                 width: 60.w,
//                                                                 decoration: BoxDecoration(
//                                                                     color: Color(
//                                                                         0xff00BC8B),
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             5.r)),
//                                                                 child: Text(
//                                                                   "Agree",
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           12.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700),
//                                                                 ),
//                                                               )
//                                                             : Container(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 height: 30.h,
//                                                                 width: 60.w,
//                                                                 decoration: BoxDecoration(
//                                                                     color: Colors
//                                                                         .yellow,
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             5.r)),
//                                                                 child: Text(
//                                                                   "Pending",
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           12.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700),
//                                                                 ),
//                                                               ),
//                                                         trip.userId ==
//                                                                 _box.read(
//                                                                     LocalStoreKey
//                                                                         .userId)
//                                                             ? Container(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 height: 30.h,
//                                                                 width: 60.w,
//                                                                 decoration: BoxDecoration(
//                                                                     color: Colors
//                                                                         .red,
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             5.r)),
//                                                                 child: Text(
//                                                                   "Decline",
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           12.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700),
//                                                                 ),
//                                                               )
//                                                             : Container(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 height: 30.h,
//                                                                 width: 60.w,
//                                                                 decoration: BoxDecoration(
//                                                                     color: Color(
//                                                                         0xff00BC8B),
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             5.r)),
//                                                                 child: Text(
//                                                                   "Accept",
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           12.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700),
//                                                                 ),
//                                                               ),
//                                                       ],
//                                                     ),

//                                               trip.bids[index]['accepted'] == 0
//                                                   ? Container()
//                                                   : Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   left: 10.w),
//                                                           child: Text(
//                                                             "Confirm the Ride? ",
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .white,
//                                                                 fontSize: 15.sp,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                         ),
//                                                         CustomButtonOne(
//                                                             width: 70.w,
//                                                             height: 30.h,
//                                                             marginLR: 5.w,
//                                                             radius: 5.r,
//                                                             btnColor:
//                                                                 const Color(
//                                                                     0xff039be5),
//                                                             title: "Yes",
//                                                             onTab: () {
//                                                               showDialog(
//                                                                   context:
//                                                                       context,
//                                                                   builder:
//                                                                       (context) {
//                                                                     return AlertDialog(
//                                                                       content: Container(
//                                                                           alignment: Alignment.center,
//                                                                           width: 200.w,
//                                                                           height: 80.h,
//                                                                           child: Column(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.center,
//                                                                             children: [
//                                                                               Text(
//                                                                                 'Confirm the Ride?',
//                                                                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
//                                                                               ),
//                                                                               SizedBox(height: 10.h),
//                                                                               Row(
//                                                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                                                 children: [
//                                                                                   CustomButtonOne(width: 70.w, height: 30.h, marginLR: 5.w, fontSize: 15.sp, fontWeight: FontWeight.w700, radius: 5.r, btnColor: Color(0xff296557), title: "Yes", onTab: () {}),
//                                                                                   CustomButtonOne(
//                                                                                       width: 70.w,
//                                                                                       height: 30.h,
//                                                                                       marginLR: 5.w,
//                                                                                       radius: 5.r,
//                                                                                       btnColor: Colors.red,
//                                                                                       title: "No",
//                                                                                       onTab: () {
//                                                                                         Get.back();
//                                                                                       })
//                                                                                 ],
//                                                                               ),
//                                                                             ],
//                                                                           )),
//                                                                     );
//                                                                   });
//                                                             }),
//                                                         CustomButtonOne(
//                                                             width: 70.w,
//                                                             height: 30.h,
//                                                             marginLR: 5.w,
//                                                             radius: 5.r,
//                                                             btnColor: Colors
//                                                                 .redAccent,
//                                                             title: "No",
//                                                             onTab: () {})
//                                                       ],
//                                                     ),

//                                               trip.bids[index]['agree'] == 1
//                                                   ? Container()
//                                                   : Container()
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                               ),
//                               trip.bids.length != 0
//                                   ? Container()
//                                   : Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         trip.userId ==
//                                                 _box.read(LocalStoreKey.userId)
//                                             ? Container()
//                                             : UnconstrainedBox(
//                                                 child: Container(
//                                                   alignment: Alignment.center,
//                                                   height: 30.h,
//                                                   width: 80.w,
//                                                   decoration: BoxDecoration(
//                                                       color: Color(0xff00BC8B),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5.r)),
//                                                   child: Text(
//                                                     "Accept",
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 15.sp,
//                                                         fontWeight:
//                                                             FontWeight.w700),
//                                                   ),
//                                                 ),
//                                               ),
//                                         trip.userId ==
//                                                 _box.read(LocalStoreKey.userId)
//                                             ? Container()
//                                             : UnconstrainedBox(
//                                                 child: InkWell(
//                                                   onTap: () {
//                                                     makeOffer(context);
//                                                   },
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 30.h,
//                                                     width: 100.w,
//                                                     decoration: BoxDecoration(
//                                                         color:
//                                                             Color(0xff7a15f7),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(5.r)),
//                                                     child: Text(
//                                                       "Make Offer",
//                                                       style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 15.sp,
//                                                           fontWeight:
//                                                               FontWeight.w700),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                       ],
//                                     ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 );
//               }
//               return Center(child: CircularProgressIndicator());
//             }),
//       ),
//     );
//   }

//   Container WidgetButt(int index) {
//     return Container(
//       margin: EdgeInsets.only(left: 10.w),
//       child: Text(
//         "Counter Offer Received: ${trip.bids[index]['co'].toString()} BDT",
//         style: TextStyle(
//             color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500),
//       ),
//     );
//   }

//   Future<dynamic> makeOffer(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//           title: Text("Make Counter Offer"),
//           content: Container(
//               height: 300.h,
//               decoration: BoxDecoration(),
//               child: Form(
//                 key: _formOfferkey,
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20.w),
//                       child: TextFormField(
//                         controller: amount,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your amount';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           hintText: "${trip.pay.toString()}",
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8.h,
//                     ),
//                     Container(
//                         width: 300.w,
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.symmetric(horizontal: 20.w),
//                         height: 45,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.lightBlue),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: DropdownButton(
//                             padding: EdgeInsets.symmetric(horizontal: 10.w),
//                             isExpanded: true,
//                             hint: Text(
//                               "${isSelect ? seatNumber : 'How many of you?'}",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w500, fontSize: 13.sp),
//                             ),
//                             underline: SizedBox(),
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             value: seat,
//                             items: items
//                                 .map((e) => DropdownMenuItem(
//                                       onTap: () {
//                                         setState(() {
//                                           seatNumber = e['name'].toString();
//                                         });
//                                       },
//                                       value: e['id'],
//                                       child: Text(
//                                         "${e['name']}",
//                                       ),
//                                     ))
//                                 .toList(),
//                             onChanged: (value) {
//                               seatNumber = value;
//                               print(seatNumber);
//                               isSelect = true;
//                             })),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 10.w),
//                       child: TextFormField(
//                         controller: shortmessage,
//                         maxLines: 3,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter some text';
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           hintText: "short message (Optional)",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     Row(
//                       children: [
//                         CustomButtonOne(
//                             height: 30.h,
//                             width: 100.w,
//                             radius: 5.r,
//                             marginLR: 10.w,
//                             title: "Cancle",
//                             btnColor: Colors.red,
//                             onTab: () {
//                               Get.back();
//                             }),
//                         CustomButtonOne(
//                             width: 100.w,
//                             height: 30.h,
//                             radius: 5.r,
//                             marginLR: 0.w,
//                             title: "Submit",
//                             btnColor: navyBlueColor,
//                             onTab: () {
//                               print(trip.pay.toString());
//                               print(amount);
//                               print(seatNumber);
//                               print(shortmessage.text.toString());
//                               var _isValid =
//                                   _formOfferkey.currentState!.validate();
//                               if (_isValid) {
//                                 controller.bidOnTrip(
//                                     amount: amount.text.toString(),
//                                     tripId: trip.id.toString(),
//                                     seat: seatNumber,
//                                     message: shortmessage.text.toString());
//                                 setState(() {});
//                               } else {
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   content: Text("Offer not submitted"),
//                                 ));
//                               }
//                             })
//                       ],
//                     )
//                   ],
//                 ),
//               ))),
//     );
//   }

//   bool selectPassengerStatus = false;
//   List<Map<String, dynamic>> items = [
//     {
//       "id": 1,
//       "name": "1",
//     },
//     {
//       "id": 2,
//       "name": "2",
//     },
//     {
//       "id": 3,
//       "name": "3",
//     },
//     {
//       "id": 4,
//       "name": "4",
//     },
//   ];
//   bool isSelect = false;

//   var seatNumber;

//   String? selectPassenger;
// }

// // class TripDetailsWidget extends StatelessWidget {
// //   String? title;
// //   String? value;
// //   TripDetailsWidget({super.key, this.value, this.title});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       children: [
// //         Container(
// //           width: 60.w,
// //           margin: EdgeInsets.all(9),
// //           child: CustomText("$title :", Colors.black, FontWeight.bold, 15.sp),
// //         ),
// //      Container(
// //           width: 260.w,
// //           child: CustomText("$value", Colors.black, FontWeight.w500, 15.sp),
// //         ),
// //       ],
// //     );
// //   }
// // }
// class TripDetailsWidget extends StatelessWidget {
//   String? title;
//   String? value;
//   late bool status = false;
//   TripDetailsWidget({super.key, this.value, this.title, required this.status});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 100.w,
//           margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//           child: CustomText("$title :", Colors.black, FontWeight.w500, 14.sp),
//         ),
//         status == false
//             ? Container(
//                 width: 200.w,
//                 child: CustomText(
//                     " ${value}", Colors.black, FontWeight.w500, 15.sp),
//               )
//             : Container(
//                 width: 200.w,
//                 child: CustomText(" ${value == "0" ? "NO" : "Yes"}",
//                     Colors.black, FontWeight.w500, 14.sp),
//               ),
//       ],
//     );
//   }
// }
