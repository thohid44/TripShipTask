import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/app_constants.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Ship/model/my_ship_model.dart';
import 'package:tripshiptask/support_Ticket/model/ticket_category_model.dart';

class SupportController extends GetxController {
  final _box = GetStorage();
  var isSubmitLoading = false.obs;
  var category = ''.obs;
  var subject = ''.obs;
  var message = ''.obs;
  var refLink = ''.obs;
  var file = ''.obs;

  void onInit() {
   
    super.onInit();
     getTicketCategory();
  }

  supportSumbit() async {
    var token = _box.read(LocalStoreKey.token);

    var url = Uri.parse("${AppConstants.baseUrl}ticket");
    try {
      isSubmitLoading(true);
      //multipart post
      print("process");
      http.MultipartRequest request = http.MultipartRequest('Post', url);

      request.fields['category'] = category.value.toString();
      request.fields['subject'] = subject.value.toString();
      request.fields['message'] = message.value.toString();
      request.fields['ref_link'] = refLink.value.toString();

      request.headers.addAll(
        {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      );

      http.MultipartFile supportFile =
          await http.MultipartFile.fromPath("file", "${file.value}");
      request.files.add(supportFile);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(" koli ${response.request}");
        print("success");
        Fluttertoast.showToast(msg: "Support Successfully Send");
        isSubmitLoading(false);
      }

      return response.statusCode;
    } catch (e) {
      isSubmitLoading(false);
      print("Error $e");
    }
  }

  var isLoading = false.obs;
  List<TicketCategoryModel> ticketCategoryList = <TicketCategoryModel>[].obs;

  getTicketCategory() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}ticket-categories"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
           for (Map<String, dynamic> index in jsonData) {
          ticketCategoryList.add(TicketCategoryModel.fromJson(index));
        }
       

        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

  getMyTicket() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}ticket"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);


        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }
}
