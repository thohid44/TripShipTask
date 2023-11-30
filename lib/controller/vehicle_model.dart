

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) => VehicleModel.fromJson(json.decode(str));



class VehicleModel {
    List<VehiclesModel>? data;

    VehicleModel({
        this.data,
    });

    factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        data: List<VehiclesModel>.from(json["data"].map((x) => VehiclesModel.fromJson(x))),
    );

}

class VehiclesModel {
    int? id;
    int? userId;
    String? type;
    String? model;
    String? licenceNumber;
    String? vinNumber;
    String? color;
    String? document;
    String? dl;

    VehiclesModel({
        this.id,
        this.userId,
        this.type,
        this.model,
        this.licenceNumber,
        this.vinNumber,
        this.color,
        this.document,
        this.dl,
    });

    factory VehiclesModel.fromJson(Map<String, dynamic> json) => VehiclesModel(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        model: json["model"],
        licenceNumber: json["licence_number"],
        vinNumber: json["vin_number"],
        color: json["color"],
        document: json["document"],
        dl: json["dl"],
    );

}
