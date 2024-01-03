import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Refferal/modal/my_referrels_modal.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';

class ReferrelsController extends GetxController {
  void onInit() {
    super.onInit();
    getMyReferrels();
  }

  var isLoading = false.obs;

  final _box = GetStorage();
  List<MyReferrelsModal> myReferrelsList = <MyReferrelsModal>[].obs;
  getMyReferrels() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      myReferrelsList.clear(); 
      var response = await http.get(
        Uri.parse("${baseUrl}myreferrals"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        for (Map<String, dynamic> index in jsonData) {
          myReferrelsList.add(MyReferrelsModal.fromJson(index));
        }

        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }
}
