import 'dart:async';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripshiptask/pages/Task/controller/task_controller.dart';
import '../model/my_task_details_model.dart';
import 'package:http/http.dart' as http;

class UpdateOfferTask extends StatefulWidget {
  String path;
  UpdateOfferTask(this.path);
  @override
  State<UpdateOfferTask> createState() => _UpdateOfferTaskState();
}

class _UpdateOfferTaskState extends State<UpdateOfferTask> {
  final controller = Get.put(TaskController());

  final TextEditingController location = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController needhour = TextEditingController();

  //Calm and composed, Neat and clean, Punctual
  String category = "";
  var note;
  var locations;
  var hourAvailable = '';
  var amt;
  var needhours;
  var postType = "";
  var country = "";
  var currency = '';
  var preferedGender = '';
  var moduleId = "";
  var selectSkill;
  String titles = '';

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

  final _box = GetStorage();
  Future<MyTaskDetailsModel> gettaskDetails() async {
    //print("koli path ${widget.path}");
    var token = _box.read(LocalStoreKey.token);

    var response = await http.get(
      Uri.parse("${urlWithOutslash}${widget.path}"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    );
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print("koli2 $jsonData");
    }
    return MyTaskDetailsModel.fromJson(jsonData);
  }

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyDLMJOClhhQjkfepu0R8iOCIt7bUpUF0nU';
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
  }

  var task;

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
  @override
  Widget build(BuildContext context) {
    print("Id  from Main Page $categoryId");
    print("Id  from Main Page $gender");
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: gettaskDetails(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var task = snapshot.data.myTaskDetailsModel;

                return Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 300.w,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "Select Category",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ),
                    UnconstrainedBox(
                      child: Container(
                          alignment: Alignment.center,
                          height: 35.h,
                          width: fullWidth,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffF1F4F9)
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 8, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(
                                      3, 5), // changes position of shadow
                                ),
                              ]),
                          child: DropdownButton(
                              isExpanded: true,
                              hint: Text(
                                  "${isSelect ? selectcategory : 'Select Category'}"),
                              underline: SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              value: classValue,
                              items: categories
                                  .map((e) => DropdownMenuItem(
                                        onTap: () {
                                          selectcategory = e['name'].toString();
                                        },
                                        value: e['id'],
                                        child: Text(
                                          "${e['name']}",
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
                    Container(
                      width: 300.w,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "Describe The Task",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ),

                    CustomTextForm(
                      width: fullWidth,
                      height: 30.w,
                      textController: title,
                      fontSize: 12.sp,
                      hinttext: "${task.title.toString()}",
                      onChanged: (value) {
                        titles = value;
                      },
                    ),
                    SizedBox(
                      height: height.h,
                    ),
                    UnconstrainedBox(
                      child: Card(
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
                                  color: Color(0xffF1F4F9)
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 8, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(
                                      3, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  "${isSelectSkill ? selectSkill : 'Skill Required'}",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                underline: SizedBox(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                value: classValue,
                                items: skills
                                    .map((e) => DropdownMenuItem(
                                          onTap: () {
                                            selectSkill = e['name'].toString();
                                            print("select Skill $selectSkill");
                                          },
                                          value: e['id'],
                                          child: Text(
                                            "${e['name']}",
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
                    ),
                    SizedBox(
                      height: height.h,
                    ),
                    Container(
                      width: 300.w,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "Select Date",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      width: fullWidth,
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
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Color(0xffF1F4F9)
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 8, //spread radius
                                  blurRadius: 7, // blur radius
                                  offset: Offset(
                                      3, 5), // changes position of shadow
                                ),
                              ]),
                              child: dateStatus == false
                                  ? Text(
                                      "${DateFormat.yMMMd().format(task.date)} ",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "${pickDate.day}-${pickDate.month}-${pickDate.year}"),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          InkWell(
                              onTap: _showTimePicker,
                              child: Container(
                                alignment: Alignment.center,
                                width: 150.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5.w, color: Colors.grey)),
                                child: pickupTime != null
                                    ? Text(
                                        pickupTime!.format(context).toString())
                                    : Text("${task.time}"),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: 300.w,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "Task Duration (Default 1 Hour)",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ),
                    CustomTextForm(
                      width: fullWidth,
                      height: 30.h,
                      hinttext: "${task.hourNeed}",
                      fontSize: 11.sp,
                      textController: needhour,
                      onChanged: (value) {
                        needhours = value;
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: 300.w,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "Task Address / Location",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      width: fullWidth,
                      height: 30.h,
                      child: TextField(
                        controller: location,
                        autofocus: false,
                        focusNode: startFocusNode,
                        style: TextStyle(fontSize: 15.sp),
                        decoration: InputDecoration(
                            hintText: '${task.location}',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 11.sp),
                            filled: true,
                            fillColor: primaryColor,
                            border: InputBorder.none,
                            suffixIcon:
                                _startSearchFieldController.text.isNotEmpty
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
                          locations = value;
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(milliseconds: 1000), () {
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

                              final details =
                                  await googlePlace.details.get(placeId);

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
                                } else {}
                              }
                            },
                          );
                        }),
                    // End Suggestion List
                    Container(
                      width: fullWidth,
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

                    Container(
                      width: 300.w,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "Give Task To",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 35.h,
                      width: fullWidth,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.r)),
                      child: DropdownButton(
                          hint: Text(
                            "${isSelect ? selectedGender : '${task.preferredGender}'}",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
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

                    Container(
                      width: 300.w,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "Amount Offering",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ),

                    Container(
                      width: fullWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextForm(
                            hinttext: "${task.amount}",
                            height: 30.h,
                            width: 251.w,
                            textController: amount,
                            onChanged: (value) {
                              amt = value;
                              print("Amount $value");
                            },
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                                alignment: Alignment.center,
                                height: 30.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: purplColor,
                                    border: Border.all(color: purplColor),
                                    borderRadius: BorderRadius.circular(5.r)),
                                child: Text(
                                  "BDT",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 300.w,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      child: Text(
                        "Note",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      width: fullWidth,
                      child: TextFormField(
                        onChanged: (value) {
                          note = value;
                          print("note is $note");
                        },
                        decoration: InputDecoration(
                          hintText: "${task.note}",
                          border: OutlineInputBorder(),
                        ),
                        minLines: 1,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomButtonOne(
                        title: "Update",
                        btnColor: navyBlueColor,
                        height: 35.h,
                        width: 130.w,
                        radius: 10.r,
                        onTab: () {
                          // var lat = startPosition!.geometry!.location!.lat;
                          // print("Start Lat $lat");
                          // var lng = startPosition!.geometry!.location!.lng;

                          controller.updateGiveTask(
                            slug: task.slug,
                            selectSkill:
                                selectSkill.isEmpty ? task.skills : selectSkill,
                            title:
                                titles.isEmpty ? task.title.toString() : titles,
                            category:
                                categoryId == null ? task.category : categoryId,
                            location: locations ?? task.location,
                            preferedGender: gender ?? task.preferredGender,
                            date: dateDairy ?? task.date,
                            time: tripTime ?? task.time,
                            details: note ?? task.note,
                            amount: amt ?? task.amount,
                            lat: startPosition?.geometry?.location?.lat
                                    .toString() ??
                                task.latLng['lat'],
                            lng: startPosition?.geometry?.location?.lng
                                    .toString() ??
                                task.latLng['lng'],
                            hourAvailable: '2',
                            hourNeed: needhours ?? task.hourNeed,
                            postType: "offer",
                            country: "BD",
                            currency: currency,
                            moduleId: '3',
                          );

                          40.h;
                          150.w;
                          navyBlueColor;
                          10.r;
                        }),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                );
              }
              return Container(
                height: 500.h,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
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
