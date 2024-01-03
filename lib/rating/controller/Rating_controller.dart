import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/rating/model/rating_model.dart';
import 'package:tripshiptask/rating/model/ship_rating_model.dart';
import 'package:tripshiptask/rating/model/task_rating_model.dart';

class RatingController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;
var isLoading2 = false.obs;
var isLoading3 = false.obs;

  RatingModel? ratingModel;
  AllShipRatingModel? shipRatingModel;
  AllTaskRatingModel? taskRatingModel;
  void onInit() {
    super.onInit();
    getMyTripRating();
     getMyShipRating();
        getMyTaskRating();
  }

  getMyTripRating() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}mytripratings"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        RatingDataModel data = RatingDataModel.fromJson(jsonData);

        ratingModel = data.data;
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

    getMyShipRating() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading2(true);
      var response = await http.get(
        Uri.parse("${baseUrl}myshipratings"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

      GetAllShipRatingModel   data = GetAllShipRatingModel.fromJson(jsonData);
print("Ship Rating $jsonData");
        shipRatingModel = data.data;
        isLoading2(false);
      }
    } catch (e) {
      isLoading2(false);
      print("Error $e");
    }
  }

    getMyTaskRating() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading3(true);
      var response = await http.get(
        Uri.parse("${baseUrl}mytaskratings"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        GetAllTaskRatingModel data = GetAllTaskRatingModel.fromJson(jsonData);
print("Task Rating $jsonData");
        taskRatingModel = data.data;
        isLoading3(false);
      }
    } catch (e) {
      isLoading3(false);
      print("Error $e");
    }
  }


}
