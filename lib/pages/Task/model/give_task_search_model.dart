import 'dart:convert';

GiveTaskSearchModel giveTaskSearchModelFromJson(String str) =>
    GiveTaskSearchModel.fromJson(json.decode(str));

class GiveTaskSearchModel {
  List<GiveTaskSearchModel2>? data;

  GiveTaskSearchModel({
    this.data,
  });

  factory GiveTaskSearchModel.fromJson(Map<String, dynamic> json) =>
      GiveTaskSearchModel(
        data: List<GiveTaskSearchModel2>.from(
            json["data"].map((x) => GiveTaskSearchModel2.fromJson(x))),
      );
}

class GiveTaskSearchModel2 {
  String? title;
  String? location;
  var date;
  int? amount;
  int? bidsCount;
  var path;

  GiveTaskSearchModel2({
    this.title,
    this.location,
    this.date,
    this.amount,
    this.bidsCount,
    this.path,
  });

  factory GiveTaskSearchModel2.fromJson(Map<String, dynamic> json) =>
      GiveTaskSearchModel2(
        title: json["title"],
        location: json["location"],
        date: json["date"],
        amount: json["amount"],
        bidsCount: json["bids_count"],
        path: json["path"],
      );
}
