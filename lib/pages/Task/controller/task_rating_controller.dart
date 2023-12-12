import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:http/http.dart' as http;

class TaskRatingController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;

  var pth;
  var path1 = ''.obs;
  void onInit() {
    super.onInit();
    //getTripPostDetails(pth);
  }

  taskGiverFeedback({taskerId,taskId, userId, bidId, rating, review}) async {
    var token = _box.read(LocalStoreKey.token);


    try {
      isLoading(true);

      List<String> reviews = ["Behavior", "Punctuality"];

      print(
          " taskerId $taskerId, taskId $taskId, bidId $bidId, review $review");

      var response = await http.post(
        Uri.parse("https://app.tripshiptask.com/api/tripgiverfeedback"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode({
                "bidderId": taskerId,
                "taskgiverId": userId,
                "taskId": taskId,
                "bidId": bidId,
                "rating": rating,
                "review": reviews
}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);

        var jsonData = jsonDecode(response.body);
       
        Get.snackbar(
          "Trip Rating",
          "Successfully Store",
        );
         print("Trip Post $jsonData");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  taskBiderGiveRating({bidId,taskgiverId,rating, review}) async {
    var token = _box.read(LocalStoreKey.token);

   try {
      isLoading(true);

      List<String> reviews = ["Behavior", "Punctuality"];

      print(
          "  taskgiverId $taskgiverId, review $review");

      var response = await http.post(
        Uri.parse("https://app.tripshiptask.com/api/bid/$bidId"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode({
    "rating": rating,
    "review": reviews,
    "taskgiverId": taskgiverId.toString()
}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);

        var jsonData = jsonDecode(response.body);
       
        Get.snackbar(
          "Get Ride",
          "Successfully Store",
        );
         print("Trip Post $jsonData");
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
