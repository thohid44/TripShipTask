import 'dart:async';
import 'dart:convert';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customText.dart';
import 'package:tripshiptask/Widget/custom_text_field.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/model/trips_search_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_give_search_page.dart';

import 'package:tripshiptask/pages/Trip/views/give_A_ride/trip_post_page.dart';

class TripSecondHomePage extends StatefulWidget {
  @override
  State<TripSecondHomePage> createState() => _TripSecondHomePageState();
}

class _TripSecondHomePageState extends State<TripSecondHomePage> {
  final TextEditingController search = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItem {
    List<DropdownMenuItem<String>> startPoint = [
      const DropdownMenuItem(child: Text("km"), value: "km"),
      const DropdownMenuItem(child: Text("feet"), value: "feet"),
    ];
    return startPoint;
  }

  String startPoint = "km";

  List<DropdownMenuItem<String>> get dropdownItem2 {
    List<DropdownMenuItem<String>> desRedious = [
      const DropdownMenuItem(child: Text("km"), value: "km"),
      const DropdownMenuItem(child: Text("feet"), value: "feet"),
    ];
    return desRedious;
  }

  List<DropdownMenuItem<String>> get selectVehicle {
    List<DropdownMenuItem<String>> destination = [
      const DropdownMenuItem(child: Text("select"), value: "select"),
      const DropdownMenuItem(
          child: Text("tripshiptask"), value: "tripshiptask"),
    ];
    return destination;
  }

  String vehicle = "select";
  bool searchStatus = false;
  var startkm = '';
  var deskm = '';
  var startRadius = '';
  var desRadius = '';
  var startPoints = '';
  var destionaPoint = '';
  var tripContrller = Get.put(TripController());

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

// Search Place
  final _startSearchFieldController = TextEditingController();
  final _endSearchFieldController = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

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

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Container(height: 600.h, child: giveTripList[index])],
    );
  }

  List<Widget> giveTripList = [TripGivePosts(), TripGiveSearchPage()];

  showPlaces({required context}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 5,
              clipBehavior: Clip.hardEdge,
              //  shadowColor: yelloColor,
              // title: Text("Success"),
              contentPadding: EdgeInsets.all(8.0.h),
              actionsAlignment: MainAxisAlignment.center,
              content: Container(
                  alignment: Alignment.center,
                  height: 120.h,
                  padding: EdgeInsets.only(top: 10.h),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                  child: Column(
                    children: [],
                  )));
        });
  }
}
