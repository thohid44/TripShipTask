import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:http/http.dart' as http;
class CarryPackageController extends GetxController {
  var isLoading = false.obs;
  final _box = GetStorage();
  carryPackage({
    pickup,
    pickDate,
    pickTime,
    willingPay,
    dropOff,
    deliveryTime,
    deliveryDate,
    currency,
    sendItem,
    goodType,
    pPointLat,
    pPointLng,
    dPointLat,
    dPointLng,
    approxiValue,
    packageType,
    weight,
    note,
  }) 
 async {
    print("pickup value is \$pickup: $pickup");
    print("pickDate value is \$pickDate: $pickDate");
    print("pickTime value is \$pickTime: $pickTime");
    print("willingPay value is \$willingPay: $willingPay");
    print("dropOff value is \$dropOff: $dropOff");
    print("deliveryTime value is \$deliveryTime: $deliveryTime");
    print("deliveryDate value is \$deliveryDate: $deliveryDate");
    print("currency value is \$currency: $currency");
    print("sendItem value is \$sendItem: $sendItem");
    print("goodType value is \$goodType: $goodType");
    print("pPointLat value is \$pPointLat: $pPointLat");
    print("pPointLng value is \$pPointLng: $pPointLng");
    print("dPointLat value is \$dPointLat: $dPointLat");
    print("dPointLng value is \$dPointLng: $dPointLng");
    print("approxiValue value is \$approxiValue: $approxiValue");
    print("packageType value is \$packageType: $packageType");
    print("weight value is \$weight: $weight");
    print("note value is \$note: $note");


     var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.post(Uri.parse("${baseUrl}ship"),
          headers: {
          "Content-Type": "application/json",
            'Authorization': 'Bearer ' + token,
            
          },
          body: jsonEncode({
    "post_type": "carry_package",
    "pickuppoint": "$pickup",
    "date": "$pickDate",
    "time": "$pickTime",
    "delivery_date": "$deliveryDate",
    "delivery_time": "$deliveryTime",
    "dropoffpoint": "$dropOff",
    "distance": "3",
    "duration": "2",
    "amount": "$willingPay",
    "p_lat": "$pPointLat",
    "p_lng": "$pPointLng",
    "d_lat": "$dPointLat",
    "d_lng": "$dPointLng",
    "document": "",
    "packagetype": "$packageType",
    "weight": "$weight",
    "goodtype": "$goodType",
    "length": "illo",
    "width": "officiis",
    "height": "inventore",
    "document_worth": "atque",
    "ownvehicle": "No",
    "country": "BD",
    "currency": "BDT",
    "notes": "$note"
}));
           print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
print("Ship Post $jsonData");
     
      Fluttertoast.showToast(
        msg: "Carry Ship Successfully Store",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
           isLoading(false);
      }
    } catch (e) {
        isLoading(false);
      print("Error $e");
    }
  }
}
