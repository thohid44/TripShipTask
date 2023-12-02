import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/pages/Ship/views/shipPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripshiptask/pages/Task/controller/task_controller.dart';

class WantATask extends StatefulWidget {
  @override
  State<WantATask> createState() => _WantATaskState();
}

class _WantATaskState extends State<WantATask> {
  final controller = Get.put(TaskController());
  final TextEditingController location = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();
  //Calm and composed, Neat and clean, Punctual
  String category = "";
  var note = "";

  var hourAvailable = '';
  var hourNeed = "";
  var postType = "";
  var country = "";
  var currency = '';
  var preferedGender = '';
  var moduleId = "";
  var selectSkill = "";
  final TextEditingController search = TextEditingController();

  List preferGetRide = [
    "male",
    "Female",
  ];

  String prefer = "Prefer to give Task to";

  List<DropdownMenuItem<String>> get categoryList {
    List<DropdownMenuItem<String>> categories = [
      const DropdownMenuItem(
          child: Text("Select Category"), value: "Select Category"),
      const DropdownMenuItem(child: Text("Cooking"), value: "1"),
      const DropdownMenuItem(child: Text("Grocery Shoping"), value: "2"),
    ];
    return categories;
  }

  var selectCategory = '';

  List<DropdownMenuItem<String>> get skillList {
    List<DropdownMenuItem<String>> categories = [
      const DropdownMenuItem(
          child: Text("Skill required"), value: "Skill required"),
      const DropdownMenuItem(child: Text("1"), value: "1"),
    ];
    return categories;
  }

  String skill = "Skill required";

  List<DropdownMenuItem<String>> get willingPay {
    List<DropdownMenuItem<String>> destination = [
      const DropdownMenuItem(child: Text("USD"), value: "USD"),
      const DropdownMenuItem(child: Text("BD"), value: "BD"),
    ];
    return destination;
  }

  String willing = "USD";
  final _startSearchFieldController = TextEditingController();

  final _endSearchFieldController = TextEditingController();

  DetailsResult? startPosition;

  late FocusNode startFocusNode;

  late GooglePlace googlePlace;
  String? selectPrefer;
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startFocusNode.dispose();
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          // Card(
          //   child: Container(
          //     alignment: Alignment.center,
          //     height: 35.h,
          //     width: 320.w,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey),
          //         borderRadius: BorderRadius.circular(10.r)),
          //     child: DropdownButton(
          //       hint: selectCategory !=null ? Text(
          //         "Select a ",
          //         style: TextStyle(color: Colors.black),
          //       ):const Text(
          //         "Select a Category",
          //         style: TextStyle(color: Colors.black),
          //       ),
          //       underline: SizedBox(),
          //       padding: EdgeInsets.only(left: 5.w),
          //       icon: Icon(Icons.arrow_drop_down_outlined),
          //       isExpanded: true,
          //       style: TextStyle(
          //           fontSize: 12.sp,
          //           fontWeight: FontWeight.normal,
          //           color: Colors.black),
          //       value: category,
          //       onChanged: (value) {
          //         selectCategory = value!;
          //       },
          //       items: categoryList,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 5.h,
          ),

          CustomTextForm(
            width: 300.w,
            textController: title,
            hinttext: "Title of the task g",
          ),
          SizedBox(
            height: 5.h,
          ),
          Card(
            child: Container(
              width: 320.w,
              alignment: Alignment.center,
              height: 35.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r)),
              child: DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                value: skill,
                onChanged: (value) {},
                items: skillList,
              ),
            ),
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
            height: 5.h,
          ),
          Container(
              width: 320.w,
              height: 35.h,
              alignment: Alignment.center,
              child: CustomForm(
                hinttext:
                    "No of hours needed to carry out the task(dy default 1hr) ",
                radius: 5.r,
                textController: search,
              )),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: 300.w,
            height: 35.h,
            child: TextField(
              controller: location,
              autofocus: false,
              focusNode: startFocusNode,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                  hintText: 'Location',
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
                      } else {}
                    }
                  },
                );
              }),
          // End Suggestion List
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 5.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
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
                  // items: preferGetRide
                  //     .map((String item) => DropdownMenuItem<String>(
                  //           value: item,
                  //           child: Text(
                  //             item,
                  //             style: TextStyle(
                  //               fontSize: 13.sp,
                  //             ),
                  //           ),
                  //         ))
                  //     .toList(),
                  items: preferGetRide
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              "${item}",
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
            height: 5.h,
          ),
          Container(
              width: 90.w,
              height: 35.h,
              child: CustomForm(
                hinttext: "Offering Amount",
                radius: 5.r,
                textController: title,
              )),
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
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                value: willing,
                onChanged: (value) {},
                items: willingPay,
              ),
            ),
          ),

          SizedBox(
            height: 5.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextFormField(
              onChanged: (value) {
                note = value;
                print("note is $note");
              },
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
              btnColor: navyBlueColor,
              onTab: () {
                var lat = startPosition!.geometry!.location!.lat;
                print("Start Lat $lat");
                var lng = startPosition!.geometry!.location!.lng;
                controller.postTask(
                    selectSkill: selectSkill,
                    title: title.text.toString(),
                    category: category,
                    location: location.text.toString(),
                    preferedGender: preferedGender,
                    date: dateDairy,
                    time: tripTime,
                    details: note,
                    amount: amount,
                    lat: lat,
                    lng: lng,
                    hourAvailable: hourAvailable,
                    hourNeed: hourNeed,
                    postType: postType,
                    country: country,
                    currency: currency,
                    moduleId: 3);

                40.h;
                150.w;
                navyBlueColor;
                10.r;
              }),
        ],
      ),
    );
  }

  // String? selectedDates;

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
        print("Date $dateDairy");
      });
    }
  }

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
