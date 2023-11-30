import 'dart:convert';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Api_services/base_url.dart';

import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/pages/Task/model/my_task_details_model.dart';
import 'package:tripshiptask/pages/Task/model/my_task_model.dart';
import 'package:tripshiptask/pages/Task/model/all_give_task_post_model.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Task/model/seek_task_model.dart';

class TaskController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;
  MyTaskModel2? myTaskModel2;
  MyTaskDetailsModel2? myTaskDetailsModel2;

  var path;
  void onInit() {
    super.onInit();

    searchAllGiveTask();
    getMyTask();
  }

  postTask(
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

    var mapData = {
      "selectedskill": selectSkill.toString(),
      "title": title,
      "category": category,
      "location": location,
      "preferred_gender": preferedGender,
      "date": date,
      "time": time,
      "details": details,
      "amount": amount,
      "lat": lat.toString(),
      "lng": lng.toString(),
      "hour_available": hourAvailable,
      "hour_need": hourNeed,
      "post_type": postType,
      "country": 'Bangladesh',
      "currency": currency,
      "moduleId": moduleId
    };

    try {
      isLoading(true);

      var response = await ApiService().postData(mapData, "task");
      var jsonData = jsonDecode(response.body);
      print("body ${jsonData}");
      print("status code ${response.statusCode}");
    } catch (e) {
      print("Error $e");
    }
  }

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

        MyTaskModel data = MyTaskModel.fromJson(jsonData);
        myTaskModel2 = data.myTaskModel2;
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
}
