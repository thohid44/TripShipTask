// To parse this JSON data, do
//
//     final myShipModel = myShipModelFromJson(jsonString);

import 'dart:convert';

MyShipModel myShipModelFromJson(String str) => MyShipModel.fromJson(json.decode(str));



class MyShipModel {
    MyShip? data;

    MyShipModel({
        this.data,
    });

    factory MyShipModel.fromJson(Map<String, dynamic> json) => MyShipModel(
        data: MyShip.fromJson(json["data"]),
    );

  
}

class MyShip {
    List<Package>? sendPackages;
    List<Package>? carryPackages;
    List<Package>? completedShipments;

    MyShip({
        this.sendPackages,
        this.carryPackages,
        this.completedShipments,
    });

    factory MyShip.fromJson(Map<String, dynamic> json) => MyShip(
        sendPackages: List<Package>.from(json["send_packages"].map((x) => Package.fromJson(x))),
        carryPackages: List<Package>.from(json["carry_packages"].map((x) => Package.fromJson(x))),
        completedShipments: List<Package>.from(json["completed_shipments"].map((x) =>Package.fromJson(x))),
    );

  
}

class Package {
    int? id;
    String? title;
    String? postType;
    String? status;
    String? shipmentId;
    String? startPoint;
    String? destination;
    DateTime? pickupDate;
    String? pickupTime;
    dynamic? deliveryDateTime;
    String? path;
    String? slug;
    String? documents;
    int? documentPrice;
    int? amount;
    int? ownVehicle;
    dynamic? shipmentRating;
    dynamic? length;
    dynamic? width;
    dynamic? height;
    String? weight;
    String? packageType;
    String? goodType;
    dynamic? details;
    int? userId;
    String? posted;
    String? user;

    Package({
        this.id,
        this.title,
        this.postType,
        this.status,
        this.shipmentId,
        this.startPoint,
        this.destination,
        this.pickupDate,
        this.pickupTime,
        this.deliveryDateTime,
        this.path,
        this.slug,
        this.documents,
        this.documentPrice,
        this.amount,
        this.ownVehicle,
        this.shipmentRating,
        this.length,
        this.width,
        this.height,
        this.weight,
        this.packageType,
        this.goodType,
        this.details,
        this.userId,
        this.posted,
        this.user,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        title: json["title"],
        postType: json["post_type"],
        status: json["status"],
        shipmentId: json["shipment_id"],
        startPoint: json["start_point"],
        destination: json["destination"],
        pickupDate: DateTime.parse(json["pickup_date"]),
        pickupTime: json["pickup_time"],
        deliveryDateTime: json["delivery_date_time"],
        path: json["path"],
        slug: json["slug"],
        documents: json["documents"],
        documentPrice: json["document_price"],
        amount: json["amount"],
        ownVehicle: json["own_vehicle"],
        shipmentRating: json["shipment_rating"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        weight: json["weight"],
        packageType: json["package_type"],
        goodType: json["good_type"],
        details: json["details"],
        userId: json["user_id"],
        posted: json["posted"],
        user: json["user"],
    );

}
