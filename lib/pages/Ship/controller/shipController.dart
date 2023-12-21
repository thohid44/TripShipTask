import 'dart:convert';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/colors.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tripshiptask/pages/Ship/model/my_ship_model.dart';
import 'package:tripshiptask/pages/Ship/model/ship_search_model.dart';

class ShipController extends GetxController {
  final _box = GetStorage();
  var isLoading = false.obs;
  var isLoadSearch = false.obs;
  var isShipCarryLoading = false.obs;
  List<ShipSearchModel> shipSearchList = <ShipSearchModel>[].obs;
  List<ShipSearchModel> shipCarryPostList = <ShipSearchModel>[].obs;
  MyShip? myShip;

  var pth;
  void onInit() {
    super.onInit();
    getMyShips();
    fetchAllSendShip();
    fetchAllCarryShip();
  }

  getMyShips() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("${baseUrl}myship"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);

        MyShipModel data = MyShipModel.fromJson(jsonData);
        myShip = data.data;
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

//   bidOnGivenShip({amount, shipId, message}) async {
//     var token = _box.read(LocalStoreKey.token);
//     print(token);
//     var mapData = {
//       "bidamount": amount.toString(),
//       "ship_id": shipId.toString(),
//       "message": message.toString()
//     };
//     print("ship amount $amount");
//     print(shipId);
//     print(message);

//     try {
//       isLoading(true);
//       var response = await ApiService().postData(mapData, "shipbids");
// print("status code ${response.statusCode}");
//       if (response.statusCode == 202) {
//         print(response.statusCode);
//         var jsonData = jsonDecode(response.body);
//         print("offer $jsonData");
//         Get.snackbar("Ship Offer", "Make Successfully ",
//             backgroundColor: navyBlueColor);
//       }
//     } catch (e) {
//       print("Error $e");
//     }
//   }

//   counterShipOffer({bidId, amount}) async {
//     var token = _box.read(LocalStoreKey.token);

//    final jsonData = {'co': [amount]};
// final jsonString = jsonEncode(jsonData);
// print("co $jsonString");
//   List<dynamic> amt = [amount];
//     print("amount $amount");
//     print("Bid Id $bidId");
//     var data = {'co': amt.toString()};
//     try {
//       isLoading(true);

//       var response = await http.patch(Uri.parse("${baseUrl}shipbids/$bidId"),
//           headers: {
            
//             'Authorization': 'Bearer ' + token,
//           },
//           body: jsonEncode(data));

//       print(response.statusCode);

//       if (response.statusCode == 200) {
//         print(response.statusCode);
//         var jsonData = jsonDecode(response.body);
//         print("counter offer $jsonData");
//         Get.snackbar("Trip Offer", "Make Successfully ",
//             backgroundColor: navyBlueColor);
//       }
//     } catch (e) {
//       print("Error $e");
//     }
//   }


//   giveShipAgree(bidId) async {
//     var token = _box.read(LocalStoreKey.token);

//     var mapData = {"agree": '1'};
//     print(" bid id $bidId");
//     try {
//       isLoading(true);
//       //  var response = await ApiService().postData(mapData, "tripbids/$bidId");
//       var response = await http.patch(Uri.parse("${baseUrl}shipbids/$bidId"),
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer ' + token,
//           },
//           body: mapData);

//       print(" status code ${response.statusCode}");

//       if (response.statusCode == 200) {
//         var jsonData = jsonDecode(response.body);
//         print("counter offer $jsonData");
//         Get.snackbar("Trip Offer", "Agree Successfully ",
//             backgroundColor: navyBlueColor);
//       }
//     } catch (e) {
//       print("Error $e");
//     }
//   }

  fetchAllSendShip() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isLoadSearch(true);
      shipSearchList.clear();

      var response = await http.get(
        Uri.parse("${baseUrl}ship-search?post_type=send_package"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      var jsonData = jsonDecode(response.body);
      print("ship search data $jsonData");
      if (response.statusCode == 200) {
        ShipSearchListModel data = ShipSearchListModel.fromJson(jsonData);

        shipSearchList = data.data!;
        isLoadSearch(false);
      }
    } catch (e) {
      isLoadSearch(false);
      print("Error $e");
    }
  }

  fetchAllCarryShip() async {
    var token = _box.read(LocalStoreKey.token);

    try {
      isShipCarryLoading(true);
      shipCarryPostList.clear();

      var response = await http.get(
        Uri.parse("${baseUrl}ship-search?post_type=carry_package"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      );
      var jsonData = jsonDecode(response.body);
      print("ship search data $jsonData");
      if (response.statusCode == 200) {
        ShipSearchListModel data = ShipSearchListModel.fromJson(jsonData);

        shipCarryPostList = data.data!;
        isShipCarryLoading(false);
      }
    } catch (e) {
      isShipCarryLoading(false);
      print("Error $e");
    }
  }

 
}
