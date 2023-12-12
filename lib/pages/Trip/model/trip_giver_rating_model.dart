// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
    String? bidderId;
    String? posterId;
    String? tripId;
    String? bidId;
    String? rating;
    List<String>? review;

    ReviewModel({
        this.bidderId,
        this.posterId,
        this.tripId,
        this.bidId,
        this.rating,
        this.review,
    });

    factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        bidderId: json["bidderId"],
        posterId: json["posterId"],
        tripId: json["tripId"],
        bidId: json["bidId"],
        rating: json["rating"],
        review: List<String>.from(json["review"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "bidderId": bidderId,
        "posterId": posterId,
        "tripId": tripId,
        "bidId": bidId,
        "rating": rating,
        "review": List<dynamic>.from(review!.map((x) => x)),
    };
}
