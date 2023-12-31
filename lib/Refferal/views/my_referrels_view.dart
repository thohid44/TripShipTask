import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Refferal/controller/referrels_controller.dart';
import 'package:tripshiptask/Widget/app_bar_widget_1.dart';



class MyReferrelsPage extends StatefulWidget {
  const MyReferrelsPage({super.key});

  @override
  State<MyReferrelsPage> createState() => _MyReferrelsPageState();
}

class _MyReferrelsPageState extends State<MyReferrelsPage> {
  var controller = Get.put(ReferrelsController());

  void initState() {
    super.initState();
    controller.getMyReferrels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(),
      body: Obx(() => controller.isLoading.value == false
          ? Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: DataTable(
                headingRowHeight: 25.h,
                showCheckboxColumn: false,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.grey),
                columnSpacing: 100.w,
              
                horizontalMargin: 5,
                dataRowHeight: 20.h,
                border: TableBorder.all(width: 0.5.w),
                columns: <DataColumn>[
              
                  DataColumn(
                    
                      label:Text("Referee",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                                ),
                                numeric: false
                      ),
                  DataColumn(
                    
                      label: Text("signed Up ?",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500))),
                ],
                rows: controller.myReferrelsList
                    .map<DataRow>(
                      (e) => DataRow(cells: <DataCell>[
                    
                        DataCell(Text(e.email.toString(),
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal))),
                        DataCell(Text("Yes",
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal)))
                      ]),
                    )
                    .toList(),
              ),
            )
          : Center(child: CircularProgressIndicator())),
      floatingActionButton: FloatingActionButton.extended(
        
          backgroundColor: Color(0xff272e48),
          onPressed: () async {
            final _box = GetStorage(); 
          // //   Fluttertoast.showToast(msg: "msg")
          //   await ClickToCopy.copy(
          //       "https://app.tripshiptask.com/web/signup?referral_acc=${_box.read(LocalStoreKey.accountNo)}");
          },
          label: Text(
            "Copy invitation link",
            style: GoogleFonts.inter(color: Colors.white),
          ),
          
          ),
    );
  }
}
