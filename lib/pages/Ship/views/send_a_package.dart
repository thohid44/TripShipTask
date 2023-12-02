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

class SendAPackage extends StatefulWidget {
  @override
  State<SendAPackage> createState() => _SendAPackageState();
}

class _SendAPackageState extends State<SendAPackage> {
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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: 300.w,
          height: 30.h,
          child: TextField(
            controller: _startSearchFieldController,
            autofocus: false,
            focusNode: startFocusNode,
            style: TextStyle(fontSize: 15.sp),
            decoration: InputDecoration(
                hintText: 'Pick Up Point',
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                filled: true,
                fillColor: Colors.grey[200],
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
        SizedBox(
          height: 2.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  dairyDatePicker(context);
                },
                child: Container(
                  width: 150.w,
                  height: 30.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 0.w),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5.w, color: Colors.grey)),
                  child: dateStatus == false
                      ? Text(
                          "${pickUpDate.day}-${pickUpDate.month}-${pickUpDate.year}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "${pickUpDate.day}-${pickUpDate.month}-${pickUpDate.year}"),
                ),
              ),
              InkWell(
                  onTap: _showTimePicker,
                  child: Container(
                    alignment: Alignment.center,
                    width: 160.w,
                    height: 30.h,
                    child: pickupTime != null
                        ? Text(pickuptime!.format(context).toString())
                        : Text("Select Time"),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: 300.w,
          height: 30.h,
          child: TextField(
            controller: _endSearchFieldController,
            autofocus: false,
            focusNode: endFocusNode,
            enabled: _startSearchFieldController.text.isNotEmpty &&
                startPosition != null,
            style: TextStyle(fontSize: 15.sp),
            decoration: InputDecoration(
                hintText: 'Drop Off Point',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14.sp),
                filled: true,
                fillColor: Colors.grey[200],
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
          height: 5.h,
        ),
        Container(
          color: Colors.grey,
          height: 140,
          width: 320.w,
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  dropUpDatePicker(context);
                },
                child: Container(
                  width: 150.w,
                  height: 30.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 0.w),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5.w, color: Colors.grey)),
                  child: dateStatus == false
                      ? Text(
                          "${dropUpDate1.day}-${dropUpDate1.month}-${dropUpDate1.year}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "${dropUpDate1.day}-${dropUpDate1.month}-${dropUpDate1.year}"),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              InkWell(
                onTap: _deliveryTimePicker,
                child: Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    // ignore: unnecessary_null_comparison
                    child: delivaryTime != null
                        ? Text(delivarytime!.format(context).toString())
                        : Text(
                            "Perferred delivery time",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: 346.w,
            child: Row(
              children: [
                Container(
                    height: 30.h,
                    width: 120.w,
                    alignment: Alignment.center,
                    child: TextField(
                        controller: willingPay,
                        decoration: InputDecoration(
                            hintText: "Willing you pay",
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontSize: 12.sp),
                            contentPadding:
                                EdgeInsets.only(top: 5.h, left: 3.w)))),
                Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: purplColor,
                      border: Border.all(
                        width: 1.w,
                      ),
                    ),
                    child: Text(
                      "BDT",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                    width: 170.w,
                    height: 30.h,
                    alignment: Alignment.center,
                    child: CustomForm(
                      hinttext: "What are you sending? ",
                      radius: 5.r,
                      textController: sendItem,
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: 346.w,
            child: Row(
              children: [
                Container(
                    width: 160.w,
                    alignment: Alignment.center,
                    height: 30.h,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        isExpanded: true,
                        hint: Text(
                          "${isGoodsSelect ? goodsName : 'Type of Goods'}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13.sp),
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
                SizedBox(
                  width: 5.w,
                ),
                Container(
                    width: 170.w,
                    height: 30.h,
                    alignment: Alignment.center,
                    child: CustomForm(
                      hinttext: "Approx value of the goods? ",
                      radius: 5.r,
                      textController: approxValue,
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: 346.w,
            child: Row(
              children: [
                Container(
                    width: 160.w,
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: DropdownButton(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        isExpanded: true,
                        hint: Text(
                          "${isGoodsSelect ? package : 'Packaging Type'}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13.sp),
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
                Container(
                  height: 30.h,
                  width: 110.w,
                  alignment: Alignment.center,
                  child: CustomForm(
                    hinttext: "Weight of package",
                    radius: 5.r,
                    textController: weight,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  width: 45.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: DropdownButton(
                    underline: SizedBox(),
                    isExpanded: true,
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    value: weightOfPackage,
                    onChanged: (value) {
                      weightOfPackage = value!;
                      print(weightOfPackage);
                    },
                    items: weightOfPackages,
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
          child: Container(
            width: 346.w,
            child: TextFormField(
              controller: note,
              decoration: InputDecoration(
                hintText: "Note",
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
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
