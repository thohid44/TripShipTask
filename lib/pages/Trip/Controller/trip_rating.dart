import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';

class TripRatingController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;

  var pth;
  var path1 = ''.obs;
  void onInit() {
    super.onInit();
    //getTripPostDetails(pth);
  }

  tripGiverFeedback({bidderId, posterId, tripId, bidId, rating, review}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {
      "bidderId": bidderId.toString(),
      "posterId": posterId.toString(),
      "tripId": tripId.toString(),
      "bidId": bidId.toString(),
      "rating": rating.toString(),
      "review": ["Behavior", "Punctualit"]
    };

    try {
      isLoading(true);
      var response = await ApiService().postData(mapData, "tripgiverfeedback");
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        Get.snackbar("Rating ", "Successfully Done",
            backgroundColor: primaryColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  biderGiveRating({rating, review}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {
      "rating": "3.5",
      "review": ["Behavior"]
    };

    try {
      isLoading(true);
      var response = await ApiService().postData(mapData, "tripbids/9");
      print(response.statusCode);
      if (response.statusCode == 201) {
   
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        Get.snackbar("Rating ", "Successfully Done",
            backgroundColor: primaryColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
