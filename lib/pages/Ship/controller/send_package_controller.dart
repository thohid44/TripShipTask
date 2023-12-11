import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:get/get.dart';
import 'package:tripshiptask/Utils/colors.dart';

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

    var mapData = {
      "post_type": "send_package",
      "pickuppoint": pickup.toString(),
      "date": pickDate.toString(),
      "time": pickTime.toString(),
      "delivery_date": deliveryDate.toString(),
      "delivery_time": deliveryTime.toString(),
      "dropoffpoint": dropOff.toString(),
      "distance": approxiValue.toString(),
      "duration": "2",
      "amount": willingPay.toString(),
      "p_lat": pPointLat.toString(),
      "p_lng": pPointLng.toString(),
      "d_lat": dPointLat.toString(),
      "d_lng": dPointLng.toString(),
      "document": "books",
      "packagetype": packageType.toString(),
      "weight": weight.toString(),
      "goodtype": goodType.toString(),
      "length": "",
      "width": "",
      "height": "",
      "document_worth": "",
      "ownvehicle": "",
      "country": "BD",
      "currency": "BDT",
      "notes": note
    };

    try {
      isLoading(true);
      var response = await ApiService().postData(mapData, "ship");
      print("ship response ${response.statusCode}");
       var jsonData = jsonDecode(response.body);
        print(jsonData);
    
       
        Get.snackbar("Send Package", "Successfully Store",
            backgroundColor: primaryColor);
    
    } catch (e) {
      print("Error $e");
    }
  }
}
