import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/support_Ticket/view/trip_support_ticket.dart';

import '../controller/support_controller.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({super.key});

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  @override
  var controller = Get.put(SupportController());

  Widget build(BuildContext context) {
    controller.getMyTicket();
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar(),
      body: Obx(() => controller.isMyLoading.value == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.myTicketsModel!.data!.length,
              itemBuilder: (context, index) {
                return Container(
                 
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Card(
                  child: ListTile(
                    title: Text(
                      "${controller.myTicketsModel!.data![index].message.toString()}",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ));
              })),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(OpenATicket());
          },
          label: Text(
            "Open a Ticket",
            style: GoogleFonts.inter(),
          )),
    ));
  }
}
