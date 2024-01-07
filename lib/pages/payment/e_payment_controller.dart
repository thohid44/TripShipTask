import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/Amar/trip_E_payment.dart';

class PaymentController extends GetxController{


var isEPayment = false.obs; 
final _box = GetStorage();

   tripEPayment({context,bidId, module, postType}) async {
    var token = _box.read(LocalStoreKey.token);

    print(" bid id $bidId");
    try {
      isEPayment(true);

      var response = await http.patch(Uri.parse("${baseUrl}tripbids/$bidId"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            "module": "$module",
            "post_type": "$postType",
            "currency": "BDT",
            "bid": "$bidId"
          }));
      print("Response code ${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("Peyment Process $jsonData");

        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TripEPaymentPage()),
            );

        isEPayment(false);
      }
    } catch (e) {
      isEPayment(false);
      print("Error $e");
    }
  }
}