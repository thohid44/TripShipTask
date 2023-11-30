// To parse this JSON data, do
//
//     final shipSearchListModel = shipSearchListModelFromJson(jsonString);

import 'dart:convert';

ShipSearchListModel shipSearchListModelFromJson(String str) => ShipSearchListModel.fromJson(json.decode(str));


class ShipSearchListModel {
    List<ShipSearchModel>? data;

    ShipSearchListModel({
        this.data,
    });

    factory ShipSearchListModel.fromJson(Map<String, dynamic> json) => ShipSearchListModel(
        data: List<ShipSearchModel>.from(json["data"].map((x) => ShipSearchModel.fromJson(x))),
    );

 
}

class ShipSearchModel {
    String? startPoint;
    String? destination;
    String? documents;
    var pickupDate;
    var deliveryDate;
    int? bidsCount;
    String? path;

    ShipSearchModel({
        this.startPoint,
        this.destination,
        this.documents,
        this.pickupDate,
        this.deliveryDate,
        this.bidsCount,
        this.path,
    });

    factory ShipSearchModel.fromJson(Map<String, dynamic> json) => ShipSearchModel(
        startPoint: json["start_point"],
        destination: json["destination"],
        documents: json["documents"],
        pickupDate: json["pickup_date"],
        deliveryDate: json["delivery_date"],
        bidsCount: json["bids_count"],
        path: json["path"],
    );

   
}
