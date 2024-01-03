import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/Refferal/controller/referrels_controller.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';

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
        appBar: customAppBar(),
        body: 
  Obx(() => controller.isLoading.value == false
                ? Padding( 
                  padding: EdgeInsets.only(left: 10.w),
                  child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                     columnSpacing: 25.w,
                      horizontalMargin: 5,
                      dataRowHeight: 20.h,
                      border: TableBorder.all(width: 0.5.w),
                      columns:  <DataColumn>[
                       
                        DataColumn(label: Text("Referrer Id",style: GoogleFonts.inter(
                          color: Colors.black, fontSize: 11.sp, fontWeight: FontWeight.w500
                        ),), 
                        ),
                        DataColumn(label: Text("Reference",style: GoogleFonts.inter(
                          color: Colors.black, fontSize: 11.sp, fontWeight: FontWeight.w500
                        ))),
                        DataColumn(label: Text("Mail Date",style: GoogleFonts.inter(
                          color: Colors.black, fontSize: 11.sp, fontWeight: FontWeight.w500
                        ))),
                      ],
                      rows: controller.myReferrelsList
                          .map<DataRow>(
                            (e) => DataRow(cells: <DataCell>[
                  
                                DataCell(Text(e.id.toString(),style: GoogleFonts.inter(
                          color: Colors.black, fontSize: 11.sp, fontWeight: FontWeight.normal
                        ))),
                             
                            
                              DataCell(Text(e.email.toString(),style: GoogleFonts.inter(
                          color: Colors.black, fontSize: 11.sp, fontWeight: FontWeight.normal
                        ))),
                              DataCell(Text(e.signup.toString(),style: GoogleFonts.inter(
                          color: Colors.black, fontSize: 11.sp, fontWeight: FontWeight.normal
                        )))
                            ]),
                          )
                          .toList(),
                    ),
                )
                : Center(child: CircularProgressIndicator())),
        
        
        
        );
  }
}

