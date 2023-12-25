import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ShipProcessController extends GetxController {
  final _box = GetStorage();
  var isDisAgreeloading = false.obs;
  var isCashLoading = false.obs;
  var isCancleLoading = false.obs;
  var isBidLoading = false.obs;
  var isAgreeLoading = false.obs;
  var isCounterLoading = false.obs;

    var isFinishShipment = false.obs;
  finishShip({bidId}) async {
    
    var token = _box.read(LocalStoreKey.token);
    var mapData = {'completed': '1'};
    print(" bid id $bidId");
    try {
      isFinishShipment(true);

      var response = await http.patch(Uri.parse("${baseUrl}shipbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);

      print(" status code ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter $jsonData");
        Get.snackbar("Shipment Finish", "Successfully ",
            backgroundColor: navyBlueColor);
        Get.back();
        isFinishShipment(false);
      }
    } catch (e) {
      isFinishShipment(false);
      print("Error $e");
    }
  }

  bidOnGivenShip({amount, shipId, message}) async {
    var token = _box.read(LocalStoreKey.token);
    print(token);
    var mapData = {
      "bidamount": amount.toString(),
      "ship_id": shipId.toString(),
      "message": message.toString()
    };
    print("ship amount $amount");
    print(shipId);
    print(message);

    try {
      isBidLoading(true);
      var response = await ApiService().postData(mapData, "shipbids");
      print("status code ${response.statusCode}");

      if (response.statusCode == 202) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print("offer $jsonData");
        Get.snackbar("Ship Offer", "Make Successfully ",
            backgroundColor: navyBlueColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  counterShipOffer({bidId, amount}) async {
    var token = _box.read(LocalStoreKey.token);

    print("amount $amount");
    print("Bid Id $bidId");

    try {
      isCounterLoading(true);

      var response = await http.patch(Uri.parse("${baseUrl}shipbids/$bidId"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            "co": [amount]
          }));

      print(response.statusCode);

      if (response.statusCode == 200) {
 Fluttertoast.showToast(
        msg: "Counter offer sent Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:navyBlueColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
      isCounterLoading(false);
    } catch (e) {
      isAgreeLoading(false);
      print("Error $e");
    }
  }

  giveShipAgree({bidId}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {"agree": '1'};
    print(" bid id $bidId");
    try {
      isAgreeLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(Uri.parse("${baseUrl}shipbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);

      print(" status code ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");
     

             Fluttertoast.showToast(
        msg: "Trip Offer Agree Successfully ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:navyBlueColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
      isAgreeLoading(false);
    } catch (e) {
      isAgreeLoading(false);
      print("Error $e");
    }
  }

  shipDisAgree({bidId}) async {
    var token = _box.read(LocalStoreKey.token);
    var mapData = {"disagree": 2};
    print(" bid id $bidId");
    try {
      isDisAgreeloading(true);

      var response = await http.post(Uri.parse("${baseUrl}shipbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);

      print(" status code ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        Fluttertoast.showToast(
        msg: "Trip Offer Agree Successfully ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:navyBlueColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
      isDisAgreeloading(false);
    } catch (e) {
      isDisAgreeloading(false);
      print("Error $e");
    }
  }

  shipCashPayment({bidId}) async {
    var token = _box.read(LocalStoreKey.token);

    print(" bid id $bidId");
    try {
      isCashLoading(true);

      var response = await http.patch(Uri.parse("${baseUrl}shipbids/$bidId"),
          headers: {
            'Content-Type': "application/json",
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({"pay": '1', "paymethod": 'cash'}));
      print("Response code ${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");
    
              Fluttertoast.showToast(
        msg: "Ship Payment Successfully ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:navyBlueColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
          isCashLoading(true);
    } catch (e) {
          isCashLoading(true);
      print("Error $e");
    }
  }

  shipCancle({slug}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {"status": "canceled", "timediff": "212222"};
    print(" Slug id $slug");
    try {
      isCancleLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(Uri.parse("${baseUrl}cancelship/$slug"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);
      print(" status code ${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");
        Get.snackbar("Trip Offer", "Cancel Successfully ",
            backgroundColor: navyBlueColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  var isLoading = false.obs;
  acceptShip({bidId}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {
      "accepted": "1",
    };
    print("accetp bid id is $bidId");
    try {
      isLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(
          Uri.parse("https://app.tripshiptask.com/api/shipbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("offer $jsonData");
        Get.snackbar("Trip Offer", "Make Successfully ",
            backgroundColor: navyBlueColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  shipDelete({id}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {"status": "canceled", "timediff": "212222"};
    print(" Slug id $id");
    try {
      isCancleLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(
        Uri.parse("${baseUrl}ship/$id"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      print(" status code ${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");
        Get.snackbar("Trip Offer", "Cancel Successfully ",
            backgroundColor: navyBlueColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
