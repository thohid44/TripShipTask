import 'dart:math';

import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';

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
var fullwidth = 306; 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        CustomTextForm(
            width: fullwidth.w,
              hinttext: "Pick Up Point",
              fontSize: 13.sp,
              textController: pickup,
            ),

        SizedBox(
          height: 5.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: fullwidth.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    pickUpDatePicker(context);
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: primaryColor,
                          border: Border.all(width: 1.w, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.r)),
                      child: pickStatus == true
                          ? Text(
                              "${pickDate.year}-${pickDate.month}-${pickDate.day}",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            )
                          : Text("Pick Up Date",  style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,),
                    ),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                InkWell(
                  onTap: () {
                    deliveryDatePicker(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    width: 149.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Text(
                      "${deliveryDate.hour}-${deliveryDate.minute}",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
      CustomTextForm(
         width: fullwidth.w,
         height: 30.h,
              hinttext: "Preferred Drop Off(Optional) ",
             fontSize: 13.sp,
              textController: dropoffpoint,
            ),
        SizedBox(
          height: 5.h,
        ),
      
      

        Container(
         width: fullwidth.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  deliveryDatePicker(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 149.w,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.w, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.r)),
                  child: deliveryStatus == false
                      ? Text(
                          "${deliveryDate.year}-${deliveryDate.month}-${deliveryDate.day}",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        )
                      : Text("Perferred delivery date",  style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              InkWell(
                onTap: _showTimePicker,
                child: Container(
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Text("Select Time",  style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        UnconstrainedBox(
          child: Container(
            width: fullwidth.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
                CustomTextForm(
                  width: 120.w, 
                  height: 30.h, 
                  hinttext: "Asking amount", 
                  fontSize: 13.sp, 
                ),
               Card(
                elevation: 5,
                 child: Container(
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: purplColor,
                      ),
                      child: Text(
                        "BDT",
                        style: TextStyle(color: Colors.white,   fontSize: 12.5.sp,),
                      )),
               ),
                InkWell(
                  onTap: _showTimePicker,
                  child: Container(
                      alignment: Alignment.center,
                      height: 35.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.w, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Text("Select Time")),
                ),
              ],
            ),
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
