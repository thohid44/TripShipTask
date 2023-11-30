// To parse this JSON data, do
//
//     final allGiveTaskPostModel = allGiveTaskPostModelFromJson(jsonString);

import 'dart:convert';

AllGiveTaskPostModel allGiveTaskPostModelFromJson(String str) => AllGiveTaskPostModel.fromJson(json.decode(str));


class AllGiveTaskPostModel {
    List<AllGiveTaskModel>? data;

    AllGiveTaskPostModel({
        this.data,
    });

    factory AllGiveTaskPostModel.fromJson(Map<String, dynamic> json) => AllGiveTaskPostModel(
        data: List<AllGiveTaskModel>.from(json["data"].map((x) => AllGiveTaskModel.fromJson(x))),
    );

}


class AllGiveTaskModel {
    String? title;
    String? location;
    var date;
    int? amount;
    int? bidsCount;
    String? path;

    AllGiveTaskModel({
        this.title,
        this.location,
        this.date,
        this.amount,
        this.bidsCount,
        this.path,
    });

    factory AllGiveTaskModel.fromJson(Map<String, dynamic> json) => AllGiveTaskModel(
        title: json["title"],
        location: json["location"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
        bidsCount: json["bids_count"],
        path: json["path"],
    );

  
}