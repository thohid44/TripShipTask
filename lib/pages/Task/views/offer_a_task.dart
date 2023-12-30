import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripshiptask/pages/Task/controller/task_seek_post.dart';

class OfferATask extends StatefulWidget {
  @override
  State<OfferATask> createState() => _OfferATaskState();
}

class _OfferATaskState extends State<OfferATask> {
  final controller = Get.put(TaskSeekPostController());
  final TextEditingController location = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController needhour = TextEditingController();

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

  String prefer = "Give Task To";

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
    List<DropdownMenuItem<String>> skills = [
      const DropdownMenuItem(
          child: Text("Skill required"), value: "Skill required"),
      const DropdownMenuItem(child: Text("1"), value: "1"),
    ];
    return skills;
  }

  String skill = "Skill required";

  String willing = "USD";
  final _startSearchFieldController = TextEditingController();

  final _endSearchFieldController = TextEditingController();

  DetailsResult? startPosition;

  late FocusNode startFocusNode;

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

  var categories = [
    {
      "id": 1,
      "name": "Assemble Furniture",
    },
    {
      "id": 2,
      "name": "Beauty Care",
    },
    {
      "id": 3,
      "name": "Caregiving (Elderlies/children)",
    },
    {
      "id": 4,
      "name": "Cooking",
    }
  ];
  var skills = [
    {
      "id": 1,
      "name": "Calm and composed",
    },
    {
      "id": 2,
      "name": "Neat and clean",
    },
    {
      "id": 3,
      "name": "Good looking",
    },
    {
      "id": 4,
      "name": "Punctual",
    },
    {
      "id": 5,
      "name": "Good sense of humor",
    },
    {
      "id": 6,
      "name": "Prompt",
    },
    {
      "id": 7,
      "name": "Responsible",
    }
  ];

  var genderList = [
    {
      "id": 1,
      "name": "Male",
    },
    {
      "id": 2,
      "name": "Female",
    },
    {
      "id": 3,
      "name": "Others",
    },
  ];
  var currencyList = [
    {
      "id": 1,
      "name": "USD",
    },
    {
      "id": 2,
      "name": "BD",
    },
    {
      "id": 3,
      "name": "IN",
    },
  ];
  String? classValue;
  var classId;
  String? selectedValue;

  bool isSelect = false;
  bool selectClass = false;
  var categoryId;
  var genderId;
  var gender;
  String? selectedGender;
  var categoryName;
  var selectcategory;
  bool isSelectSkill = false;
  var fullWidth = 306.w;
  var height = 3;
 int fontSize = 12; 
  @override
  Widget build(BuildContext context) {
    print("Id  from Main Page $categoryId");
    print("Id  from Main Page $gender");

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),

          Card(
            elevation: 5,
            child: Container(
                alignment: Alignment.center,
                height: 35.h,
                width: fullWidth,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5.r),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                      spreadRadius: 8, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(3, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: DropdownButton(
                    isExpanded: true,
                    hint: Text(
                      "${isSelect ? selectcategory : 'Select Category'}",
                      style: GoogleFonts.inter(
                          fontSize: fontSize.sp, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    underline: SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    value: classValue,
                    items: categories
                        .map((e) => DropdownMenuItem(
                              onTap: () {
                                selectcategory = e['name'].toString();
                              },
                              value: e['id'],
                              child: Text(
                                "${e['name']}",
                                style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.normal, fontSize: fontSize.sp ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      var id = value;
                      categoryId = value;
                      print("Category Id $id");
                      // _con.getClassId(value.toString());
                      setState(() {
                        classId = value.toString();
                        isSelect = true;
                      });
                    })),
          ),

          SizedBox(
            height: height.h,
          ),

          CustomTextForm(
            width: fullWidth,
            height: 30.w,
            textController: title,
            fontSize: fontSize.sp,
            hinttext: "Describe The Task",
          ),
          SizedBox(
            height: height.h,
          ),
       Material(
      elevation: 8,
      color: primaryColor,
      shadowColor: primaryColor,
      borderRadius: BorderRadius.circular(5),
            child: Container(
                alignment: Alignment.center,
                height: 38.h,
                width: fullWidth,
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
                ],
                    ),
                child: DropdownButton(
                    isExpanded: true,
                    hint: Text(
                      "${isSelectSkill ? selectSkill : 'Skill Required'}",
                      style: GoogleFonts.inter(
                          fontSize: fontSize.sp, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    underline: SizedBox(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    value: classValue,
                    items: skills
                        .map((e) => DropdownMenuItem(
                              onTap: () {
                                selectSkill = e['name'].toString();
                              },
                              value: e['id'],
                              child: Text(
                                "${e['name']}", style: GoogleFonts.inter(fontSize: fontSize.sp, fontWeight:FontWeight.normal),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      var id = value;
                      var skillId = value;
                      print("Skill Id $id");
                      // _con.getClassId(value.toString());
                      setState(() {
                        classId = value.toString();
                        isSelectSkill = true;
                      });
                    })),
          ),
          SizedBox(
            height: height.h,
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
                  child: Card(
                    elevation: 5,
                    child: Container(
                      width: 148.w,
                      height: 35.h,
                      alignment: Alignment.center,
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
                      child: dateStatus == false
                          ? Text(
                              "${pickDate.day}-${pickDate.month}-${pickDate.year}",
                              style: GoogleFonts.inter(
                                  fontSize:fontSize.sp, fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "${pickDate.day}-${pickDate.month}-${pickDate.year}",
                              style: GoogleFonts.inter(
                                  fontSize: fontSize.sp, fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ),
              
                InkWell(
                    onTap: _showTimePicker,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        alignment: Alignment.center,
                        width: 143.w,
                        height: 35.h,
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
                            ? Text(pickupTime!.format(context).toString())
                            : Text(
                                "Select Time",
                                style: GoogleFonts.inter(
                                    fontSize: fontSize.sp,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: height.h,
          ),
          CustomTextForm(
            width: fullWidth,
            height: 30.h,
            hinttext: "Task Duration (Default 1 Hour)",
            fontSize:fontSize.sp,
            textController: needhour,
          ),
          SizedBox(
            height: height.h,
          ),
          Card(
            elevation: 5,
            child: UnconstrainedBox(
              child: Container(
                width: fullWidth,
                height: 38.h,
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
                  controller: location,
                  autofocus: false,
                  focusNode: startFocusNode,
                  style: GoogleFonts.inter(fontSize:fontSize.sp, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                      hintText: 'Task Address / Location',
                      hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.normal, fontSize: fontSize.sp),
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
            ),
          ),
          SizedBox(
            height: height.h,
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
                    style: GoogleFonts.inter(fontSize: fontSize.sp, fontWeight:FontWeight.normal),
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
        
          SizedBox(
            height: height.h,
          ),
          UnconstrainedBox(
            child: Card(
              elevation: 5,
              child: Container(
                width: fullWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 38.h,
                      width: fullWidth,
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
                ],
                          ),
                      child: DropdownButton(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                          hint: Text(
                            "${isSelect ? selectedGender : 'Give Task To'}",
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.normal),
                          ),
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: classValue,
                          
                          isExpanded: true,
                          items: genderList
                              .map((e) => DropdownMenuItem(
                                    onTap: () {
                                      selectedGender = e['name'].toString();
                                      gender = e['name'].toString();
                                      print("Gender $gender");
                                    },
                                    value: e['id'],
                                    child: Text(
                                      "${e['name']}",
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            var id = value;
                            print("Gender Id $id");
                            // _con.getClassId(value.toString());
                            setState(() {
                              classId = value.toString();
                              
                              isSelect = true;
                            });
                          }),
                    ),
                    SizedBox(
                      height: height.h,
                    ),
                  ],
                ),
              ),
            ),
          ),

          UnconstrainedBox(
            child: Container(
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
              child: Row(
                
                children: [
                  CustomTextForm(
                    hinttext: "Amount Offering",
                    height: 30.h,
                    fontSize: 13.sp,
                    width: 251.w,
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                        alignment: Alignment.center,
                        height: 38.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(5.r)),
                        child: Text(
                          "BDT",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.normal),
                        )),
                  ),
                ],
              ),
            ),
          ),
          UnconstrainedBox(
            child: Card(
              elevation: 5,
              child: Container(
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
                child: TextFormField(
                  onChanged: (value) {
                    note = value;
                    print("note is $note");
                  },
                  decoration: InputDecoration(
                    hintText: "Note ",
                    hintStyle:
                        GoogleFonts.inter(fontSize: fontSize.sp, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  minLines: 1,
                  maxLines: 2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomButtonOne(
              title: "Submit",
              btnColor: navyBlueColor,
              height: 35.h,
              width: 130.w,
              radius: 10.r,
              onTab: () {
                var lat = startPosition!.geometry!.location!.lat;
                print("Start Lat $lat");
                var lng = startPosition!.geometry!.location!.lng;
                controller.seekTask(
                    selectSkill: selectSkill,
                    title: title.text.toString(),
                    category: categoryId.toString(),
                    location: location.text.toString(),
                    preferedGender: gender,
                    date: dateDairy,
                    time: tripTime,
                    details: note,
                    amount: amount.text.toString(),
                    lat: lat,
                    lng: lng,
                    hourAvailable: '5',
                    hourNeed: needhour.text.toString(),
                    postType: "offer",
                    country: "BD",
                    currency: currency,
                    moduleId: '3');

                40.h;
                150.w;
                navyBlueColor;
                10.r;
              }),
              SizedBox(
            height: 15.h,
          ),
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
