import 'dart:async';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/controller/vehicle_controller.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/pages/Ship/model/ship_search_model.dart';
import 'package:tripshiptask/pages/Ship/views/ship_send_package_details.dart';
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
import 'package:tripshiptask/pages/Trip/views/trip_post_details_page.dart';

class ShipSendPackageSearch extends StatefulWidget {
  @override
  State<ShipSendPackageSearch> createState() => _ShipSendPackageSearchState();
}

class _ShipSendPackageSearchState extends State<ShipSendPackageSearch> {
  final TextEditingController search = TextEditingController();

  bool isVehicleSelect = false;

  String? vehicle;
  var vehicleName;

  List<Map<String, dynamic>> vehicleitems = [
    {"id": 1, "name": "Perishable", "slug": "Perishable"},
    {"id": 2, "name": "Non-perishable", "slug": "Non-perishable"},
  ];
  bool isSeatSelect = false;


 


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

  shipSendSearch() async {
    var token = _box.read(LocalStoreKey.token);
    print("search token $token");

    try {
      var startLats = startPosition!.geometry!.location!.lat;
      var startLong = startPosition!.geometry!.location!.lng;
      var endLat = endPosition!.geometry!.location!.lat;
      var endLong = endPosition!.geometry!.location!.lng;

      var response = await http.get(
        Uri.parse(
            "${baseUrl}ship-search?post_type=send_package"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
     
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        setState(() {
          status = true;
        });

        return ShipSearchListModel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  bool status = false;
  var fullWidth = 306.w;
  @override
  Widget build(BuildContext context) {
    var vehicleController = Get.put(VehicleController());
    vehicleController.getMyVehicles();
    //  print( vehicleController.myVehicles.first.type);
    var controller = Get.put(TripController());
    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 14.h,
          ),
          Row(
            children: [
                  Material(
                  elevation: 8,
                  color: primaryColor,
                  shadowColor: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 193.w,
                  height: 38.h,
                  child: TextField(
                    controller: _startSearchFieldController,
                    autofocus: false,
                    focusNode: startFocusNode,
                    style: GoogleFonts.inter(
                            fontWeight: FontWeight.normal,color: Colors.black, fontSize: 12.sp),
                    decoration: InputDecoration(
                        hintText: 'Pick Up',
                        hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.normal,color: Colors.black, fontSize: 12.sp),
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
              ),
              CustomTextForm(
                width: 60.w,
                height: 38.h,
                hinttext: "Radius",
              ),
              SizedBox(width: 1),
               Material(
                  elevation: 8,
                  color: primaryColor,
                  shadowColor: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                child: Container(
                  alignment: Alignment.center,
                  height: 38.h,
                  width: 45.w,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Text(
                    "Km",
                    style:
                       GoogleFonts.inter(
                              fontWeight: FontWeight.normal,color: Colors.black, fontSize: 12.sp),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: fullWidth,
            child: Row(
              children: [
                 Material(
                  elevation: 8,
                  color: primaryColor,
                  shadowColor: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 190.w,
                    height: 38.h,
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
                          hintText: 'Drop Off',
                          hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.normal, fontSize: 12.sp, color: Colors.black),
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
                        _debounce = Timer(const Duration(milliseconds: 1000), () {
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
                ),
                SizedBox(width: 1.w,),
                CustomTextForm(
                  width: 60.w,
                  height: 38.h,
                  hinttext: "Radius",
                  fontSize: 12.sp,
                ),
                SizedBox(width: 3.w),
                  Material(
                  elevation: 8,
                  color: primaryColor,
                  shadowColor: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    alignment: Alignment.center,
                    height: 38.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: primaryColor,
                    ),
                    child: Text(
                      "Km",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.normal,color: Colors.black, fontSize: 12.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: fullWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Material(
                  elevation: 8,
                  color: primaryColor,
                  shadowColor: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      width: 153.w,
                      alignment: Alignment.center,
                      height: 38.h,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: DropdownButton(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          isExpanded: true,
                          hint: Text(
                            "${isVehicleSelect ? vehicleName : 'Type of Goods'}",
                            style:     GoogleFonts.inter(
                              fontWeight: FontWeight.normal,color: Colors.black, fontSize: 12.sp),
                          ),
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: vehicle,
                          items: vehicleitems
                              .map((e) => DropdownMenuItem(
                                    onTap: () {
                                      vehicleName = e['name'].toString();
                                      print("Goods name $vehicleName");
                                    },
                                    value: e['id'],
                                    child: Text(
                                      "${e['name']}",
                                      style:    GoogleFonts.inter(
                              fontWeight: FontWeight.normal,color: Colors.black, fontSize: 12.sp),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              isVehicleSelect = true;
                            });
                          })),
                ),
                InkWell(
                  onTap: () {
                    dairyDatePicker(context);
                  },
                  child:   Material(
                  elevation: 8,
                  color: primaryColor,
                  shadowColor: primaryColor,
                  borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 140.w,
                      height: 38.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: primaryColor,
                        ),
                      child: dateStatus == false
                          ? Text(
                              "Select Date",
                              style:     GoogleFonts.inter(
                              fontWeight: FontWeight.normal,color: Colors.black, fontSize: 12.sp),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "${pickDate.day}-${pickDate.month}-${pickDate.year}"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
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
                              "Pick Up ${endPosition!.geometry!.location!.lat}");
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
            height: 15.h,
          ),
         
         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtonTwo(
                height: 35.h,
                width: 100.w,
                radius: 5.r,
                   fontSize: 12.sp,
                btnColor: navyBlueColor,
                fontWeight: FontWeight.w500,
                title: "Clear Search", onTab: (){
              
              }),
SizedBox(width: 10.w,), 
                CustomButtonTwo(
            height: 35.h,
            width: 100.w,
            fontSize: 12.sp,
             radius: 5.r,
             fontWeight: FontWeight.w500,
            btnColor: navyBlueColor,
            title: "Search", onTab: (){
    shipSendSearch();
          }),
            ],
          ),
        
          
          SizedBox(
            height: 10.h,
          ),
       status==false?Container(
        margin: EdgeInsets.only(top: 170.h),
        child: Text("Search Ship"),):   Expanded(
            child: FutureBuilder(
                future: shipSendSearch(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    print("Search ${snapshot.data.data.length}");

                    return ListView.builder(
                        itemCount: snapshot.data.data!.length,
                        itemBuilder: (context, index) {
                          var shipData = snapshot.data.data[index];
                              return Card(
                  child: Container(
                    width: 300.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(color: primaryColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 285.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    "Pick Up Point :",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  Expanded(
                                    child: Text(
                                      "${shipData.startPoint}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    "Drop Off: ",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  Expanded(
                                    child: Text(
                                      "${shipData.destination}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                children: [
                                  CustomText("Pick Up Date: ", Colors.black,
                                      FontWeight.bold, 12.sp),
                                  CustomText(
                                      "     ${DateFormat.yMMMd().format(DateTime.parse(shipData.pickupDate))} ",
                                      Colors.black,
                                      FontWeight.normal,
                                      12.sp),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                children: [
                                  CustomText("Delivery Up Date: ", Colors.black,
                                      FontWeight.bold, 12.sp),
                                  CustomText(
                                      "     ${DateFormat.yMMMd().format(DateTime.parse(shipData.deliveryDate))}",
                                      Colors.black,
                                      FontWeight.normal,
                                      12.sp),
                                ],
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                            "Offered Amt: ",
                                            Colors.black,
                                            FontWeight.bold,
                                            12.sp),
                                        CustomText("2000 ", Colors.black,
                                            FontWeight.normal, 12.sp),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(ShipSendPackageDetails(
                                            path:shipData
                                                [index].path
                                                .toString()));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 25.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                            color: navyBlueColor,
                                            borderRadius:
                                                BorderRadius.circular(5.r)),
                                        child: CustomText(
                                            "Details",
                                            Colors.white,
                                            FontWeight.bold,
                                            12.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                        });
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
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
