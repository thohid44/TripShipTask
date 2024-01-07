import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/app_constants.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:tripshiptask/pages/Home/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Login/view/email_pin_option_screen.dart';
import 'package:tripshiptask/pages/Login/view/login_screen.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isRegLoading = false.obs;
  var isLogLoading = false.obs;
  final _box = GetStorage();
  var userClient = http.Client();
  var url = "${baseUrl}auth/login";

  login(email, password) async {
  
    try {
  
      var mapData = {
     //   "email": email,
        //  "email":"test2@abaacorp.com",
       "email": "waleed.amin08@gmail.com",
        "password": "123456"
      };

      isLoading(true);
      var response = await http.post(Uri.parse(url), body: mapData);
       Get.to(HomeScreen());
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

  var whatsAppNumber = ''.obs;
  var regUrl = "${baseUrl}auth/signup";
  var uId = ''.obs;

  registration({name, phone, email, gender, password}) async {
    var mapData = {
      "full_name": "$name",
      "mobile": "$phone",
      "whatsapp_number": whatsAppNumber.value,
      "online_communication": "WhatsApp",
      "email": "$email",
      "gender": "$gender",
      "password": "$password",
      "password_confirmation": "$password"
    };
    try {
      isRegLoading(true);
      var response = await http.post(Uri.parse(regUrl), body: mapData);

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        print("success");

        print("Reg $jsonData");
        print("Reg ${response.statusCode}");
        print("Reg $jsonData");

        uId.value = jsonData['id'];
        print("user Id is $uId");

        Get.to(EmailOtpScreen());
      }
      isRegLoading(false);
    } catch (e) {
      isRegLoading(false);
      print("Error $e");
    }
  }

  var optUrl = "${baseUrl}otp-check";
  verifyOTP({v1, v2, v3, v4, v5}) async {
    print("OTP $v1 $v2 $v3 $v4 $v5 ${uId.value}"); 

    var mapData = {
      "digit1": "$v1",
      "digit2": "$v2",
      "digit3": "$v3",
      "digit4": "$v4",
      "digit5": "$v5",
      "user_id": "362"
    };
    try {
      isRegLoading(true);
      var response = await http.post(Uri.parse(optUrl), body: mapData);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        Fluttertoast.showToast(
            msg: "OTP verified Successfully! Please verify your Email.");

        Get.to(LoginScreen());
        isRegLoading(false);
      }
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

    print("Profile Pic: ${profilePic.value}");
    print("Identity No: ${identityNo.value}");
    print("User ID: ${userId.value}");
    print("NID Pic 1: ${nidPic1.value}");
    print("NID Pic 2: ${nidPic2.value}");
    print("Education: ${education.value} Profession: ${profession.value}");

    print("ID Pic 1: ${idPic1.value} ID Pic 2: ${idPic2.value}");

    print("Designation: ${designation.value}");
    print("Company Name: ${companyName.value}");
    print("Nominee Name: ${nomineeName.value}");
    print(
        "Nominee Contact: ${nomineeContact.value} Nominee Relation: ${nominneeRelation.value}");

    print("Question: ${question.value} Answer: ${answer.value}");

    print("Day: ${day.value} Month: ${month.value} Year: ${year.value}");

    print("Emergency Contact Number: ${emergencyContactNumber.value}");
    print("Emergency Contact Name: ${emergencyContactName.value}");
    print("Residence Area: ${residanceArea.value}");
    print("Blood Group: ${bloodGroup.value}");
    print("Facebook Link: ${facebookLink.value}");
    var part =
        "https://app.tripshiptask.com/api/verify/346?expires=1703632897&signature=0c8e34195de2b90f3a744dbfd0f1f469123c37cfbdf44766eafc154202436eef";
    var url = Uri.parse(part);
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

      request.fields['emergency_contact_person_name'] =
          emergencyContactName.value.toString();
      request.fields['emergency_contact_number'] =
          emergencyContactNumber.value.toString();
      request.fields['residance_area'] = residanceArea.value.toString();
      request.fields['fblink'] = facebookLink.value.toString();
      request.fields['>nominee_name '] = nomineeName.value.toString();
      request.fields['nominee_contact'] = nomineeContact.value.toString();
      request.fields['nominee_relation'] = nominneeRelation.value.toString();

      request.fields['blood_group'] = bloodGroup.value.toString();

      request.headers.addAll(
        {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      );
      http.MultipartFile profilePicFile = await http.MultipartFile.fromPath(
          "profile_picture", "${profilePic.value}");
      http.MultipartFile nid1PartFile = await http.MultipartFile.fromPath(
          "nid_front_photo", "${nidPic1.value}");
      http.MultipartFile nid2PartFile = await http.MultipartFile.fromPath(
          "nid_back_photo", "${nidPic2.value}");

      http.MultipartFile idCartFile1 = await http.MultipartFile.fromPath(
          "id_front_photo", "${idPic1.value}");

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
        print(" koli ${request.fields}");
        print(" koli ${request.files}");

        print("success");

        isLoadingReg2(false);
      }

      return response.statusCode;
    } catch (e) {
      isLoadingReg2(false);
      print("Error $e");
    }
  }
}
