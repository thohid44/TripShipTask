import 'dart:async';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/controller/vehicle_controller.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:tripshiptask/pages/Trip/model/trips_search_model.dart';
import 'package:http/http.dart' as http;

class TripGiveSearchNew23 extends StatefulWidget {
  @override
  State<TripGiveSearchNew23> createState() => _TripGiveSearchNew23State();
}

class _TripGiveSearchNew23State extends State<TripGiveSearchNew23> {
  final TextEditingController search = TextEditingController();

  bool isVehicleSelect = false;

  String? vehicle;
  var vehicleName;

  List<Map<String, dynamic>> vehicleitems = [
    {"id": 1, "name": "Car", "slug": "Car"},
    {"id": 2, "name": "Bike", "slug": "Bike"},
  ];
  bool isSeatSelect = false;
  String? seat;
  var availableSeat;
  List<Map<String, dynamic>> seatList = [
    {"id": 1, "name": "1", "slug": "1"},
    {"id": 2, "name": "2", "slug": "2"},
    {"id": 3, "name": "3", "slug": "3"},
    {"id": 4, "name": "4", "slug": "4"},
  ];
  var preferToRide;
  String? prefer;
  bool isPreferSelect = false;
  List<Map<String, dynamic>> preferList = [
    {"id": 1, "name": "Male", "slug": "Male"},
    {"id": 2, "name": "Female", "slug": "Female"},
    {"id": 3, "name": "Other", "slug": "Other"},
  ];

  String? selectVehicle;
  String? selectPassenger;
  String? selectPrefer;

  var startPointLat;
  var startPointLong;
  var destinationPointLong;
  var destinationPointLat;

  final TextEditingController willPayAmount = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController note = TextEditingController();

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

  final _box = GetStorage();

  tripSearch() async {
    var token = _box.read(LocalStoreKey.token);
    print("search token $token");
    //"${baseUrl}trip-search?slat=23.752308&slng=23.752308&dlat=23.7382053&dlng=23.7382053&sradious&dradious&unit=km&post_type=offer"
    try {
      var startLats = startPosition!.geometry!.location!.lat;
      var startLong = startPosition!.geometry!.location!.lng;
      var endLat = endPosition!.geometry!.location!.lat;
      var endLong = endPosition!.geometry!.location!.lng;

      var response = await http.get(
        Uri.parse(
            "${baseUrl}trip-search?slat=$startLats&slng=$startLong&dlat=$endLat&dlng=$endLong&sradious&dradious&unit=km&post_type=offer"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);

        return TripSearchModel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  var fullWidth = 306.w;
  @override
  Widget build(BuildContext context) {
    var vehicleController = Get.put(VehicleController());
    vehicleController.getMyVehicles();
    //  print( vehicleController.myVehicles.first.type);
    var controller = Get.put(TripController());
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Container(
                  width: 185.w,
                  height: 30.h,
                  child: TextField(
                    controller: _startSearchFieldController,
                    autofocus: false,
                    focusNode: startFocusNode,
                    style: TextStyle(fontSize: 13.sp),
                    decoration: InputDecoration(
                        hintText: 'Start Point',
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
                CustomTextForm(
                  width: 60.w,
                  height: 30.h,
                  hinttext: "Radius",
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: fullWidth,
              child: Row(
                children: [
                  Container(
                    width: 180.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _endSearchFieldController,
                      autofocus: false,
                      focusNode: endFocusNode,
                      enabled: _startSearchFieldController.text.isNotEmpty &&
                          startPosition != null,
                      style: TextStyle(fontSize: 13.sp),
                      decoration: InputDecoration(
                          hintText: 'Destination',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 13.sp),
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
                        print(value);
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () {
                          if (value.isNotEmpty) {
                            //places api
                            print("End point $value");
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
                  CustomTextForm(
                    width: 60.w,
                    height: 30.h,
                    hinttext: "Radius",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: fullWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 149.w,
                      alignment: Alignment.center,
                      height: 30,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: DropdownButton(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          isExpanded: true,
                          hint: Text(
                            "${isVehicleSelect ? vehicleName : 'Select Vehicle'}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13.sp),
                          ),
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: vehicle,
                          items: vehicleitems
                              .map((e) => DropdownMenuItem(
                                    onTap: () {
                                      vehicleName = e['name'].toString();
                                      print("Vehicle name $vehicleName");
                                    },
                                    value: e['id'],
                                    child: Text(
                                      "${e['name']}",
                                      style: TextStyle(fontSize: 13.sp),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              isVehicleSelect = true;
                            });
                          })),
                  InkWell(
                    onTap: () {
                      dairyDatePicker(context);
                    },
                    child: Container(
                      width: 150.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          border: Border.all(width: 0.5.w, color: Colors.grey)),
                      child: dateStatus == false
                          ? Text(
                              "Select Date",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "${pickDate.day}-${pickDate.month}-${pickDate.year}"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
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

                      if (details != null &&
                          details.result != null &&
                          mounted) {
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
            UnconstrainedBox(
              child: Container(
                width: 200.w,
                child: CustomButtonOne(
                  title: "Submit",
                  onTab: () {
                    startPointLat = startPosition!.geometry!.location!.lat;
                    print("Start Lat $startPointLat");
                    startPointLong = startPosition!.geometry!.location!.lng;
                    print("Start Long $startPointLong");
                    destinationPointLat =
                        startPosition!.geometry!.location!.lat;
                    print("Destination Lat $startPointLong");
                    destinationPointLong =
                        startPosition!.geometry!.location!.lng;
                    print("Destination Long $startPointLong");
                    print(
                        "address is ${GetAddressFromLatLong(startPointLat, startPointLong)}");
                    tripSearch();
                  },
                  height: 40.h,
                  width: 150.w,
                  btnColor: navyBlueColor,
                  radius: 10.r,
                ),
              ),
            )
          ],
        ),
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
