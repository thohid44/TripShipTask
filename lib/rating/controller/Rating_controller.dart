import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/rating/model/rating_model.dart';

class RatingController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;

  RatingModel? ratingModel;

  void onInit() {
    super.onInit();
    getMyTripRating();
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
}
