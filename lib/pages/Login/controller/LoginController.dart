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
      var email1;
      if (email == '1') {
        email1 = "test1@abaacorp.com";
      } else {
        email1 = "waleed.amin08@gmail.com";
      }
      var mapData = {
        "email": email1,
        //   "email":"test2@abaacorp.com",
        // "email": "waleed.amin08@gmail.com",
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
  var identityNo = ''.obs;
  var userId = ''.obs;
  var nidPic1 = ''.obs;
  var nidPic2 = ''.obs;
  var education = ''.obs;
  var profession = ''.obs;
  var idPic1 = ''.obs;
  var idPic2 = ''.obs;
  var designation = ''.obs;
  var companyName = ''.obs;

  var nomineeName = ''.obs;
  var nomineeContact = ''.obs;
  var nominneeRelation = ''.obs;
  var question = ''.obs;
  var answer = ''.obs;
  var day = ''.obs;
  var month = ''.obs;
  var year = ''.obs;
  var emergencyContactNumber = ''.obs;
  var emergencyContactName = ''.obs;
  var residanceArea = ''.obs;
  var bloodGroup = ''.obs;
  var facebookLink = ''.obs;

   registrationTwo() async {
    var token = _box.read(LocalStoreKey.token);

    print("Profile ${profilePic.value}");
    print("NID ${nidPic1}");
    print("education ${education.value}");
    print("question ${question.value}");
    print("blood ${bloodGroup.value}");

    var url = Uri.parse("${AppConstants.baseUrl}verify/345?expires=1703590332&signature=ec174c9b20c6a942ead78c96b11a9c50d25b3761a08587f70182c9cb062a3381");
    try {
      isLoadingReg2(true);
      //multipart post
      http.MultipartRequest request = http.MultipartRequest('POST', url);

      request.fields['identity_no'] = identityNo.value.toString();
      request.fields['user_id'] = userId.value.toString();
      request.fields['education'] = education.value.toString();
      request.fields['profession'] = profession.value.toString();
      request.fields['designation'] = designation.value.toString();
      request.fields['company_name'] = companyName.value.toString();

      request.fields['s_question'] = question.value.toString();
      request.fields['s_ans'] = answer.value.toString();
      request.fields['day'] = question.value.toString();
      request.fields['month'] = answer.value.toString();
      request.fields['year'] = bloodGroup.value.toString();

      request.fields['emergency_contact_person_name'] = emergencyContactName.value.toString();
      request.fields['emergency_contact_number'] = emergencyContactNumber.value.toString();
      request.fields['residance_area'] = residanceArea.value.toString();
      request.fields['fblink'] = facebookLink.value.toString();
      request.fields['>nominee_name '] = nomineeName.value.toString();
       request.fields['nominee_contact'] = nomineeContact.value.toString();
      request.fields['nominee_relation'] = nominneeRelation.value.toString();
      

      request.fields['blood_group'] = bloodGroup.value.toString();

      request.headers.addAll(
        {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      );
      http.MultipartFile profilePicFile =
          await http.MultipartFile.fromPath("profile_picture", "${profilePic.value}");
      http.MultipartFile nid1PartFile =
          await http.MultipartFile.fromPath("nid_front_photo", "${nidPic1.value}");
      http.MultipartFile nid2PartFile =
          await http.MultipartFile.fromPath("nid_back_photo", "${nidPic2.value}");
         
      http.MultipartFile idCartFile1 =
          await http.MultipartFile.fromPath("id_front_photo", "${idPic1.value}");
      http.MultipartFile idCartFile2 =
          await http.MultipartFile.fromPath("id_back_photo", "${idPic2.value}");

      request.files.add(profilePicFile);
      request.files.add(nid2PartFile);
      request.files.add(nid1PartFile);
       request.files.add(idCartFile1);
      request.files.add(idCartFile2);
     
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(" koli ${response.request}");
        print("success");
        Get.snackbar("Image", "Successfully Upload");

        Get.back();
        isLoadingReg2(false);
      }

      return response.statusCode;
    } catch (e) {
      isLoadingReg2(false);
      print("Error $e");
    }
  }
}
