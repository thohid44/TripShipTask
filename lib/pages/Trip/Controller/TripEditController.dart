import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:http/http.dart' as http;
class TripEditController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;

  var pth;
  var path1 = ''.obs;
  void onInit() {
    super.onInit();
    //getTripPostDetails(pth);
  }
  

  editGiveTripPost(
      { slug,startPoint,
      des,
      distance,
      date,
      time,
      country,
      duration,
      sPointLat,
      sPointLng,
      dPointLat,
      dPointLng,
      note,
      passengerType,
      howmany,
      willPay,
      currency,
      vehicled}) async {
    var token = _box.read(LocalStoreKey.token);

    print("country is $country");
    print("time is $time");
    print("distance is $distance");
    print("date is $date");
    print("des is $des");
    print("duration is $duration");
    print("distance is $distance");
    print("sPointLng is $sPointLng");
    print("sPointLat is $sPointLat");
    print("dPointLat is $dPointLat");
    print("dPointLng is $dPointLng");
    print("Willing to  pay $willPay");
    print("note is $note");

 

    try {
      isLoading(true);
      var response = await http.patch(Uri.parse("${baseUrl}trip/$slug"),
          headers: {
          "Content-Type": "application/json",
            'Authorization': 'Bearer ' + token,
            
          },
          body: jsonEncode({
      "post_type": "offer",
      "start_point": startPoint.toString(),
      "via": "",
      "date": date,
      "time": time,
      "destination": des,
      "distance": distance,
      "duration": duration,
      "vehicle": "2",
      "vehicle_type": "car",
      "pay": willPay,
      "s_lat": sPointLat.toString(),
      "s_lng": sPointLng.toString(),
      "d_lat": dPointLat.toString(),
      "d_lng": dPointLng.toString(),
      "country": "BD",
      "currency": "BDT",
      "preferred_passenger": passengerType, // Male or female or any
      "vehicle_seat": howmany,
      "details": note
    }));
           print(response.statusCode);
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
