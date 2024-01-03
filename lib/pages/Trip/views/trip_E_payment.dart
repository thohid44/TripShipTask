import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/Widget/customButtonOne.dart';
import 'package:tripshiptask/pages/Home/view/home_screen.dart';
import 'package:tripshiptask/pages/Ship/views/web_view_payment.dart';
import 'package:tripshiptask/pages/Trip/Controller/TripController.dart';
import 'package:tripshiptask/pages/Trip/views/amar_pay_web_view.dart';
import 'package:http/http.dart' as http;
import '../../../profile/view/user_deshboard.dart';

class TripEPaymentPage extends StatefulWidget {
  String? bidId;
  String? postType;
  String? module;
  TripEPaymentPage({super.key, this.bidId, this.postType, this.module});

  @override
  State<TripEPaymentPage> createState() => _TripEPaymentPageState();
}

class _TripEPaymentPageState extends State<TripEPaymentPage> {
  var controller = Get.put(TripController());
  final _box = GetStorage();
  var paymentUrl;
  var jsonData;
  tripEPayment() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      var response = await http.post(Uri.parse("${baseUrl}payment"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            "module": "ship",
            "post_type": "${widget.postType}",
            "currency": "BDT",
            "bid": "${widget.bidId}"
          }));

      print("Response code ${response.statusCode}");
      jsonData = jsonDecode(response.body);

      print("body ${response.body}");
      if (response.statusCode == 200) {
        setState(() {
          paymentUrl = jsonData['paymentUrl'];
        });
      }
    } catch (e) {
      print("Error $e");
    }
  }

  void initState() {
    tripEPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Bid Id ${widget.bidId}");
    print("Module Id ${widget.module}");
    print("Post Type Id ${widget.postType}");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "TripShipTask",
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
          SizedBox(
            height: 20.h,
          ),
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
                SizedBox(
                  height: 50.h,
                ),
                CustomButtonOne(
                    title: "Go To Pay",
                    btnColor: Colors.green,
                    height: 35.h,
                    width: 100.w,
                    radius: 5.r,
                    onTab: () {
                      Get.to(WebViewPayment());
                     // Get.to(AmarPayWebView(paymentUrl));
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
