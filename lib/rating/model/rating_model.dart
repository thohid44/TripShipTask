// To parse this JSON data, do
//
//     final ratingDataModel = ratingDataModelFromJson(jsonString);

import 'dart:convert';

RatingDataModel ratingDataModelFromJson(String str) => RatingDataModel.fromJson(json.decode(str));



class RatingDataModel {
    RatingModel? data;

    RatingDataModel({
        this.data,
    });

    factory RatingDataModel.fromJson(Map<String, dynamic> json) => RatingDataModel(
        data: RatingModel.fromJson(json["data"]),
    );

  
}

class RatingModel {
    List<TripsRating>? gaveTripsRating;
    List<TripsRating>? getTripsRating;

    RatingModel({
        this.gaveTripsRating,
        this.getTripsRating,
    });

    factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        gaveTripsRating: List<TripsRating>.from(json["gave_trips_rating"].map((x) => TripsRating.fromJson(x))),
        getTripsRating: List<TripsRating>.from(json["get_trips_rating"].map((x) => TripsRating.fromJson(x))),
    );


}

class TripsRating {
    var rating;
    String? feedbacks;
    String? tripId;
    String? path;
    String? reviewer;
    DateTime? date;

    TripsRating({
        this.rating,
        this.feedbacks,
        this.tripId,
        this.path,
        this.reviewer,
        this.date,
    });

    factory TripsRating.fromJson(Map<String, dynamic> json) => TripsRating(
        rating: json["rating"].toDouble(),
        feedbacks: json["feedbacks"],
        tripId: json["trip_id"],
        path: json["path"],
        reviewer: json["reviewer"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "feedbacks": feedbacks,
        "trip_id": tripId,
        "path": path,
        "reviewer": reviewer,
        "date": date!.toIso8601String(),
    };
}
