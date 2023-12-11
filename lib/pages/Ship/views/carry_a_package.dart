import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/Widget/custom_text_field.dart';
import 'package:tripshiptask/pages/Ship/controller/send_package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Trip/views/trip_page.dart';

class CarryAPackage extends StatefulWidget {
  @override
  State<CarryAPackage> createState() => _CarryAPackageState();
}

class _CarryAPackageState extends State<CarryAPackage> {
  final _startSearchFieldController = TextEditingController();

  final _endSearchFieldController = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  late GooglePlace googlePlace;

  List<AutocompletePrediction> predictions = [];

  Timer? _debounce;
  List<Placemark>? placemark;
  GetAddressFromLatLong(lat, lng) async {
    placemark = await placemarkFromCoordinates(lat, lng);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    String apiKey = 'AIzaSyDLMJOClhhQjkfepu0R8iOCIt7bUpUF0nU';
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  final TextEditingController search = TextEditingController();

  String deliveryTime = "Perferred delivery time";

  List<DropdownMenuItem<String>> get weightOfPackages {
    List<DropdownMenuItem<String>> destination = [
      const DropdownMenuItem(child: Text("KG"), value: "KG"),
    ];
    return destination;
  }

  String weightOfPackage = "KG";
// Goods
  var goodsName;
  String? goodsType;
  bool isGoodsSelect = false;
  List<Map<String, dynamic>> goodTypeList = [
    {"id": 1, "name": "Perishable", "slug": "Perishable"},
    {"id": 2, "name": "Non-perishable", "slug": "Non-perishable"},
  ];
// Package List
  var packageName;
  String? package;
  bool isPackageSelect = false;
  List<Map<String, dynamic>> packageList = [
    {"id": 1, "name": "Small Envelope", "slug": "Small Envelope"},
    {"id": 2, "name": "Large Envelope", "slug": "Large Envelope"},
    {
      "id": 3,
      "name": "Small package(perishable items)",
      "slug": "Small package(perishable items)"
    },
    {
      "id": 4,
      "name": "Small package(non-perishable items)",
      "slug": "Small package(non-perishable items)"
    },
    {
      "id": 5,
      "name": "Medium package(perishable items)",
      "slug": "Medium package(perishable items)"
    },
    {
      "id": 6,
      "name": "Medium package(Non-perishable items)",
      "slug": "Medium package(Non-perishable items)"
    },
  ];

  final TextEditingController pickup = TextEditingController();
  final TextEditingController pickDate = TextEditingController();
  final TextEditingController willingPay = TextEditingController();
  final TextEditingController deliveryDate = TextEditingController();
  final TextEditingController dropOff = TextEditingController();
  final TextEditingController sendItem = TextEditingController();
  final TextEditingController approxValue = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController note = TextEditingController();

  var controller = Get.put(SendPackageController());
  var fullWidth = 306.w;
  var height = 3;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 5.h,
        ),
        UnconstrainedBox(
          child: Card(
            elevation: 5,
            child: Container(
              width: fullWidth,
              height: 30.h,
              decoration: BoxDecoration(
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                    spreadRadius: 8, //spread radius
                    blurRadius: 7, // blur radius
                    offset: Offset(3, 5), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _startSearchFieldController,
                autofocus: false,
                focusNode: startFocusNode,
                style: TextStyle(fontSize: 13.sp),
                decoration: InputDecoration(
                    hintText: 'Pick Up Point',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 13.sp),
                    filled: true,
                    fillColor: primaryColor,
                    border: InputBorder.none,
                    suffixIcon: _startSearchFieldController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                predictions = [];
                                _startSearchFieldController.clear();
                              });
                            },
                            icon: Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    if (value.isNotEmpty) {
                      print("Pick Up  $value");
                      //places api
                      autoCompleteSearch(value);
                    } else {
                      //clear out the results
                      setState(() {
                        predictions = [];
                        startPosition = null;
                      });
                    }
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: height.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: fullWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    dairyDatePicker(context);
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      width: 140.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                     color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffF1F4F9)
                                .withOpacity(0.5), //color of shadow
                            spreadRadius: 8, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(3, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: dateStatus == false
                          ? Text(
                              "Pickup Date",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "${pickUpDate.day}-${pickUpDate.month}-${pickUpDate.year}",style: 
                              TextStyle(fontSize: 13.sp, fontWeight: FontWeight.normal),),
                    ),
                  ),
                ),
                InkWell(
                    onTap: _showTimePicker,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        alignment: Alignment.center,
                        width: 151.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: primaryColor, 
                                       boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
              
                ),
              ],
                        ),
                        child: pickupTime != null
                            ? Text(pickuptime!.format(context).toString())
                            : Text("Prefered Pick Up Time", style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.normal
                            ),),
                      ),
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height.h,
        ),
        UnconstrainedBox(
          child: Card(
            elevation: 5,
            child: Container(
              width: fullWidth,
              height: 30.h,
              decoration: BoxDecoration(
                color: primaryColor, 
                             boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
              
                ),
              ],
              ),
              child: TextField(
                controller: _endSearchFieldController,
                autofocus: false,
                focusNode: endFocusNode,
                enabled: _startSearchFieldController.text.isNotEmpty &&
                    startPosition != null,
                style: TextStyle(fontSize: 13.sp , fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    hintText: 'Prefered Drop Off Point(Optional)',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                    
                        fontSize: 13.sp),
                    filled: true,
                    fillColor: primaryColor,
                    border: InputBorder.none,
                    suffixIcon: _endSearchFieldController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                predictions = [];
                                _endSearchFieldController.clear();
                              });
                            },
                            icon: Icon(Icons.clear_outlined),
                          )
                        : null),
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    if (value.isNotEmpty) {
                      //places api
                      autoCompleteSearch(value);
                    } else {
                      //clear out the results
                      setState(() {
                        predictions = [];
                        endPosition = null;
                      });
                    }
                  });
                },
              ),
            ),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: predictions.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.pin_drop,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  predictions[index].description.toString(),
                ),
                onTap: () async {
                  final placeId = predictions[index].placeId!;

                  final details = await googlePlace.details.get(placeId);

                  if (details != null && details.result != null && mounted) {
                    if (startFocusNode.hasFocus) {
                      setState(() {
                        startPosition = details.result;

                        _startSearchFieldController.text =
                            details.result!.name!;
                        predictions = [];
                      });
                    } else {
                      setState(() {
                        endPosition = details.result;
                        print(
                            "Start Point ${endPosition!.geometry!.location!.lat}");
                        _endSearchFieldController.text = details.result!.name!;
                        predictions = [];
                      });
                    }
                  }
                },
              );
            }),
        SizedBox(
          height: height.h,
        ),
        UnconstrainedBox(
          child: Card(
            elevation: 5,
            child: Container(
             
              height: 120,
              width: fullWidth,
              decoration: BoxDecoration(
                color: primaryColor,
                             boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
              
                ),
              ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: height.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: fullWidth,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    dropUpDatePicker(context);
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      width: 143.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration
                      (
                        color: primaryColor, 
                                     boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
              
                ),
              ],
                      ),
                      child: dateStatus == false
                          ? Text(
                              "Possible Delivery Date",
                              style: TextStyle(
                                  fontSize: 13.sp,
                              
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "${dropUpDate1.day}-${dropUpDate1.month}-${dropUpDate1.year}",
                              style: TextStyle(fontSize: 13.sp,
                              fontWeight: FontWeight.normal),),
                    ),
                  ),
                ),
              
                InkWell(
                  onTap: _deliveryTimePicker,
                  child: Card(
                    elevation: 5,
                    child: Container(
                        alignment: Alignment.center,
                        height: 30.h,
                        width: 148.w,
                        decoration: BoxDecoration(
                          color: primaryColor,
                                       boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
              
                ),
              ],
                            borderRadius: BorderRadius.circular(5.r)),
                        // ignore: unnecessary_null_comparison
                        child: delivaryTime != null
                            ? Text(delivarytime!.format(context).toString(),
                             style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                ),)
                            : Text(
                                "Possible Delivery Time",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              )),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: height.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: fullWidth,
            child: Row(
              children: [
                CustomTextForm(
                  width: 100.w,
                  height: 30.h,
                  hinttext: "Asking Amount",
                  fontSize: 12.5.sp,
                  textController: willingPay,
                ),
                Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                      color: purplColor,
                         boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
              
                ),
              ],
                    ),
                    child: Text(
                      "BDT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                      ),
                    )),
                      Card(
                  elevation: 5,
                  child: Container(
                      width: 160.w,
                      alignment: Alignment.center,
                      height: 30,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
              
                ),
              ],),
                      child: DropdownButton(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          isExpanded: true,
                          hint: Text(
                            "${isGoodsSelect ? package :'Preferred Package Size'}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12.sp),
                          ),
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: packageName,
                          items: packageList
                              .map((e) => DropdownMenuItem(
                                    onTap: () {
                                      package = e['name'].toString();
                                      print(package);
                                    },
                                    value: e['id'],
                                    child: Text(
                                      "${e['name']}",
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              isPackageSelect = true;
                            });
                          })),
                ),
              
              ],
            ),
          ),
        ),
        SizedBox(
          height: height.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: fullWidth,
            child: Row(
              children: [
                Card(
                  elevation: 5,
                  child: Container(
                      width: 125.w,
                      alignment: Alignment.center,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffF1F4F9)
                                  .withOpacity(0.5), //color of shadow
                              spreadRadius: 8, //spread radius
                              blurRadius: 7, // blur radius
                              offset:
                                  Offset(3, 5), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            ),
                          ]),
                      child: DropdownButton(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          isExpanded: true,
                          hint: Text(
                            "${isGoodsSelect ? goodsName : 'Type of Goods'}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13.sp),
                          ),
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: goodsType,
                          items: goodTypeList
                              .map((e) => DropdownMenuItem(
                                    onTap: () {
                                      goodsName = e['name'].toString();
                                    },
                                    value: e['id'],
                                    child: Text(
                                      "${e['name']}",
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              isGoodsSelect = true;
                            });
                          })),
                ),
                CustomTextForm(
                  width: 165.w,
                  height: 30.h,
                  hinttext: "Weight Willing To Carry",
                  fontSize: 13.sp,
                  textController: approxValue,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 3.h,),
        UnconstrainedBox(
          child: Container(
            width: 306.w,
            child: Row(
              children: [
                Text("Using your own vehicle?",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize:13.sp, color: Colors.black)
                       
                ),
              ],
            )),
        ),
        SizedBox(
          height: height.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: fullWidth,
            child: Row(
              children: [
              
                CustomTextForm(
                  height: 30.h,
                  width: 160.w,
                  hinttext: "Weight of package",
                  fontSize: 13.sp,
                  textController: weight,
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    width: 50.w,
                    decoration: BoxDecoration(
                       
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffF1F4F9)
                                .withOpacity(0.5), //color of shadow
                            spreadRadius: 8, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(3, 5), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                        ]),
                    child: DropdownButton(
                      underline: SizedBox(),
                      isExpanded: true,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                      value: weightOfPackage,
                      onChanged: (value) {
                        weightOfPackage = value!;
                        print(weightOfPackage);
                      },
                      items: weightOfPackages,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        UnconstrainedBox(
          child: Card(
            elevation: 5,
            child: Container(
               
              decoration: BoxDecoration(color: primaryColor, boxShadow: [
                BoxShadow(
                  color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                  spreadRadius: 8, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(3, 5), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
              ]),
              width: fullWidth,
              child: TextFormField(
                controller: note,
                decoration: InputDecoration(
                  hintText: "Note",
                  fillColor: primaryColor,
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomButtonOne(
          title: "Submit",
          onTab: () {
            var pickUpPointLat = startPosition!.geometry!.location!.lat;
            var pickUpPointLong = startPosition!.geometry!.location!.lng;
            var dropUpPointLat = startPosition!.geometry!.location!.lat;
            var dropUpPointLong = startPosition!.geometry!.location!.lng;

            print(
                "address is ${GetAddressFromLatLong(pickUpPointLat, pickUpPointLong)}");
            controller.sendPackage(
                pickup: _startSearchFieldController.text.toString(),
                pickDate: pickDate.text.toString(),
                pickTime: pickupTime.toString(),
                pPointLat: pickUpPointLat,
                pPointLng: pickUpPointLong,
                dPointLat: dropUpPointLat,
                dPointLng: dropUpPointLong,
                deliveryDate: deliveryDate.text.toString(),
                deliveryTime: delivaryTime.toString(),
                dropOff: _endSearchFieldController.text,
                willingPay: willingPay.text.toString(),
                sendItem: sendItem.text,
                goodType: goodsName,
                approxiValue: approxValue.text.toString(),
                packageType: package,
                currency: "BDT",
                weight: weight.text,
                note: note.text.toString());
          },
          height: 40.h,
          width: 150.w,
          btnColor: navyBlueColor,
          radius: 10.r,
        )
      ],
    );
  }

  String? selectedDates;

  DateTime pickUpDate = DateTime.now();
  var dateDairy;
  bool dateStatus = false;

  dairyDatePicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: pickUpDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030, 01, 01),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        //   dateStatus = true;
        pickUpDate = userSelectedDate;
        print(pickUpDate);
        dateDairy = "${pickUpDate.year}-${pickUpDate.month}-${pickUpDate.day}";
        pickDate.text = dateDairy;
        print("Pick Date ${pickDate.text}");
      });
    }
  }

  String? selectedDates2;

  DateTime dropUpDate1 = DateTime.now();

  var dateDropUp;

  bool dateStatus2 = false;
  dropUpDatePicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: dropUpDate1,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030, 01, 01),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        //   dateStatus = true;
        dropUpDate1 = userSelectedDate;
        print(dropUpDate1);
        var dropOffDate =
            "${dropUpDate1.year}-${dropUpDate1.month}-${dropUpDate1.day}";
        deliveryDate.text = dropOffDate;
        print("Delivery Date ${deliveryDate.text}");
      });
    }
  }

  TimeOfDay? pickuptime;
  var pickupTime;
  void _showTimePicker() async {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        pickuptime = value;

        pickupTime = pickuptime!.format(context).toString();

        print("Pick Up $pickupTime");
      });
    });
  }

  TimeOfDay? delivarytime;
  var delivaryTime;
  void _deliveryTimePicker() async {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        delivarytime = value!;
        delivaryTime = delivarytime!.format(context).toString();
        print("delivary time $delivaryTime");
      });
    });
  }
}

class LavenderTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.5), // Shadow color
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
