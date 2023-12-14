import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';

import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/pages/Task/model/my_task_details_model.dart';
import 'package:tripshiptask/pages/Task/model/my_task_model.dart';
import 'package:tripshiptask/pages/Task/model/all_give_task_post_model.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Task/model/seek_task_model.dart';

class TaskSeekPostController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;
  MyAllTaskModel? myTaskModel2;
  MyTaskDetailsModel2? myTaskDetailsModel2;

  var path;
  void onInit() {
    super.onInit();

  }

  seekTask(
      {selectSkill,
      title,
      category,
      location,
      preferedGender,
      date,
      time,
      details,
      amount,
      lat,
      lng,
      hourAvailable,
      hourNeed,
      postType,
      country,
      currency,
      moduleId}) async {
    var token = _box.read(LocalStoreKey.token);
    print("Token is $token");
    print("Start");
    print(" Skill is $selectSkill");
    print("title is $title");
    print("category is $category");
    print("location is $location");
    print("preferedGender $preferedGender");
    print("date is $date");
    print("time is $time");
    print("details $details");
    print("amount $amount");
    print("lat is ${lat.toString()}");
    print("lng is ${lng.toString()}");
    print("hourAvail $hourAvailable");
    print("hourneed $hourNeed");
    print("postType $postType");
    print("country $country");
    print("currency $currency");
    print("moduleId $moduleId");

    try {
      isLoading(true);
      var response = await http.post(Uri.parse("${baseUrl}task"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            "selectedskill": "$selectSkill",
            "title": "$title",
            "category": "$category",
            "location": "$location",
            "preferred_gender": "$preferedGender",
            "date": "$date",
            "time": "$time",
            "details": "$details",
            "amount": "$amount",
            "lat": "$lat",
            "lng": "$lng",
            "hour_available": "$hourAvailable",
            "hour_need": "$hourNeed",
            "post_type": "seek",
            "country": "BD",
            "currency": "BDT",
            "moduleId": "$moduleId"
          }));
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print("Trip Post $jsonData");
        Get.snackbar(
          "Task Offer",
          "Successfully Store",
        );
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }
}