// To parse this JSON data, do
//
//     final myShipOfferModel = myShipOfferModelFromJson(jsonString);

import 'dart:convert';

MyShipOfferModel myShipOfferModelFromJson(String str) => MyShipOfferModel.fromJson(json.decode(str));


class MyShipOfferModel {
    List<MyShipOffers>? data;

    MyShipOfferModel({
        this.data,
    });

    factory MyShipOfferModel.fromJson(Map<String, dynamic> json) => MyShipOfferModel(
        data: List<MyShipOffers>.from(json["data"].map((x) => MyShipOffers.fromJson(x))),
    );

}

class MyShipOffers {
    String? shipmentId;
    DateTime? pickupDate;
    String? pickupPoint;
    String? dropoffPoint;
    int? userId;
    int? amount;
    String? co;
    int? accepted;
    String? path;

    MyShipOffers({
        this.shipmentId,
        this.pickupDate,
        this.pickupPoint,
        this.dropoffPoint,
        this.userId,
        this.amount,
        this.co,
        this.accepted,
        this.path,
    });

    factory MyShipOffers.fromJson(Map<String, dynamic> json) => MyShipOffers(
        shipmentId: json["shipment_id"],
        pickupDate: DateTime.parse(json["pickup_date"]),
        pickupPoint: json["pickup_point"],
        dropoffPoint: json["dropoff_point"],
        userId: json["user_id"],
        amount: json["amount"],
        co: json["co"],
        accepted: json["accepted"],
        path: json["path"],
    );

}
