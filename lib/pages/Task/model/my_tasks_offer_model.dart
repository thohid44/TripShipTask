// To parse this JSON data, do
//
//     final myTasksOfferModel = myTasksOfferModelFromJson(jsonString);

import 'dart:convert';

MyTasksOfferModel myTasksOfferModelFromJson(String str) => MyTasksOfferModel.fromJson(json.decode(str));


class MyTasksOfferModel {
    List<MyTasksOffer>? data;

    MyTasksOfferModel({
        this.data,
    });

    factory MyTasksOfferModel.fromJson(Map<String, dynamic> json) => MyTasksOfferModel(
        data: List<MyTasksOffer>.from(json["data"].map((x) => MyTasksOffer.fromJson(x))),
    );

}

class MyTasksOffer {
    String? taskId;
    String? location;
    String? title;
    DateTime? taskDate;
    int? userId;
    int? amount;
    dynamic co;
    var accepted;
    String? path;

    MyTasksOffer({
        this.taskId,
        this.location,
        this.title,
        this.taskDate,
        this.userId,
        this.amount,
        this.co,
        this.accepted,
        this.path,
    });

    factory MyTasksOffer.fromJson(Map<String, dynamic> json) => MyTasksOffer(
        taskId: json["task_id"],
        location: json["location"],
        title: json["title"],
        taskDate: DateTime.parse(json["task_date"]),
        userId: json["user_id"],
        amount: json["amount"],
        co: json["co"],
        accepted: json["accepted"],
        path: json["path"],
    );

   
}
