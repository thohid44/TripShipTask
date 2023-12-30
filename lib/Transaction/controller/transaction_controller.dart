import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Transaction/model/my_transaction_model.dart';
import 'package:tripshiptask/Utils/app_constants.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/support_Ticket/model/my_tickets.dart';
import 'package:tripshiptask/support_Ticket/model/ticket_category_model.dart';

class TransactionController extends GetxController {
  final _box = GetStorage();
  var isSubmitLoading = false.obs;

  void onInit() {
    super.onInit();
    getMyTransaction() ;
  }



  var isLoading = false.obs;
  List<TicketCategoryModel> ticketCategoryList = <TicketCategoryModel>[].obs;



  var isMyLoading = false.obs;
  MyTransactionModel? myTransactionModel;
  getMyTransaction() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isMyLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}transactions/view"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
            var jsonData = jsonDecode(response.body);
        print("My Transaction $jsonData");
      if (response.statusCode == 200) {
  
        MyTransactionModel data = MyTransactionModel.fromJson(jsonData);
        myTransactionModel = data;
      
  print(myTransactionModel!.bidData!.accepted);
        isMyLoading(false);
      }
    } catch (e) {
      isMyLoading(false);
      print("Error $e");
    }
  }
}
