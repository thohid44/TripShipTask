import 'dart:convert';

import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/app_constants.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/pages/Home/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class LoginController extends GetxController {
  var isLoading = false.obs;
  var isRegLoading = false.obs;
  var isLogLoading = false.obs;
  final _box = GetStorage();
  var userClient = http.Client();
  var url = "${baseUrl}auth/login";

  login(email, password) async {
    Get.to(HomeScreen());
    try {
      var mapData = {
  //"email":"test1@abaacorp.com",
    //   "email":"test2@abaacorp.com",
  "email": "waleed.amin08@gmail.com",
        "password": '123456789'
      };
      isLogLoading(true);
      var response = await http.post(Uri.parse(url), body: mapData);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);

        var getToken = jsonData['access_token'];
        var userId = jsonData['user']['id'];
        var fullName = jsonData['user']['full_name'];
        var accountNo = jsonData['user']['accno'];
        print(fullName);
        _box.write(LocalStoreKey.userId, userId);
        _box.write(LocalStoreKey.token, getToken);
        _box.write(LocalStoreKey.fullName, fullName);
        _box.write(LocalStoreKey.accountNo, accountNo);

        print(_box.read(LocalStoreKey.token));

        if (getToken != null) {
          Get.to(HomeScreen());
        }
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

  registration({name, phone, email, gender, password}) async {
    var mapData = {
      "name": name,
      "mobile": phone,
      "email": email,
      "gender": gender,
      "password": password
    };
    try {
      isRegLoading(true);
      var response = await http.post(Uri.parse(url), body: mapData);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
      }
      isRegLoading(false);
    } catch (e) {
      isRegLoading(false);
      print("Error $e");
    }
  }

  var isLoadingReg2 = false.obs;

  var profilePic = ''.obs;
  var nidPic1 = ''.obs;
  var nidPic2 = ''.obs;
  var education = ''.obs;
  var question = ''.obs;
  var answer = ''.obs;
  var day = ''.obs;
  var month = ''.obs;
  var year = ''.obs;
  var bloodGroup = ''.obs;
  Future registrationTwo() async {
    var token = _box.read(LocalStoreKey.token);

    print("Profile ${profilePic.value}");
    print("NID ${nidPic1}");
    print("education ${education.value}");
    print("question ${question.value}");
    print("blood ${bloodGroup.value}");

    var url = Uri.parse("${AppConstants.baseUrl}");
    try {
      //multipart post
      http.MultipartRequest request = http.MultipartRequest('POST', url);

      request.fields[''] = education.value.toString();
      request.fields[''] = question.value.toString();
      request.fields[''] = answer.value.toString();
      request.fields[''] = bloodGroup.value.toString();

      request.headers.addAll(
        {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      );
      http.MultipartFile profilePicFile =
          await http.MultipartFile.fromPath("image", "");
      http.MultipartFile nid1PartFile =
          await http.MultipartFile.fromPath("image", "");
      http.MultipartFile nid2PartFile =
          await http.MultipartFile.fromPath("image", "");

      request.files.add(profilePicFile);
      request.files.add(nid2PartFile);
      request.files.add(nid1PartFile);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(" koli ${response.request}");
        print("success");
        Get.snackbar("Image", "Successfully Upload");

        Get.back();
      }

      return response.statusCode;
    } catch (e) {
      print("Error $e");
    }
  }
}
