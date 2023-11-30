import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:get/get.dart';

class SendPackageController extends GetxController {
  sendPackage({
    pickup,
    pickDate,
    pickTime,
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
    var mapData = {
      "post_type": "enim",
      "pickuppoint": pickup,
      "date": pickDate,
      "time": pickTime,
      "delivery_date": deliveryDate,
      "delivery_time": deliveryTime,
      "dropoffpoint": dropOff,
      "distance": approxiValue,
      "duration": "quidem",
      "amount": "enim",
      "p_lat": "ut",
      "p_lng": "quidem",
      "d_lat": "alias",
      "d_lng": "fugit",
      "document": "ut",
      "packagetype": packageType,
      "weight": weight,
      "goodtype": goodType,
      "length": "illo",
      "width": "officiis",
      "height": "inventore",
      "document_worth": "atque",
      "ownvehicle": "molestiae",
      "country": "Bangladesh",
      "currency": currency,
      "notes": note
    };
    var response = await ApiService().postData(mapData, "ship");
    if (response.StatusCode == 201) {
      print(response.body);
    }
  }
}
