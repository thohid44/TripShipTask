import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/controller/vehicle_controller.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class GetARide extends StatefulWidget {
  @override
  State<GetARide> createState() => _GetARideState();
}

class _GetARideState extends State<GetARide> {
  final TextEditingController search = TextEditingController();

  bool isVehicleSelect = false;

  String? vehicle;
  var vehicleName;

  List<Map<String, dynamic>> vehicleitems = [
    {"id": 1, "name": "Car", "slug": "Car"},
    {"id": 2, "name": "Mini Van/Micro", "slug": "Mini Van/Micro"},
    {"id": 3, "name": "Motorcycle", "slug": "Motorcycle"},
    {"id": 4, "name": "Electric Scooter", "slug": "Electric Scooter"},
    {"id": 5, "name": "CNG/TukTuk", "slug": "CNG/TukTuk"},
    {"id": 6, "name": "Rickshaw", "slug": "Rickshaw"},
  ];
  bool isSeatSelect = false;
  String? seat;
  var availableSeat;
  List<Map<String, dynamic>> seatList = [
    {"id": 1, "name": "1", "slug": "1"},
    {"id": 2, "name": "2", "slug": "2"},
    {"id": 3, "name": "3", "slug": "3"},
    {"id": 4, "name": "4", "slug": "4"},
      {"id": 5, "name": "5", "slug": "5"},
    {"id": 6, "name": "6", "slug": "6"},
    {"id": 7, "name": "7", "slug": "7"},
  ];
  var preferToRide;
  String? prefer;
  bool isPreferSelect = false;
   List<Map<String, dynamic>> preferList = [
    {"id": 1, "name": "Male", "slug": "Male"},
    {"id": 2, "name": "Female", "slug": "Female"},
    {"id": 3, "name": "Both", "slug": "Both"},

  ];

  String? selectVehicle;
  String? selectPassenger;
  String? selectPrefer;

  var startPointLat;
  var startPointLong;
  var destinationPointLong;
  var destinationPointLat;

   final TextEditingController willPayAmount= TextEditingController();
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
var fullWidth = 300.w;
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
            height: 4.h,
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
                  hintText: 'Start Point',
                  hintStyle:
                      GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 13.sp),
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
            width: fullWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    dairyDatePicker(context);
                  },
                  child: Container(
                    width: 149.w,
                    height: 30.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(width: 0.5.w, color: Colors.grey)),
                    child: dateStatus == false
                        ? Text(
                            "Select Date",
                            style: GoogleFonts.inter(color: Colors.black, 
                                fontSize: 13.sp,
                               
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            "${pickDate.day}-${pickDate.month}-${pickDate.year}",  style: TextStyle(
                                fontSize: 13.sp,
                               
                                fontWeight: FontWeight.normal),),
                  ),
                ),
                InkWell(
                    onTap: _showTimePicker,
                    child: Container(
                      alignment: Alignment.center,
                      width: 149.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color:
                                primaryColor.withOpacity(0.5), // Shadow color
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: pickupTime != null
                          ? Text(pickupTime!.format(context).toString())
                          : Text("Select Time",  style: GoogleFonts.inter(color: Colors.black, 
                                fontSize: 13.sp,
                               
                                fontWeight: FontWeight.normal),),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
             width: fullWidth,
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
              style: GoogleFonts.inter(color: Colors.black, fontSize: 13.sp),
              decoration: InputDecoration(
                  hintText: 'Destination',
                  hintStyle:GoogleFonts.inter(color: Colors.black, 
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
            height: 130.h,
            width: fullWidth,
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
            height: 2.h,
          ),
          UnconstrainedBox(
            child: Container(
            width: fullWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 140.w,
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
                            style: GoogleFonts.inter(color: Colors.black, 
                                fontWeight: FontWeight.normal, fontSize: 12.sp),
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
                                      "${e['name']}",style: GoogleFonts.inter(
                                fontWeight: FontWeight.normal, fontSize: 12.sp),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              isVehicleSelect = true;
                            });
                          })),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                      width: 155.w,
                      alignment: Alignment.center,
                      height: 30,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: DropdownButton(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          isExpanded: true,
                          hint: Text(
                            "${isSeatSelect ==true? availableSeat : 'How Many Of You'}",
                            style: GoogleFonts.inter(color: Colors.black,
                                fontWeight: FontWeight.normal, fontSize: 12.sp),
                          ),
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: seat,
                          items: seatList
                              .map((e) => DropdownMenuItem(
                                    onTap: () {
                                      availableSeat = e['name'].toString();
                                      print("Available Seats  $availableSeat");
                                    },
                                    value: e['id'],
                                    child: Text(
                                      "${e['name']}",
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              isSeatSelect = true;
                            });
                          })),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
          width: fullWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 142.w,
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: DropdownButton(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        isExpanded: true,
                        hint: Text(
                          "${isPreferSelect ? preferToRide : 'Get Ride From'}",
                          style:GoogleFonts.inter(color: Colors.black,
                              fontWeight: FontWeight.normal, fontSize: 12.sp),
                        ),
                        underline: SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: seat,
                        items: preferList
                            .map((e) => DropdownMenuItem(
                                  onTap: () {
                                    preferToRide = e['name'].toString();
                                    print(
                                        "Prefer to get ride   $preferToRide");
                                  },
                                  value: e['id'],
                                  child: Text(
                                    "${e['name']}",
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            isPreferSelect = true;
                          });
                        })),
                SizedBox(
                  width: 1.w,
                ),
               CustomTextForm(
                height: 30.h, 
                width: 110.w, 
                hinttext: "willing To Pay",
                fontSize: 13.sp,
                textController: willPayAmount,
               ), 
                Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: purplColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Text(
                      "BDT",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
              width: fullWidth,
            child: TextFormField(
              
              controller: note,
              decoration: InputDecoration(
                hintText: "Note",
                
                hintStyle:  GoogleFonts.inter(
                                fontSize: 13.sp,
                               
                                fontWeight: FontWeight.normal),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              minLines: 1,
            ),
          ),
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
                  destinationPointLat = startPosition!.geometry!.location!.lat;
                  print("Destination Lat $startPointLong");
                  destinationPointLong = startPosition!.geometry!.location!.lng;
                  print("Destination Long $startPointLong");
                  print(
                      "address is ${GetAddressFromLatLong(startPointLat, startPointLong)}");

                  controller.getTripRide(
                    date: dateDairy.toString(),
                    time: tripTime.toString(),
                    duration: "2",
                    sPointLat: startPointLat,
                    sPointLng: startPointLong,
                    dPointLat: destinationPointLat,
                    dPointLng: destinationPointLong,
                    howmany: availableSeat,
                    note: note.text.toString(),
                    vehicled: vehicleName,
                    passengerType: preferToRide,
                    willPay: willPayAmount.text.toString(),
                    currency: "BDT",
                    country: "BD",
                    distance: "2",
                    startPoint: _startSearchFieldController.text.toString(),
                    des: _endSearchFieldController.text.toString(),
                  );
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
