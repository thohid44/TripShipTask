import 'dart:convert';

import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = 'https://app.tripshiptask.com/api/';
  static var client = http.Client();
  var token = '';

  final _box = GetStorage();
  var isLoading = false.obs;
//sPoint,des,note, prefered,howmany, currency,vehicled

  postData(mapData, String link) async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.post(Uri.parse("$baseUrl$link"),
          headers: {
          
            'Authorization': 'Bearer ' + token,
            
          },
          body: mapData);
      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
print("Trip Post $jsonData");
        Get.snackbar("Get Ride", "Successfully Store",
           );
           isLoading(false);
      }
    } catch (e) {
        isLoading(false);
      print("Error $e");
    }
  }
}
