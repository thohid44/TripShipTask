import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';

class TaskRatingController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;

  var pth;
  var path1 = ''.obs;
  void onInit() {
    super.onInit();
    //getTripPostDetails(pth);
  }

  taskGiverFeedback({bidderId, shipperId, shipId, bidId, rating, chosenFeedback}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {
                "bidderId": bidderId, //carrierid,
                "shipperId": shipperId,
                "shipId": shipId,
                "bidId": bidId,
                "rating": rating,
                "review": chosenFeedback,
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

  shipBiderGiveRating({rating, review}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {
      "rating": "3.5",
      "review": ["Behavior"]
    };

    try {
      isLoading(true);
      var response = await ApiService().postData(mapData, "shipbids/9");
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
