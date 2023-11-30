import 'dart:async';

import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class TripSingleSearchPage extends StatefulWidget {
  @override
  State<TripSingleSearchPage> createState() => _TripSingleSearchPageState();
}

class _TripSingleSearchPageState extends State<TripSingleSearchPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  final TextEditingController keywords = TextEditingController();
  final TextEditingController _location = TextEditingController();

  List<Map<String, dynamic>> items = [
    {"id": 1, "name": "Vaccination", "slug": "vaccination"},
    {"id": 2, "name": "Deworming", "slug": "deworming"},
    {"id": 3, "name": "Tick & Flea", "slug": "tick_flea"},
  ];
  var selectCategory;
  var isSelect = false;
  var categoryId;
  String? categoryValue;
  var categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 105.h,
          ),
          SizedBox(
            height: 5.h,
          ),
          _textInputForm(
            icon: Icon(Icons.search),
            hint: "Keywords",
            controller: keywords,
          ),
          SizedBox(
            height: 10.h,
          ),
          _textInputForm(
            icon: Icon(Icons.search),
            hint: "Location",
            controller: _location,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                    width: 150.w,
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        isExpanded: true,
                        hint: Text(
                          "${isSelect ? categoryName : 'Select Category'}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14.sp),
                        ),
                        underline: SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: categoryValue,
                        items: items
                            .map((e) => DropdownMenuItem(
                                  onTap: () {
                                    categoryName = e['name'].toString();
                                  },
                                  value: e['id'],
                                  child: Text(
                                    "${e['name']}",
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            categoryId = value.toString();
                            isSelect = true;
                          });
                        })),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: () {
                    dairyDatePicker(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      children: [
                        Container(
                          width: 130.w,
                          height: 40.h,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10.w),
                          child: dateStatus == false
                              ? Text(
                                  "Date",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  "${pickDate.day}-${pickDate.month}-${pickDate.year}"),
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomButtonOne(
            title: "Sumbit",
            onTab: () {},
            height: 35.h,
            width: 150.w,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            btnColor: navyBlueColor,
            radius: 10.r,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomButtonOne(
            title: "Clear Search",
            onTab: () {
              _location.clear();
              keywords.clear();
              setState(() {});
            },
            height: 35.h,
            width: 150.w,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
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

Widget _textInputForm({controller, hint, icon, inputAction, userErrorText}) {
  return Container(
    height: 40.h,
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.r))),
    child: TextFormField(
      textInputAction: inputAction,
      validator: (value) {
        if (value!.isEmpty) {
          return userErrorText;
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon,
          hintStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            gapPadding: 4.6,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: Colors.lightBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w)),
    ),
  );
}
