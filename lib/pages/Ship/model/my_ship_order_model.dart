// To parse this JSON data, do
//
//     final myShipOrderModel = myShipOrderModelFromJson(jsonString);

import 'dart:convert';

MyShipOrderModel myShipOrderModelFromJson(String str) => MyShipOrderModel.fromJson(json.decode(str));


class MyShipOrderModel {
    List<MyShipsOrderModel>? data;

    MyShipOrderModel({
        this.data,
    });

    factory MyShipOrderModel.fromJson(Map<String, dynamic> json) => MyShipOrderModel(
        data: List<MyShipsOrderModel>.from(json["data"].map((x) => MyShipsOrderModel.fromJson(x))),
    );

   
}

class MyShipsOrderModel {
    String? shipmentId;
    DateTime? pickupDate;
    String? pickupPoint;
    String? dropoffPoint;
    int? userId;
    int? amount;
    dynamic? co;
    int? accepted;
    String? path;

    MyShipsOrderModel({
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

    factory MyShipsOrderModel.fromJson(Map<String, dynamic> json) => MyShipsOrderModel(
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
