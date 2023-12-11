import 'package:tripshiptask/Api_services/ApiService.dart';
import 'package:get/get.dart';

class CarryPackageController extends GetxController {
  carryPackage(
    String pickup,
    String pickDate,
    String pickTime,
    String dropOff,
    deliveryTime,
    deliveryDate,
    String currency,
    String packageType,
    String note,
  ) async {
    var mapData = {
      "ship_id": "porro",
      "pickuppoint": pickup,
      "date": "omnis",
      "time": "officiis",
      "delivery_date": "",
      "delivery_time": "minima",
      "dropoffpoint": "harum",
      "amount": "mollitia",
      "p_lat": "quia",
      "p_lng": "iste",
      "d_lat": "optio",
      "d_lng": "sit",
      "material": "quis",
      "material_type": "dolores",
      "package_type": "nostrum",
      "notes": "quitripshiptaskdam",
      "weight": "dolores",
      "length": "vero",
      "width": "necessitatitripshiptask",
      "height": "voluptas"
    };
    var response = await ApiService().postData(mapData, "ship");
    if (response.StatusCode == 201) {
      print(response.body);
    }
  }
}
