import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/pages/Home/view/home_screen.dart';
import 'package:tripshiptask/profile/view/user_deshboard.dart';


AppBar customAppBar1() {


  return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          )),
      centerTitle: true,

      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              Get.to(HomeScreen());
            }, icon: Icon(Icons.home, size: 20.h, color: navyBlueColor,)),
            Text(
        "TripShipTask",
        
        
        style: TextStyle(color: Colors.black,),
      ),
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: (){

        }, icon: Icon(Icons.notifications, color: Colors.amber,)),
        IconButton(
            onPressed: () {
              Get.to(UserDeshBoard());
            },
            icon: Image.asset(
              "assets/menu_bar.jpeg",
              height: 15.h,
              fit: BoxFit.fitHeight,
            )),
      ],
    );
}

