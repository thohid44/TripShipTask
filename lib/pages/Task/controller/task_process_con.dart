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

class TaskProcessController extends GetxController{
final _box = GetStorage();
var isDisAgreeloading = false.obs; 
var isCashLoading = false.obs; 
 var isCancleLoading = false.obs; 
 var isBidLoading = false.obs; 
var isAgreeLoading = false.obs; 
 var isCounterLoading= false.obs; 

  bidTaskOffer({amount, taskId, message}) async {
    var token = _box.read(LocalStoreKey.token);
    print(token);
    var mapData = {
      "bidamount": amount.toString(),
      "task_id": taskId.toString(),
      "message": message.toString()
    };
    print("task amount $amount");
    print(taskId);
    print(message);

    try {
      isBidLoading(true);
  
        var response = await http.post(Uri.parse("${baseUrl}taskbids"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({ 
      "bidamount": amount.toString(),
      "task_id": taskId.toString(),
      "message": message.toString()
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


             isBidLoading(false);}

    } catch (e) {
       isBidLoading(false);
      print("Error $e");
    }
  }

  taskCounterOffer({bidId, amount}) async {
    var token = _box.read(LocalStoreKey.token);

   final jsonData = {'co': [amount]};
final jsonString = jsonEncode(jsonData);
print("co $jsonString");
  List<dynamic> amt = [amount];
    print("amount $amount");
    print("Bid Id $bidId");
    var data = {'co': amt.toString()};
    try {
      isCounterLoading(true);

      var response = await http.patch(Uri.parse("${baseUrl}taskbids/$bidId"),
          headers: {
              "Content-Type": "application/json",
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode(data));

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");
        Get.snackbar("Trip Offer", "Make Successfully ",
            backgroundColor: navyBlueColor);
      }
      isCounterLoading(false);
    } catch (e) {
        isAgreeLoading(false);
      print("Error $e");
    }
  }

  taskAgree(bidId) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {"agree": '1'};
    print(" bid id $bidId");
    try {
      isAgreeLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(Uri.parse("${baseUrl}taskbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);

      print(" status code ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");
        Get.snackbar("Trip Offer", "Agree Successfully ",
            backgroundColor: navyBlueColor);
      }
            isAgreeLoading(false);

    } catch (e) {
            isAgreeLoading(false);
      print("Error $e");
    }
  }


    taskDisAgree({bidId}) async {

    var token = _box.read(LocalStoreKey.token);
    var mapData = {"disagree": 2};
    print(" bid id $bidId");
    try {
      isDisAgreeloading(true);
    
      var response = await http.post(Uri.parse("${baseUrl}taskbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);

      print(" status code ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");
        Get.snackbar("Trip Offer", "Agree Successfully ",
            backgroundColor: navyBlueColor);
      }
       isDisAgreeloading(false);
    } catch (e) {
       isDisAgreeloading(false);
      print("Error $e");
    }
  }

  taskCashPayment({bidId}) async {
    var token = _box.read(LocalStoreKey.token);

    print(" bid id $bidId");
    try {
      isCashLoading(true);

      var response = await http.patch(Uri.parse("${baseUrl}taskbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({"pay": '1', "paymethod": 'cash'}));
      print("Response code ${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");
        Get.snackbar("Trip Offer", "Agree Successfully ",
            backgroundColor: navyBlueColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  taskCancle({slug}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {"status": "canceled", "timediff": "212222"};
    print(" bid id $slug");
    try {
      isCancleLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(Uri.parse("${baseUrl}canceltask/$slug"),
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
}