// To parse this JSON data, do
//
//     final getAllTaskRatingModel = getAllTaskRatingModelFromJson(jsonString);

import 'dart:convert';

GetAllTaskRatingModel getAllTaskRatingModelFromJson(String str) => GetAllTaskRatingModel.fromJson(json.decode(str));


class GetAllTaskRatingModel {
    AllTaskRatingModel? data;

    GetAllTaskRatingModel({
        this.data,
    });

    factory GetAllTaskRatingModel.fromJson(Map<String, dynamic> json) => GetAllTaskRatingModel(
        data: AllTaskRatingModel.fromJson(json["data"]),
    );

  
}

class AllTaskRatingModel {
    List<TaskRating>? offerTaskRating;
    List<TaskRating>? wantTaskRating;

    AllTaskRatingModel({
        this.offerTaskRating,
        this.wantTaskRating,
    });

    factory AllTaskRatingModel.fromJson(Map<String, dynamic> json) => AllTaskRatingModel(
        offerTaskRating: List<TaskRating>.from(json["offer_task_rating"].map((x) => TaskRating.fromJson(x))),
        wantTaskRating: List<TaskRating>.from(json["want_task_rating"].map((x) => TaskRating.fromJson(x))),
    );

  
}

class TaskRating {
    var rating;
    String? feedbacks;
    String? taskId;
    String? path;
    String? reviewer;
    DateTime? date;

    TaskRating({
        this.rating,
        this.feedbacks,
        this.taskId,
        this.path,
        this.reviewer,
        this.date,
    });

    factory TaskRating.fromJson(Map<String, dynamic> json) => TaskRating(
        rating: json["rating"],
        feedbacks: json["feedbacks"],
        taskId: json["task_id"],
        path: json["path"],
        reviewer: json["reviewer"],
        date: DateTime.parse(json["date"]),
    );

  
}
