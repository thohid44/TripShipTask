import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
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

  List<DropdownMenuItem<String>> get typeOfGoods {
    List<DropdownMenuItem<String>> destination = [
      const DropdownMenuItem(
          child: Text("Type of goods"), value: "Type of goods"),
      const DropdownMenuItem(child: Text("1"), value: "1"),
    ];
    return destination;
  }

  String typeGood = "Type of goods";

  List<DropdownMenuItem<String>> get packageTypes {
    List<DropdownMenuItem<String>> destination = [
      const DropdownMenuItem(
          child: Text("Packaging type"), value: "Packaging type"),
    ];
    return destination;
  }

  String packageType = "Packaging type";

  List<DropdownMenuItem<String>> get weightOfPackages {
    List<DropdownMenuItem<String>> destination = [
      const DropdownMenuItem(child: Text("KG"), value: "KG"),
    ];
    return destination;
  }

  String weightOfPackage = "KG";

  List<DropdownMenuItem<String>> get willingPay {
    List<DropdownMenuItem<String>> destination = [
      const DropdownMenuItem(child: Text("USD"), value: "USD"),
      const DropdownMenuItem(child: Text("BD"), value: "BD"),
    ];
    return destination;
  }

  String willing = "USD";

  final TextEditingController pickup = TextEditingController();

  final TextEditingController pickDate = TextEditingController();

  final TextEditingController deliveryDate = TextEditingController();

  final TextEditingController dropOff = TextEditingController();
  final TextEditingController sendItem = TextEditingController();
  final TextEditingController approxValue = TextEditingController();
  final TextEditingController note = TextEditingController();
  var controller = Get.put(SendPackageController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: 300.w,
          height: 35.h,
          child: TextField(
            controller: _startSearchFieldController,
            autofocus: false,
            focusNode: startFocusNode,
            style: TextStyle(fontSize: 15.sp),
            decoration: InputDecoration(
                hintText: 'Pick Up',
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
          height: 5.h,
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
                  height: 35.h,
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
                    height: 45.h,
                    child: pickupTime != null
                        ? Text(pickupTime!.format(context).toString())
                        : Text("Select Time"),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: 300.w,
          height: 35.h,
          child: TextField(
            controller: _endSearchFieldController,
            autofocus: false,
            focusNode: endFocusNode,
            enabled: _startSearchFieldController.text.isNotEmpty &&
                startPosition != null,
            style: TextStyle(fontSize: 15.sp),
            decoration: InputDecoration(
                hintText: 'Destination Point',
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
                leading: CircleAvatar(
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
          height: 150,
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
                  dairyDatePicker(context);
                },
                child: Container(
                  width: 150.w,
                  height: 35.h,
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
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: _deliveryTimePicker,
                child: Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    // ignore: unnecessary_null_comparison
                    child: delivaryTime != null
                        ? Text(delivaryTime!.format(context).toString())
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 5.w,
              ),
              Card(
                child: Container(
                  height: 35.h,
                  width: 80.w,
                  alignment: Alignment.center,
                  child: Text(
                    "willing to pay",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Card(
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButton(
                    underline: SizedBox(),
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    value: willing,
                    onChanged: (value) {
                      willing = value!;
                      print(willing);
                    },
                    items: willingPay,
                  ),
                ),
              ),
              Container(
                  width: 150.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  child: CustomForm(
                    hinttext: "What are you sending? ",
                    radius: 5.r,
                    textController: sendItem,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: 35.h,
                width: 155.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.r)),
                child: DropdownButton(
                  underline: SizedBox(),
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  value: typeGood,
                  onChanged: (value) {
                    typeGood = value!;
                  },
                  items: typeOfGoods,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Container(
                  width: 150.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  child: CustomForm(
                    hinttext: "Approx value of the goods? ",
                    radius: 5.r,
                    textController: search,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: 35.h,
                width: 140.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.r)),
                child: DropdownButton(
                  underline: SizedBox(),
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  value: packageType,
                  onChanged: (value) {
                    packageType = value!;
                    print(packageType);
                  },
                  items: packageTypes,
                ),
              ),
              Card(
                child: Container(
                  height: 35.h,
                  width: 100.w,
                  alignment: Alignment.center,
                  child: Text(
                    "Weight of package",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              Card(
                child: Container(
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
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextFormField(
            controller: note,
            decoration: InputDecoration(
              hintText: "Note",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        CustomButtonOne(
          title: "Sumbit",
          onTab: () {
            var pickUpPointLat = startPosition!.geometry!.location!.lat;

            var pickUpPointLong = startPosition!.geometry!.location!.lng;

            var dropUpPointLat = startPosition!.geometry!.location!.lat;

            var dropUpPointLong = startPosition!.geometry!.location!.lng;

            print(
                "address is ${GetAddressFromLatLong(pickUpPointLat, pickUpPointLong)}");
            controller.sendPackage(
                pickup: pickup.text.toString(),
                pickDate: pickDate.text.toString(),
                pPointLat: pickUpPointLat,
                pPointLng: pickUpPointLong,
                dPointLat: dropUpPointLat,
                dPointLng: dropUpPointLong,
                deliveryDate: deliveryDate,
                deliveryTime: delivaryTime,
                dropOff: dropOff,
                goodType: typeGood,
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
      //  firstDate: DateTime.now(),
      // firstDate: DateTime(2022, 9, 15),

      // lastDate: DateTime(3000),

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
        print("Date $selectedDates");
      });
    }
  }

  String? selectedDates2;

  DateTime dropUpDate = DateTime.now();

  var dateDropUp;

  bool dateStatus2 = false;
  dropUpDatePicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: dropUpDate,
      firstDate: DateTime(2021),
      //  firstDate: DateTime.now(),
      // firstDate: DateTime(2022, 9, 15),

      // lastDate: DateTime(3000),

      lastDate: DateTime(2030, 01, 01),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        //   dateStatus = true;
        dropUpDate = userSelectedDate;
        print(pickUpDate);
        dateDropUp = "${dropUpDate.year}-${dropUpDate.month}-${dropUpDate.day}";
        print("Date $selectedDates2");
      });
    }
  }

  var pickupTime;
  void _showTimePicker() async {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        print(value);
        pickupTime = value;
        print(pickupTime);
      });
    });
  }

  TimeOfDay? delivaryTime;
  void _deliveryTimePicker() async {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        delivaryTime = value!;
      });
    });
  }
}
