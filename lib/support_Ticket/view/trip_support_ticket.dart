import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripshiptask/Email_Verify/view/email_verification.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/Widget/customTextForm.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/support_Ticket/controller/support_controller.dart';

class OpenATicket extends StatefulWidget {
  const OpenATicket({super.key});

  @override
  State<OpenATicket> createState() => _OpenATicketState();
}

class _OpenATicketState extends State<OpenATicket> {
  var supportCon = Get.put(SupportController());
  final ImagePicker _picker = ImagePicker();
  var image;

  XFile? files;

  int showComment = 0;

  uploadTicketFile() async {
    final XFile tempImage =
        (await _picker.pickImage(source: ImageSource.camera))!;

    setState(() {
      image = tempImage.path;
      supportCon.file.value = image;
      files = tempImage;
      print(tempImage.name);
      print(image);
    });
  }

  var selectTicket;
  var selectCategoryType;
  bool isTicket = false;
  String? selectedTicketValue;
  @override
  Widget build(BuildContext context) {
    supportCon.getTicketCategory(); 
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 10.h,), 
            Card(
              elevation: 5,
              child: Container(
                  padding: EdgeInsets.only(left: 10.w),
                  decoration: BoxDecoration(color: primaryColor, boxShadow: [
                    BoxShadow(
                      color:
                          Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                      spreadRadius: 8, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(3, 5), // changes position of shadow
                    ),
                  ]),
                  alignment: Alignment.center,
                  height: 35.h,
                  width: 300.w,
                  child: DropdownButton(
                      isExpanded: true,
                      hint: Text(
                        "${isTicket ? selectTicket : "Select Department"}",
                        style: GoogleFonts.inter(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                      underline: SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      value: selectedTicketValue,
                      items: supportCon.ticketCategoryList
                          .map((e) => DropdownMenuItem(
                                onTap: () {
                                  selectTicket = e.name;
                                },
                                value: e.id,
                                child: Text(
                                  "${e.name}",
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        var id = value;
                        setState(() {
                          isTicket = true;
                        });
                        supportCon.category.value = id.toString();
                        print("Ticket Id ${supportCon.category.value}");
                      })),
            ),
            SizedBox(
              height: 5.h,
            ),
            // CustomTextForm(
            //   width: 300.w,
            //   height: 30.h,
            //   hinttext: "Subject",
            //   onChanged: (value) {
            //     supportCon.subject.value = value;
            //     print("Subject ${supportCon.subject.value}");
            //   },
            // ),
            SizedBox(
              height: 5.h,
            ),
            Card(
              elevation: 5,
              child: Container(
                width: 300.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffF1F4F9)
                            .withOpacity(0.5), //color of shadow
                        spreadRadius: 8, //spread radius
                        blurRadius: 7, // blur radius
                        offset: Offset(3, 5), // changes position of shadow
                   
                      ),
                    ]),
                child: TextFormField(
                  autofocus: false,
                  style: TextStyle(fontSize: 12.sp),
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: GoogleFonts.inter(
                        fontWeight: FontWeight.normal, fontSize: 12.sp),
                    filled: true,
                    fillColor: primaryColor,
                    border: InputBorder.none,
                  ),
                  minLines: 4,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "errorMsg";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    supportCon.message.value = value;
                    print("Message ${supportCon.message.value}");
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomTextForm(
              width: 300.w,
              height: 35.h,
              hinttext: "Reference Link or Post id",
              onChanged: (value) {
                supportCon.refLink.value = value;
                print("Reference  ${supportCon.refLink.value}");
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 300.w,
              height: 35.h,
              decoration: BoxDecoration(
                border: Border.all(width: 0.4.w, color: Colors.grey),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      uploadTicketFile();
                    },
                    child: Container(
                      width: 100.w,
                      alignment: Alignment.centerLeft,
                      height: 35.h,
                      padding: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        border: Border(
        
            right: BorderSide(width: 2.0, color: Colors.amber),
          ),
                      ),
                      child: Text(
                        'Choose File',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5.w),
                    height: 35.h,
                    decoration: BoxDecoration(),
                    child: image != null
                        ? Text(
                            "File Selected",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            "No File Chosen",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.normal,
                              fontSize: 10.sp,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButtonOne(
                title: "Submit",
                btnColor: navyBlueColor,
                height: 35.h,
                width: 130.w,
                radius: 10.r,
                fontSize: 13.sp,
                onTab: () {
                  supportCon.supportSumbit();

                  40.h;
                  150.w;
                  navyBlueColor;
                  10.r;
                }),
          ],
        ),
      ),
    );
  }
}
