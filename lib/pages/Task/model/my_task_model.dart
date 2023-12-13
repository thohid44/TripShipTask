// To parse this JSON data, do
//
//     final myTaskModel = myTaskModelFromJson(jsonString);

import 'dart:convert';

MyTaskModel myTaskModelFromJson(String str) =>
    MyTaskModel.fromJson(json.decode(str));

class MyTaskModel {
  MyAllTaskModel? data;

  MyTaskModel({
    required this.data,
  });

  factory MyTaskModel.fromJson(Map<String, dynamic> json) => MyTaskModel(
        data: MyAllTaskModel.fromJson(json["data"]),
      );
}

class MyAllTaskModel {
  List<Task> offerTasks;
  List<Task> seekedTasks;
  List<Task> completedTasks;

  MyAllTaskModel({
    required this.offerTasks,
    required this.seekedTasks,
    required this.completedTasks,
  });

  factory MyAllTaskModel.fromJson(Map<String, dynamic> json) => MyAllTaskModel(
        offerTasks:
            List<Task>.from(json["offer_tasks"].map((x) => Task.fromJson(x))),
        seekedTasks:
            List<Task>.from(json["seeked_tasks"].map((x) => Task.fromJson(x))),
        completedTasks: List<Task>.from(
            json["completed_tasks"].map((x) => Task.fromJson(x))),
      );
}

class Task {
  List<String>? skills;
  var category;
  int? id;
  int? userId;
  var title;
  var taskId;
  var slug;
  var postType;
  var path;
  dynamic taskRating;

  var location;
  var description;
  var status;
  int? personNeed;
  var date;
  var time;
  int? hour;
  int? amount;
  var user;
  var createdAt;

  Task({
    this.skills,
    this.category,
    this.id,
    this.userId,
    this.title,
    this.taskId,
    this.slug,
    this.postType,
    this.path,
    this.taskRating,
    this.location,
    this.description,
    this.status,
    this.personNeed,
    this.date,
    this.time,
    this.hour,
    this.amount,
    this.user,
    this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        skills: List<String>.from(json["skills"].map((x) => x)),
        category: json["category"],
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        taskId: json["task_id"],
        slug: json["slug"],
        postType: json["post_type"],
        path: json["path"],
        taskRating: json["task_rating"],
        location: json["location"],
        description: json["description"],
        status: json["status"],
        personNeed: json["person_need"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        hour: json["hour"],
        amount: json["amount"],
        user: json["user"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}

// class LatLng {
//     double lat;
//     double lng;

//     LatLng({
//         required this.lat,
//         required this.lng,
//     });

//     factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
//         lat: json["lat"]?.toDouble(),
//         lng: json["lng"]?.toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "lng": lng,
//     };
// }
