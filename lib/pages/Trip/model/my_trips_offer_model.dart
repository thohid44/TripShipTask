// To parse this JSON data, do
//
//     final myTripsOfferModel = myTripsOfferModelFromJson(jsonString);

import 'dart:convert';

MyTripsOfferModel myTripsOfferModelFromJson(String str) =>
    MyTripsOfferModel.fromJson(json.decode(str));

class MyTripsOfferModel {
  List<Datum>? data;

  MyTripsOfferModel({
    this.data,
  });

  factory MyTripsOfferModel.fromJson(Map<String, dynamic> json) =>
      MyTripsOfferModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  var tripId;
  var tripDate;
  String? tripStartPoint;
  String? tripDestination;
  var userId;
  var amount;
  var co;
  var accepted;
  String? path;

  Datum({
    this.tripId,
    this.tripDate,
    this.tripStartPoint,
    this.tripDestination,
    this.userId,
    this.amount,
    this.co,
    this.accepted,
    this.path,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        tripId: json["trip_id"],
        tripDate: DateTime.parse(json["trip_date"]),
        tripStartPoint: json["trip_start_point"],
        tripDestination: json["trip_destination"],
        userId: json["user_id"],
        amount: json["amount"],
        co: json["co"],
        accepted: json["accepted"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "trip_date":
            "${tripDate.year.toString().padLeft(4, '0')}-${tripDate.month.toString().padLeft(2, '0')}-${tripDate.day.toString().padLeft(2, '0')}",
        "trip_start_point": tripStartPoint,
        "trip_destination": tripDestination,
        "user_id": userId,
        "amount": amount,
        "co": co,
        "accepted": accepted,
        "path": path,
      };
}
