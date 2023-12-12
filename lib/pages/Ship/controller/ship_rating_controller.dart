import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/Utils/localstorekey.dart';

class ShipRatingController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;

  var pth;
  var path1 = ''.obs;
  void onInit() {
    super.onInit();
    //getTripPostDetails(pth);
  }

   shipGiverFeedback({bidderId, shipperId, shipId, bidId, rating, reviews}) async {
    var token = _box.read(LocalStoreKey.token);

    

    try {
      isLoading(true);

      List<String> chosenFeedback = ["Behavior", "Punctuality"];

      print(
          " bider Id $bidderId , shipperId $shipperId, tripId $shipId, bidId $bidId, review $chosenFeedback");

      var response = await http.post(
        Uri.parse("https://app.tripshiptask.com/api/shipgiversfeedback"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode({
          "bidderId": bidderId,
          "shipperId": shipperId.toString(),
          "shipId": shipId.toString(),
          "bidId": bidId.toString(),
          "rating": rating.toString(),
          "review": reviews,
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


  shipBiderGiveRating({shipbidId,shipperId,userId,feedbackgot,rating, review}) async {
    var token = _box.read(LocalStoreKey.token);


   try {
      isLoading(true);

     

      print(
          "  shipbidId $shipbidId, review $review");

      var response = await http.post(
        Uri.parse("https://app.tripshiptask.com/api/shipbids/$shipbidId"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(
          {
    "rating": rating.toString(),
    "review": review,
    "shipperId": shipperId.toString(),
    "feedbackgot": feedbackgot,
    "user_id": userId.toString()
}
        ),
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
