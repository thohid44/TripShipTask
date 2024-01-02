import 'dart:convert';

GetAllShipRatingModel getAllShipRatingModelFromJson(String str) =>
    GetAllShipRatingModel.fromJson(json.decode(str));

class GetAllShipRatingModel {
  AllShipRatingModel? data;

  GetAllShipRatingModel({
    this.data,
  });

  factory GetAllShipRatingModel.fromJson(Map<String, dynamic> json) =>
      GetAllShipRatingModel(
        data: AllShipRatingModel.fromJson(json["data"]),
      );
}

class AllShipRatingModel {
  List<SendPackageRating>? sendPackageRating;
  List<CarryPackageRating>? carryPackageRating;

  AllShipRatingModel({
    this.sendPackageRating,
    this.carryPackageRating,
  });

  factory AllShipRatingModel.fromJson(Map<String, dynamic> json) =>
      AllShipRatingModel(
        sendPackageRating: List<SendPackageRating>.from(
            json["carry_package_rating"]
                .map((x) => SendPackageRating.fromJson(x))),
          
        carryPackageRating: List<CarryPackageRating>.from(
            json["carry_package_rating"]
                .map((x) => CarryPackageRating.fromJson(x))),
      );
}

class CarryPackageRating {
  var rating;
  String? feedbacks;
  String? shipId;
  String? path;
  String? reviewer;
  DateTime? date;

  CarryPackageRating({
    this.rating,
    this.feedbacks,
    this.shipId,
    this.path,
    this.reviewer,
    this.date,
  });

  factory CarryPackageRating.fromJson(Map<String, dynamic> json) =>
      CarryPackageRating(
        rating: json["rating"],
        feedbacks: json["feedbacks"],
        shipId: json["ship_id"],
        path: json["path"],
        reviewer: json["reviewer"],
        date: DateTime.parse(json["date"]),
      );
}

class SendPackageRating {
   var rating;
  String? feedbacks;
  String? shipId;
  String? path;
  String? reviewer;
  DateTime? date;

  SendPackageRating({
    this.rating,
    this.feedbacks,
    this.shipId,
    this.path,
    this.reviewer,
    this.date,
  });

  factory SendPackageRating.fromJson(Map<String, dynamic> json) =>
      SendPackageRating(
        rating: json["rating"].toDouble(),
        feedbacks: json["feedbacks"],
        shipId: json["ship_id"],
        path: json["path"],
        reviewer: json["reviewer"],
        date: DateTime.parse(json["date"]),
      );
}
