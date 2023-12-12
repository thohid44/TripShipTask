import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
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

  tripGiverFeedback({bidderId, posterId, tripId, bidId, rating, review}) async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
       List<String> stringList = ["Behavior", "Punctualit"];
 String concatenatedString = stringList.join(' ');
 print(concatenatedString);

      var response = await http.post(Uri.parse("${baseUrl}tripgiverfeedback"),
          headers: {
            'Authorization': 'Bearer ' + token,
          },
          body: {

      "bidderId": bidderId.toString(),
      "posterId": posterId.toString(),
      "tripId": tripId.toString(),
      "bidId": bidId.toString(),
      "rating": rating.toString(),
      "review": "Behavior"
    }
);
             print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);

        var jsonData = jsonDecode(response.body);
print("Trip Post $jsonData");
        Get.snackbar("Get Ride", "Successfully Store",
           );
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
