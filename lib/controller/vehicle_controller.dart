import 'dart:convert';

import 'package:tripshiptask/Api_services/base_url.dart';

import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/controller/vehicle_model.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class VehicleController extends GetxController {
  var isLoading = false.obs;
  final _box = GetStorage();

  List<VehiclesModel> myVehicles = <VehiclesModel>[].obs;

  getMyVehicles() async {
    var token = _box.read(LocalStoreKey.token);
    var userId = _box.read(LocalStoreKey.userId);
    print("user Id $userId");
    try {
      isLoading(true);
      myVehicles.clear();
      var response = await http.get(
        Uri.parse("${baseUrl}getvehiclesinfo?user=$userId"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        VehicleModel data = VehicleModel.fromJson(jsonData);

        myVehicles = data.data!;

        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }
}
