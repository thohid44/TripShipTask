import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/pages/Home/trip_ship_task_home.dart';
import 'package:tripshiptask/pages/Home/view/home_screen.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/views/amar_pay_web_view.dart';
import 'package:tripshiptask/pages/Trip/views/trip_page.dart';
import 'package:http/http.dart' as http;
import '../../../profile/view/user_deshboard.dart';

class TripEPaymentPage extends StatefulWidget {
  String? bidId;

  TripEPaymentPage({super.key, this.bidId});

  @override
  State<TripEPaymentPage> createState() => _TripEPaymentPageState();
}

class _TripEPaymentPageState extends State<TripEPaymentPage> {
  var controller = Get.put(TripController());
  final _box = GetStorage();
  var paymentUrl;
  tripEPayment() async {
    var token = _box.read(LocalStoreKey.token);

    // try {
    var response = await http.post(Uri.parse("${baseUrl}payment"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: jsonEncode({
          "module": "trip",
          "post_type": "offer",
          "currency": "BDT",
          "bid": "8"
        }));

    print("Response code ${response.statusCode}");

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body.toString());
      setState(() {
        paymentUrl = jsonData['payment_url'];
      });
      print("Peyment Process $jsonData");
    }
    // } catch (e) {
    //   print("Error $e");
    // }
  }

  void initState() {
    tripEPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Trip Ship Task",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.to(HomeScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        actions: [
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
      ),
      body: Column(
        children: [
          Container(
            width: 306.w,
            alignment: Alignment.center,
            child: Text(
              "E-Payment Proccess",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Column(
              children: [
                CustomButtonOne(
                    title: "Go To Pay",
                    onTab: () {
                      if (paymentUrl != null) {
                        print("object $paymentUrl");
                           Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AmarPayWebView(url:"")),
                      );
                      }
                   
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
