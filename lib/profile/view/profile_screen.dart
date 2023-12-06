import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar: AppBar(
          elevation: 0,
          
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
              flexibleSpace: Container(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter,
                  color: Colors.black,
                )),
          ],
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       
          Card(
            child: Row(
              children: [
                Container(
                  width: 60.w, 
                  height: 60.h,
                  decoration:const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle
                  ),
                    child: Image.asset("assets/person.png"),
                ), 
                Container(
                  child: Column(
                    children: [
                       Container(
              child: Text(
                "John Little",
                style: TextStyle(fontSize: 15.sp, color: Colors.black),
              ),
            ),
            Container(
              child: Text(
                "Acct.12345",
                style: TextStyle(fontSize: 15.sp, color: Colors.black),
              ),
            ),
                    ],
                  ),
                )
              ],
            ),
          ), 
          SizedBox(
            height: 20.h,
          ),
        
           ProfileItem(
            title: "Full Name:",
            value: "Waleed Amin",
             space: 15.w,
          ),
           ProfileItem(
            title: "Phone:",
            value: "01822909090",
             space: 15.w,
          ), ProfileItem(
            title: "Email:",
            value: "WaleedAmin@gmail.com",
             space: 15.w,
          ),
           ProfileItem(
            title: "Gender:",
            value: "Male",
            space: 15.w,
          ),
           ProfileItem(
            title: "DOB:",
            value: "10/11/1971",
             space: 15.w,
          ),
           ProfileItem(
            title: "Education:",
            value: "B.Sc",
             space: 15.w,
          ), ProfileItem(
            title: "Profession:",
            value: "Engineer",
             space: 15.w,
          ),
           ProfileItem(
            title: "Blood Group:",
            value: "",
            space: 15.w,
          ),
           ProfileItem(
            title: "Residence Area:",
            value: "Chittagong",
             space: 15.w,
          ),
           ProfileItem(
            title: "Emergency Contact Person:",
            value: "01822909090",
             space: 15.w,
          ), ProfileItem(
            title: "Emergency Contact Number:",
            value: "Waleed Amin",
             space: 15.w,
          )
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  String? title;
  String? value;
  double? space;

  ProfileItem({
    super.key,
    this.title, this.value, this.space
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                title??"Title",
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ),
           
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                value??"Value",
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
