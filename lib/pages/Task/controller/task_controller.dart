import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:tripshiptask/pages/Task/model/my_tasks_offer_model.dart';
import 'package:tripshiptask/pages/Task/model/seek_task_model.dart';

class TaskController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;
  MyAllTaskModel? myTaskModel2;
  MyTaskDetailsModel2? myTaskDetailsModel2;

  var path;
  void onInit() {
    super.onInit();

    searchAllGiveTask();
    getMyTask();
    getMyTaskOffer();
  }

  postTask(
      {
      selectSkill,title, category, location, preferedGender,
      date,time, details, amount, lat,lng,hourAvailable,
      hourNeed,  postType, country,currency,moduleId
      }) async {
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
                  "Accept": "application/json",
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
    "selectedskill": [selectSkill],
    "title": "$title",
    "category": "$category",
    "location": "$location",
    "preferred_gender": "$preferedGender",
    "date": "$date",
    "time": "$time",
    "details": "$details",
    "amount": "140",
    "lat": lat,
    "lng": lng,
    "hour_available": "$hourAvailable",
    "hour_need": "$hourNeed",
    "post_type": "offer",
    "country": "BD",
    "currency": "BDT",
    "moduleId": 3
})

);
    
          print(response.statusCode);
        var jsonData = jsonDecode(response.body);
  print("Task Post $jsonData");

      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
      
      Fluttertoast.showToast(
        msg: "Task Offer Successfully Stored",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0
    );
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }


  updateGiveTask(
      {slug,
      selectSkill,title, category, location, preferedGender,
      date,time, details, amount, lat,lng,hourAvailable,
      hourNeed,  postType, country,currency,moduleId
      }) async {
    var token = _box.read(LocalStoreKey.token);
    print("Token is $slug");
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

      var response = await http.put(Uri.parse("${baseUrl}task/$slug"),
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
    "moduleId": 3
}));
      print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print("task Post $jsonData");
      if (response.statusCode == 200) {
       
        var jsonData = jsonDecode(response.body);
        print("task Post $jsonData");
        Get.snackbar(
          "Give Task",
          "Successfully Update",
        );
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }
List<MyTasksOffer> myTaskOfferList = <MyTasksOffer>[].obs;
var isOffersLoading = false.obs; 
  getMyTaskOffer() async {
    var token = _box.read(LocalStoreKey.token);
    try {
      isOffersLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}my-task-offers"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("All Task $jsonData");

        MyTasksOfferModel data = MyTasksOfferModel.fromJson(jsonData);
        myTaskOfferList = data.data!;
        print("koli ${myTaskOfferList.length}");
        isOffersLoading(false);
      }
    } catch (e) {
      isOffersLoading(false);
      print("Error $e");
    }
  }



// List<MyTasksOffer> myTaskOfferList = <MyTasksOffer>[].obs;
// var isOffersLoading = false.obs; 
//   getMyTaskOffer() async {
//     var token = _box.read(LocalStoreKey.token);
//     try {
//       isOffersLoading(true);
//       var response = await http.get(
//         Uri.parse("${baseUrl}my-task-offers"),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ' + token,
//         },
//       );
//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);
//         print("All Task $jsonData");

//         MyTasksOfferModel data = MyTasksOfferModel.fromJson(jsonData);
//         myTaskOfferList = data.data!;
//         print("koli2 ${myTaskOfferList.length}");
//         isOffersLoading(false);
//       }
//     } catch (e) {
//       isOffersLoading(false);
//       print("Error $e");
//     }
//   }


  getMyTask() async {
    var token = _box.read(LocalStoreKey.token);
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}mytask"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("All Task $jsonData");

        MyTaskModel data = MyTaskModel.fromJson(jsonData);
        myTaskModel2 = data.data;
        print("koli ${myTaskModel2!.completedTasks.length}");
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

  List<AllGiveTaskModel> allGiveTaskList = <AllGiveTaskModel>[].obs;
  AllGiveTaskPostModel? taskSearchmodel;

  searchAllGiveTask() async {
    var token = _box.read(LocalStoreKey.token);
    var mapData = {"post_type": "offer"};
    try {
      isLoading(true);
      allGiveTaskList.clear();
      var response = await http.get(
        Uri.parse("${baseUrl}task-search?post_type=offer"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      var jsonData = jsonDecode(response.body);
      print("lsls $jsonData");
      if (response.statusCode == 200) {
        AllGiveTaskPostModel data = AllGiveTaskPostModel.fromJson(jsonData);

        allGiveTaskList = data.data!;
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

  List<SeekTaskModelList> seekTaskList = <SeekTaskModelList>[].obs;
  var seekIsLoading = false.obs;
  allSeekTask() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      seekIsLoading(true);
      seekTaskList.clear();
      var response = await http.get(
        Uri.parse("${baseUrl}task-search?post_type=seek"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      var jsonData = jsonDecode(response.body);
      print("seek list $jsonData");
      if (response.statusCode == 200) {
        SeekTaskModel data = SeekTaskModel.fromJson(jsonData);

        seekTaskList = data.data!;
        seekIsLoading(false);
      }
    } catch (e) {
      seekIsLoading(false);
      print("Error $e");
    }
  }

  void fetchDataWithGet() async {
    // Define the URL and the data you want to send in the request body
    final url = Uri.parse("${baseUrl}task-search?post_type='offer'");

    // Create a Map to represent your data
    Map<String, dynamic> data = {"post_type": "offer"};
    // Encode the data as JSON and convert it to a string
    String jsonBody = json.encode(data);

    // Create a client
    final client = http.Client();

    try {
      // Send a GET request with the body as a string
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // If the request was successful, parse the response
        var responseData = json.decode(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Request failed with error: $e');
    } finally {
      client.close();
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

    var mapData = {"amount": amount};
    print("amount $amount");
    print("Bid Id $bidId");
    try {
      isLoading(true);

      var response = await http.patch(Uri.parse("${baseUrl}tripbids/$bidId"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          },
          body: mapData);

      print(response.statusCode);

      // if (response.statusCode == 200) {
      //   print(response.statusCode);
      //   var jsonData = jsonDecode(response.body);
      //   print("counter offer $jsonData");
      //   Get.snackbar("Trip Offer", "Make Successfully ",
      //       backgroundColor: navyBlueColor);
      // }
    } catch (e) {
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
        Get.snackbar(
          "Trip Offer",
          "Agree Successfully ",
        );
      }
    } catch (e) {
      print("Error $e");
    }
  }

  tripDisAgree({bidId}) async {
    var token = _box.read(LocalStoreKey.token);

    var mapData = {"disagree": 2};
    print(" bid id $bidId");
    try {
      isLoading(true);
      //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
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
}
