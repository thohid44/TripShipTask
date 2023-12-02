import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:get/get.dart';

class SendPackageController extends GetxController {
  sendPackage({
    pickup, pickDate,pickTime, willingPay,  dropOff, deliveryTime,
    deliveryDate, currency, sendItem, goodType, pPointLat, pPointLng, dPointLat, 
    dPointLng,approxiValue, packageType,
 weight,
    note,
  }) async {
    var mapData = {
      "post_type": "send_package",
      "pickuppoint": pickup,
      "date": pickDate,
      "time": pickTime,
      "delivery_date": deliveryDate,
      "delivery_time": deliveryTime,
      "dropoffpoint": dropOff,
      "distance": approxiValue,
      "duration": "2",
      "amount": willingPay,
      "p_lat": pPointLat,
      "p_lng": pPointLng,
      "d_lat": dPointLat,
      "d_lng": dPointLng,
      "document": "ut",
      "packagetype": packageType,
      "weight": weight,
      "goodtype": goodType,
      "length": "illo",
      "width": "officiis",
      "height": "inventore",
      "document_worth": "atque",
      "ownvehicle": "molestiae",
      "country": "BD",
      "currency": "BDT",
      "notes": note
    };
    var response = await ApiService().postData(mapData, "ship");
    if (response.StatusCode == 201) {
      print(response.body);
    }
  }
}
