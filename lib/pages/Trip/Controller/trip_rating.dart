import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:http/http.dart' as http;

class TripRatingController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;

  var pth;
  var path1 = ''.obs;
  void onInit() {
    super.onInit();
    //getTripPostDetails(pth);
  }

  tripGiverFeedback(
      {bidderId, posterId, tripId, bidId, rating, reviews}) async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);

      // List<String> reviews = ["Behavior", "Punctuality"];

      print(
          " bider Id $bidderId , posterId $posterId, tripId $tripId, bidId $bidId, review $reviews");

      var response = await http.post(
        Uri.parse("https://app.tripshiptask.com/api/tripgiverfeedback"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode({
          "bidderId": bidderId,
          "posterId": posterId.toString(),
          "tripId": tripId.toString(),
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

  biderGiveRating({bidId, rating, review}) async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);

      print("  bidId $bidId, review $review");

      var response = await http.patch(
        Uri.parse("https://app.tripshiptask.com/api/tripbids/$bidId"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode({
          "rating": rating.toString(),
          "review": review,
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
