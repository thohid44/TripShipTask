import 'dart:convert';

TripSearchModel tripSearchModelFromJson(String str) =>
    TripSearchModel.fromJson(json.decode(str));

class TripSearchModel {
  List<TripSearchM>? data;

  TripSearchModel({
    this.data,
  });

  factory TripSearchModel.fromJson(Map<String, dynamic> json) =>
      TripSearchModel(
        data: List<TripSearchM>.from(
            json["data"].map((x) => TripSearchM.fromJson(x))),
      );
}

class TripSearchM {
  String? startPoint;
  String? destination;
  String? pay;
  String? vehicleType;
  String? vehicleSeat;
  int? bidsCount;
  String? path;

  TripSearchM({
    this.startPoint,
    this.destination,
    this.pay,
    this.vehicleType,
    this.vehicleSeat,
    this.bidsCount,
    this.path,
  });

  factory TripSearchM.fromJson(Map<String, dynamic> json) => TripSearchM(
        startPoint: json["start_point"],
        destination: json["destination"],
        pay: json["pay"],
        vehicleType: json["vehicle_type"],
        vehicleSeat: json["vehicle_seat"],
        bidsCount: json["bids_count"],
        path: json["path"],
      );
}
