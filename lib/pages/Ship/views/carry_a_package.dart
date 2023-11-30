import 'dart:math';

import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Trip/views/trip_page.dart';
import '../controller/carry_package_controller.dart';

class CarryAPackage extends StatefulWidget {
  @override
  State<CarryAPackage> createState() => _CarryAPackageState();
}

class _CarryAPackageState extends State<CarryAPackage> {
  var controller = Get.put(CarryPackageController());

  final TextEditingController search = TextEditingController();

  final TextEditingController pickup = TextEditingController();
  final TextEditingController dropoffpoint = TextEditingController();
  final TextEditingController note = TextEditingController();

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
      const DropdownMenuItem(child: Text("Type 1"), value: "Type 1"),
      const DropdownMenuItem(child: Text("Type 2"), value: "Type 2"),
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

  String currency = "USD";
  DateTime _dates = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Container(
            width: 320.w,
            height: 35.h,
            child: CustomForm(
              hinttext: "Pick Up",
              radius: 5.r,
              textController: search,
            )),

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
                  pickUpDatePicker(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  width: 155.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: pickStatus == true
                      ? Text(
                          "${pickDate.year}-${pickDate.month}-${pickDate.day}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : Text(" Pick Up Date"),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: () {
                  deliveryDatePicker(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  width: 155.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Text(
                    "${deliveryDate.hour}-${deliveryDate.minute}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
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
            width: 320.w,
            height: 35.h,
            alignment: Alignment.center,
            child: CustomForm(
              hinttext: "Preferred Drop Off(Optional) ",
              radius: 5.r,
              textController: dropoffpoint,
            )),
        SizedBox(
          height: 5.h,
        ),
        // Container(
        //   color: Colors.grey,
        //   height: 200,
        //   width: 320.w,
        // ),
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
                  deliveryDatePicker(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  width: 155.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: deliveryStatus == false
                      ? Text(
                          "${deliveryDate.year}-${deliveryDate.month}-${deliveryDate.day}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      : Text("Perferred delivery date"),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: _showTimePicker,
                child: Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Text("data")),
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
                  width: 90.w,
                  alignment: Alignment.center,
                  child: Text(
                    "Asking amount",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
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
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                    value: currency,
                    onChanged: (value) {
                      currency = value!;
                      print(currency);
                    },
                    items: willingPay,
                  ),
                ),
              ),
              InkWell(
                onTap: _showTimePicker,
                child: Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 155.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Text("data")),
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
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                height: 35.h,
                width: 320.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.r)),
                child: DropdownButton(
                  isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                  value: packageType,
                  onChanged: (value) {
                    packageType = value!;
                    print(packageType);
                  },
                  items: packageTypes,
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
            maxLines: 3,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomButtonOne(
          title: "Sumbit",
          onTab: () {
            print(pickDate);
            print(deliveryDate);

            controller.carryPackage(
                pickup.toString(),
                pickDate.toString(),
                pickupTime,
                dropoffpoint.toString(),
                deliveryDate,
                delivaryTime,
                currency,
                packageType,
                note.text.toString());
          },
          height: 40.h,
          width: 150.w,
          btnColor: navyBlueColor,
          radius: 10.r,
        )
      ],
    );
  }

  bool pickStatus = false;
  bool deliveryStatus = false;
  DateTime pickDate = DateTime.now();
  DateTime deliveryDate = DateTime.now();
  String? selectedDateForBackendDeveloper;
  pickUpDatePicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: pickDate,
      // firstDate: DateTime(2022),
      firstDate: DateTime.now(),
      // firstDate: DateTime(2022, 9, 15),

      // lastDate: DateTime(3000),

      lastDate: DateTime(2030, 01, 01),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        pickStatus = true;
        pickDate = userSelectedDate;

        selectedDateForBackendDeveloper =
            "${pickDate.year}-${pickDate.month}-${pickDate.day}";
        print("Date $selectedDateForBackendDeveloper");
      });
    }
  }

  deliveryDatePicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: deliveryDate,
      // firstDate: DateTime(2022),
      firstDate: DateTime.now(),
      // firstDate: DateTime(2022, 9, 15),

      // lastDate: DateTime(3000),

      lastDate: DateTime(2030, 01, 01),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        deliveryStatus = true;
        deliveryDate = userSelectedDate;

        selectedDateForBackendDeveloper =
            "${deliveryDate.year}-${deliveryDate.month}-${deliveryDate.day}";
        print("Date $selectedDateForBackendDeveloper");
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
