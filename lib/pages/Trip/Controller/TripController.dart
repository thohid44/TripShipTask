import 'dart:convert';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/pages/Trip/model/my_trip_posts_model.dart';
import 'package:tripshiptask/pages/Trip/model/my_trips_offer_model.dart';
import 'package:tripshiptask/pages/Trip/model/trip_post_details_model.dart';
import 'package:tripshiptask/pages/Trip/model/trips_search_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// Counter offer, trip agree, accept trip, bidOnTrip

//https://copyprogramming.com/howto/flutter-and-getx-how-to-pass-parameters-from-ui-to-getx-controller
class TripController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;
  var isAllLoading = false.obs;
  List<TripSearchM> tripSearchList = <TripSearchM>[].obs;
  List<TripSearchM> gettripSearchList = <TripSearchM>[].obs;

  TripPostDetailsModel? tripPostDetailsModel;

  List<TripDetailsModel> tripDetailsModel = <TripDetailsModel>[];

  var pth;
  var path1 = ''.obs;
  void onInit() {
    super.onInit();
    getTrips();
    getMyTrips();
    fetchGetTrips();
    //getTripPostDetails(pth);
  }

  giveTripRide(
      {startPoint,
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

    var mapData = {
      "post_type": "offer",
      "start_point": startPoint,
      "via": "",
      "date": date,
      "time": time,
      "destination": des,
      "distance": distance,
      "duration": duration,
      "vehicle": "$howmany",
      "vehicle_type": "$vehicled",
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
    };

    try {
      isLoading(true);
      var response = await ApiService().postData(mapData, "trip");
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        Get.snackbar("Give Ride", "Successfully Store",
            backgroundColor: primaryColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  getTripRide(
      {startPoint,
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

    var mapData = {
      "post_type": "seek",
      "start_point": startPoint.toString(),
      "via": "",
      "date": date,
      "time": time,
      "destination": des,
      "distance": distance,
      "duration": duration,
      "vehicle": howmany.toString(),
      "vehicle_type": vehicled.toString(),
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
    };

    try {
      isLoading(true);
      var response = await ApiService().postData(mapData, "trip");
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        Get.snackbar("Get Ride", "Successfully Store",
            backgroundColor: primaryColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  MyTrips? myTrips;
  getMyTrips() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isAllLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}mytrip"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);

        MyTripPostsModel data = MyTripPostsModel.fromJson(jsonData);
        myTrips = data.data!;
        isAllLoading(false);
      }
    } catch (e) {
      isAllLoading(false);
      print("Error $e");
    }
  }

  getMyTripsOffer() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}my-trip-offers"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        update();
        return MyTripsOfferModel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error $e");
    }
    update();
  }

  tripSearch(
      {startPoints,
      startRadius,
      startkm,
      destination,
      desRadius,
      deskm,
      vehicle}) async {
    var token = _box.read(LocalStoreKey.token);
    print("search token $token");
    try {
      isLoading(true);
      tripSearchList.clear();
      var response = await http.get(
        Uri.parse(
            "${baseUrl}trip-search?slat=23.752308&slng=23.752308&dlat=23.7382053&dlng=23.7382053&sradious&dradious&unit=km&post_type=offer"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);

        TripSearchModel data = TripSearchModel.fromJson(jsonData);
        tripSearchList = data.data!;
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

  getTrips() async {
    var token = _box.read(LocalStoreKey.token);
    print("search token $token");
    try {
      isLoading(true);
      tripSearchList.clear();
      var response = await http.get(
        Uri.parse("${baseUrl}trip-search?post_type=offer"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("without para $jsonData");
        print(jsonData);

        TripSearchModel data = TripSearchModel.fromJson(jsonData);
        tripSearchList = data.data!;
        print(tripSearchList.length);
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

  fetchGetTrips() async {
    var token = _box.read(LocalStoreKey.token);
    print("search token $token");
    try {
      isLoading(true);
      gettripSearchList.clear();
      var response = await http.get(
        Uri.parse("${baseUrl}trip-search?post_type=seek"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("without para $jsonData");
        print(jsonData);

        TripSearchModel data = TripSearchModel.fromJson(jsonData);
        gettripSearchList = data.data!;
        print(gettripSearchList.length);
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

  bidOnTrip({amount, tripId, seat, message}) async {
    var token = _box.read(LocalStoreKey.token);
    print(token);
    var mapData = {
      "amount": amount.toString(),
      "vehicle_seat": seat.toString(),
      "trip_id": tripId.toString(),
      "message": message
    };

    try {
      isLoading(true);
      var response = await ApiService().postData(mapData, "tripbids");

      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print("offer $jsonData");
        Get.snackbar("Trip Offer", "Make Successfully ",
            backgroundColor: navyBlueColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  acceptTrip({bidId, sum}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {"accepted": "1", "totalpassenger": "$sum"};
    print("accetp offer is $sum");
    print("accetp bid id is $bidId");
    try {
      isLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(
          Uri.parse("https://app.tripshiptask.com/api/tripbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("offer $jsonData");
        Get.snackbar("Trip Offer", "Make Successfully ",
            backgroundColor: navyBlueColor);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  counterTripOffer({bidId, amount}) async {
    var token = _box.read(LocalStoreKey.token);

   

    print("amount $amount");
    print("Bid Id $bidId");
    try {
      isLoading(true);

      var response = await http.patch(Uri.parse("${baseUrl}tripbids/$bidId"),
          headers: {
          
            'Authorization': 'Bearer ' + token,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'co': [amount]}));

      print(response.statusCode);
          var jsonData = jsonDecode(response.body);
        print("counter offer $jsonData");

        

      // if (response.statusCode == 200) {
      //   print(response.statusCode);
      //   var jsonData = jsonDecode(response.body);
      //   print("counter offer $jsonData");
      //   Get.snackbar("Trip Offer", "Make Successfully ",
      //       backgroundColor: navyBlueColor);
      // }
        isLoading(false);
    } catch (e) {
        isLoading(false);
      print("Error $e");
    }
  }

  tripAgree({bidId}) async {
    var token = _box.read(LocalStoreKey.token);
    var mapData = {"agree": '1'};
    print(" bid id $bidId");
    try {
      isLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(Uri.parse("${baseUrl}tripbids/$bidId"),
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
        Get.back(); 
      }
    } catch (e) {
      print("Error $e");
    }
  }
 confirmRide({bidId,seat}) async {
    var token = _box.read(LocalStoreKey.token);
    var mapData = {"passenger_accepted": '$seat'};
    print(" bid id $bidId");
    try {
      isLoading(true);
     
      var response = await http.patch(Uri.parse("${baseUrl}tripbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);

      print(" status code ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter $jsonData");
        Get.snackbar("Trip Ride Confirm", "Successfully ",
            backgroundColor: navyBlueColor);
        Get.back(); 
      }
    } catch (e) {
      print("Error $e");
    }
  }
 finishRide({bidId,seat}) async {
    var token = _box.read(LocalStoreKey.token);
    var mapData = {
                    'completed': 1
                };
    print(" bid id $bidId");
    try {
      isLoading(true);
     
      var response = await http.patch(Uri.parse("${baseUrl}tripbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);

      print(" status code ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("counter $jsonData");
        Get.snackbar("Trip Ride Finish", "Successfully ",
            backgroundColor: navyBlueColor);
        Get.back(); 
      }
    } catch (e) {
      print("Error $e");
    }
  }

  // let tripdatetime = moment(date + ' ' + time);
  //           let currenttime = moment();
  //           let timediff = tripdatetime.diff(currenttime, 'minutes');
  //           if (timediff < 0) {
  //               var obj = {
  //                   completed: 1
  //               };
  //               var url = '/web/tripbids/' + bid;

  tripDisAgree({bidId}) async {

    var token = _box.read(LocalStoreKey.token);
    var mapData = {"disagree": 2};
    print(" bid id $bidId");
    try {
      isLoading(true);
    
      var response = await http.post(Uri.parse("${baseUrl}tripbids/$bidId"),
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
    } catch (e) {
      print("Error $e");
    }
  }

  tripCashPayment({bidId}) async {
    var token = _box.read(LocalStoreKey.token);

    print(" bid id $bidId");
    try {
      isLoading(true);

      var response = await http.patch(Uri.parse("${baseUrl}tripbids/$bidId"),
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

  tripCancle({slug}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {"status": "canceled", "timediff": "212222"};
    print(" bid id $slug");
    try {
      isLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
      var response = await http.patch(Uri.parse("${baseUrl}canceltrip/$slug"),
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

  getTripPostDetails(pth) async {
    print("path1 $pth");
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("${urlWithOutslash}$pth"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        print(" thohid koli ${jsonData}");

        tripPostDetailsModel = TripPostDetailsModel.fromJson(jsonData);

        update();
      }
      isLoading(false);
    } catch (e) {
      print("Error $e");
      isLoading(false);
    }
    update();
  }
}
