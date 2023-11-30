import 'dart:async';

import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/controller/vehicle_controller.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class GiveTripPost extends StatefulWidget {
  @override
  State<GiveTripPost> createState() => _GiveTripPostState();
}

class _GiveTripPostState extends State<GiveTripPost> {
  final TextEditingController search = TextEditingController();

  final List<String> vehicleitems = [
    'Car',
    'Bike',
    'tripshiptask',
  ];

  final List<String> numberOfpassenger = [
    '1',
    '2',
    '3',
  ];
  final List<String> preferGetRide = [
    'Male',
    'Female',
    'Any',
  ];
  String? selectVehicle;
  String? selectPassenger;
  String? selectPrefer;

  var startPointLat;
  var startPointLong;
  var destinationPointLong;
  var destinationPointLat;
  var willPayAmount;

  final TextEditingController description = TextEditingController();

  final TextEditingController note = TextEditingController();

  List<DropdownMenuItem<String>> get willingPay {
    List<DropdownMenuItem<String>> destination = [
      const DropdownMenuItem(child: Text("USD"), value: "USD"),
      const DropdownMenuItem(child: Text("BD"), value: "BD"),
    ];
    return destination;
  }

  String willing = "USD";

  var currency;

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

  @override
  Widget build(BuildContext context) {
    var vehicleController = Get.put(VehicleController());
    vehicleController.getMyVehicles();
    //  print( vehicleController.myVehicles.first.type);
    var controller = Get.put(TripController());
    return SingleChildScrollView(
      child: Column(
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
                  hintText: 'Start Point',
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
                    print("start point $value");
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            "${pickDate.day}-${pickDate.month}-${pickDate.year}",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "${pickDate.day}-${pickDate.month}-${pickDate.year}"),
                  ),
                ),
                InkWell(
                    onTap: _showTimePicker,
                    child: Container(
                      alignment: Alignment.center,
                      width: 100.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.w, color: Colors.grey)),
                      child: pickupTime != null
                          ? Text(pickupTime!.format(context).toString())
                          : Text("Select Time"),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
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
                  hintText: 'Destination ',
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
                          _endSearchFieldController.text =
                              details.result!.name!;
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
            height: 200,
            width: 320.w,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                    position: LatLng(222.341900, 91.815536),
                    markerId: MarkerId('id'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta)),
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(222.341900, 91.815536), zoom: 14.47),
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  _controller = controller;
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
                Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Obx(() => vehicleController.isLoading == false
                        ? DropdownButtonHideUnderline(
                            child: DropdownButton2<dynamic>(
                              isExpanded: true,
                              hint: Text(
                                'Select Vehicle',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: vehicleController.myVehicles
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.type,
                                        child: Text(
                                          "${item.type}",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectVehicle,
                              onChanged: (value) {
                                setState(() {
                                  selectVehicle = value;
                                  print(selectVehicle);
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                height: 40,
                                width: 120,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          )
                        : Text(
                            "No Vehicle avaiable",
                            style:
                                TextStyle(fontSize: 13.sp, color: Colors.black),
                          ))),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  width: 180.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'How many of you',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: numberOfpassenger
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectPassenger,
                      onChanged: (String? value) {
                        setState(() {
                          selectPassenger = value;
                          print(selectPassenger);
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        //   padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 160,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
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
                Card(
                  child: Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Prefer to get ride from',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: preferGetRide
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectPrefer,
                        onChanged: (String? value) {
                          setState(() {
                            selectPrefer = value;
                            print("Select Prefer $selectPrefer");
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.only(left: 3.w),
                          height: 40,
                          width: 150,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  height: 35.h,
                  width: 90.w,
                  child: TextField(
                    autofocus: false,
                    onChanged: (value) {
                      willPayAmount = value.toString();
                      print("Will You pay $willPayAmount");
                    },
                    style: TextStyle(fontSize: 15.sp),
                    decoration: InputDecoration(
                      hintText: 'Will you pay',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.sp),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: DropdownButton(
                      underline: SizedBox(),
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                      value: willing,
                      onChanged: (value) {
                        currency = value;
                        print("Willing Pay currency is $currency");
                      },
                      items: willingPay,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextFormField(
              controller: note,
              decoration: InputDecoration(
                hintText: "Note",
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          CustomButtonOne(
            title: "Sumbit",
            onTab: () {
              startPointLat = startPosition!.geometry!.location!.lat;
              print("Start Lat $startPointLat");
              startPointLong = startPosition!.geometry!.location!.lng;
              print("Start Long $startPointLong");
              destinationPointLat = startPosition!.geometry!.location!.lat;
              print("Destination Lat $startPointLong");
              destinationPointLong = startPosition!.geometry!.location!.lng;
              print("Destination Long $startPointLong");
              print(
                  "address is ${GetAddressFromLatLong(startPointLat, startPointLong)}");

              controller.giveTripRide(
                date: dateDairy.toString(),
                time: tripTime.toString(),
                duration: "2",
                sPointLat: startPointLat,
                sPointLng: startPointLong,
                dPointLat: destinationPointLat,
                dPointLng: destinationPointLong,
                howmany: selectPassenger,
                note: note.text.toString(),
                vehicled: selectVehicle,
                passengerType: selectPrefer,
                willPay: willPayAmount,
                currency: currency,
                country: "BD",
                distance: "2",
                des: note.text.toString(),
              );
            },
            height: 40.h,
            width: 150.w,
            btnColor: navyBlueColor,
            radius: 10.r,
          )
        ],
      ),
    );
  }

  String? selectedDates;

  DateTime pickDate = DateTime.now();

  var dateDairy;

  bool dateStatus = false;

  dairyDatePicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: pickDate,
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
        pickDate = userSelectedDate;
        print(pickDate);
        dateDairy = "${pickDate.year}-${pickDate.month}-${pickDate.day}";
        print("Date $selectedDates");
      });
    }
  }

  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;

  var pickupTime;
  var tripTime;
  void _showTimePicker() async {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        print(value!.hour);
        pickupTime = value;
        tripTime = pickupTime!.format(context).toString();

        print("Trip Time is $tripTime");
      });
    });
  }
}

class MyMap extends StatefulWidget {
  final String user_id;
  MyMap(this.user_id);
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      markers: {
        Marker(
            position: LatLng(22.99999, 22.99999),
            markerId: MarkerId('id'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta)),
      },
      initialCameraPosition: CameraPosition(
          target: LatLng(
            22.00,
            22.99,
          ),
          zoom: 14.47),
      onMapCreated: (GoogleMapController controller) async {
        setState(() {
          _controller = controller;
          _added = true;
        });
      },
    );
  }
}
