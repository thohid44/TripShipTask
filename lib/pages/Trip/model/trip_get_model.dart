// To parse this JSON data, do
//
//     final tripGetModel = tripGetModelFromJson(jsonString);

import 'dart:convert';

TripGetModel tripGetModelFromJson(String str) => TripGetModel.fromJson(json.decode(str));


class TripGetModel {
    List<TripGetListModel>? tripGetListModel;

    TripGetModel({
        this.tripGetListModel,
    });

    factory TripGetModel.fromJson(Map<String, dynamic> json) => TripGetModel(
        tripGetListModel: List<TripGetListModel>.from(json["TripGetListModel"].map((x) => TripGetListModel.fromJson(x))),
    );

   
}

class TripGetListModel {
    String? startPoint;
    String? destination;
    String? pay;
    String? vehicleType;
    String? vehicleSeat;
    int? bidsCount;
    String? path;

    TripGetListModel({
        this.startPoint,
        this.destination,
        this.pay,
        this.vehicleType,
        this.vehicleSeat,
        this.bidsCount,
        this.path,
    });

    factory TripGetListModel.fromJson(Map<String, dynamic> json) => TripGetListModel(
        startPoint: json["start_point"],
        destination: json["destination"],
        pay: json["pay"],
        vehicleType: json["vehicle_type"],
        vehicleSeat: json["vehicle_seat"],
        bidsCount: json["bids_count"],
        path: json["path"],
    );

   
}
