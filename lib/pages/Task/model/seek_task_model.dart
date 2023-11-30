// To parse this JSON data, do
//
//     final seekTaskModel = seekTaskModelFromJson(jsonString);

import 'dart:convert';

SeekTaskModel seekTaskModelFromJson(String str) => SeekTaskModel.fromJson(json.decode(str));


class SeekTaskModel {
    List<SeekTaskModelList>? data;

    SeekTaskModel({
         this.data,
    });

    factory SeekTaskModel.fromJson(Map<String, dynamic> json) => SeekTaskModel(
        data: List<SeekTaskModelList>.from(json["data"].map((x) => SeekTaskModelList.fromJson(x))),
    );

  
}

class SeekTaskModelList {
    String? title;
    String? location;
    var date;
    int? amount;
    int? bidsCount;
    String? path;

    SeekTaskModelList({
         this.title,
         this.location,
         this.date,
         this.amount,
         this.bidsCount,
         this.path,
    });

    factory SeekTaskModelList.fromJson(Map<String, dynamic> json) => SeekTaskModelList(
        title: json["title"],
        location: json["location"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
        bidsCount: json["bids_count"],
        path: json["path"],
    );

  
}
