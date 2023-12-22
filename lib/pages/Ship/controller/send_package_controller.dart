import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Api_services/base_url.dart';
import 'package:tripshiptask/Utils/localstorekey.dart';
import 'package:http/http.dart' as http;

class SendPackageController extends GetxController {
  var isLoading = false.obs;
  final _box = GetStorage();
  sendPackage({
    pickup,
    pickDate,
    pickTime,
    willingPay,
    dropOff,
    deliveryTime,
    deliveryDate,
    currency,
    sendItem,
    goodType,
    pPointLat,
    pPointLng,
    dPointLat,
    dPointLng,
    approxiValue,
    packageType,
    weight,
    note,
  }) async {
    print("pickup value is \$pickup: $pickup");
    print("pickDate value is \$pickDate: $pickDate");
    print("pickTime value is \$pickTime: $pickTime");
    print("willingPay value is \$willingPay: $willingPay");
    print("dropOff value is \$dropOff: $dropOff");
    print("deliveryTime value is \$deliveryTime: $deliveryTime");
    print("deliveryDate value is \$deliveryDate: $deliveryDate");
    print("currency value is \$currency: $currency");
    print("sendItem value is \$sendItem: $sendItem");
    print("goodType value is \$goodType: $goodType");
    print("pPointLat value is \$pPointLat: $pPointLat");
    print("pPointLng value is \$pPointLng: $pPointLng");
    print("dPointLat value is \$dPointLat: $dPointLat");
    print("dPointLng value is \$dPointLng: $dPointLng");
    print("approxiValue value is \$approxiValue: $approxiValue");
    print("packageType value is \$packageType: $packageType");
    print("weight value is \$weight: $weight");
    print("note value is \$note: $note");

    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.post(Uri.parse("${baseUrl}ship"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            "post_type": "send_package",
            "pickuppoint": "$pickup",
            "date": "$pickDate",
            "time": "$pickTime",
            "delivery_date": "$deliveryDate",
            "delivery_time": "$deliveryTime",
            "dropoffpoint": "$dropOff",
            "distance": "3",
            "duration": "2",
            "amount": "$willingPay",
            "p_lat": "$pPointLat",
            "p_lng": "$pPointLng",
            "d_lat": "$dPointLat",
            "d_lng": "$dPointLng",
            "document": "$sendItem",
            "packagetype": "$packageType",
            "weight": "$weight",
            "goodtype": "$goodType",
            "length": "0",
            "width": "0",
            "height": "0",
            "document_worth": "$approxiValue",
            "ownvehicle": "",
            "country": "BD",
            "currency": "BDT",
            "notes": "$note"
          }));
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print("Trip Post $jsonData");
        Get.snackbar(
          "Get Ride",
          "Successfully Store",
        );
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }

  sendPackageUpdate({
    slug,
    pickup,
    pickDate,
    pickTime,
    willingPay,
    dropOff,
    deliveryTime,
    deliveryDate,
    currency,
    sendItem,
    goodType,
    pPointLat,
    pPointLng,
    dPointLat,
    dPointLng,
    approxiValue,
    packageType,
    weight,
    note,
  }) async {
    print("pickup value is \$pickup: $pickup");
    print("pickDate value is \$pickDate: $pickDate");
    print("pickTime value is \$pickTime: $pickTime");
    print("willingPay value is \$willingPay: $willingPay");
    print("dropOff value is \$dropOff: $dropOff");
    print("deliveryTime value is \$deliveryTime: $deliveryTime");
    print("deliveryDate value is \$deliveryDate: $deliveryDate");
    print("currency value is \$currency: $currency");
    print("sendItem value is \$sendItem: $sendItem");
    print("goodType value is \$goodType: $goodType");
    print("pPointLat value is \$pPointLat: $pPointLat");
    print("pPointLng value is \$pPointLng: $pPointLng");
    print("dPointLat value is \$dPointLat: $dPointLat");
    print("dPointLng value is \$dPointLng: $dPointLng");
    print("approxiValue value is \$approxiValue: $approxiValue");
    print("packageType value is \$packageType: $packageType");
    print("weight value is \$weight: $weight");
    print("note value is \$note: $note");

    var token = _box.read(LocalStoreKey.token);

    try {
      isLoading(true);
      var response = await http.put(Uri.parse("${baseUrl}ship/$slug"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + token,
          },
          body: jsonEncode({
            "post_type": "send_package",
            "pickuppoint": "$pickup",
            "date": "$pickDate",
            "time": "$pickTime",
            "delivery_date": "$deliveryDate",
            "delivery_time": "$deliveryTime",
            "dropoffpoint": "$dropOff",
            "distance": "3",
            "duration": "2",
            "amount": "$willingPay",
            "p_lat": "$pPointLat",
            "p_lng": "$pPointLng",
            "d_lat": "$dPointLat",
            "d_lng": "$dPointLng",
            "document": "$sendItem",
            "packagetype": "$packageType",
            "weight": "$weight",
            "goodtype": "$goodType",
            "length": "",
            "width": "",
            "height": "",
            "document_worth": "$approxiValue",
            "ownvehicle": "",
            "country": "BD",
            "currency": "BDT",
            "notes": "$note"
          }));
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = jsonDecode(response.body);
        print("Trip Post $jsonData");
        Get.snackbar(
          "Send Package",
          "Successfully Update",
        );
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error $e");
    }
  }
}
