// To parse this JSON data, do
//
//     final myTaskModel = myTaskModelFromJson(jsonString);

import 'dart:convert';

MyTaskModel myTaskModelFromJson(String str) => MyTaskModel.fromJson(json.decode(str));



class MyTaskModel {
    MyTaskModel2? myTaskModel2;

    MyTaskModel({
         this.myTaskModel2,
    });

    factory MyTaskModel.fromJson(Map<String, dynamic> json) => MyTaskModel(
        myTaskModel2: MyTaskModel2.fromJson(json["data"]),
    );

 
}

class MyTaskModel2 {
    List<OfferTask> offerTasks;
    List<dynamic> seekedTasks;
    List<dynamic> completedTasks;

    MyTaskModel2({
        required this.offerTasks,
        required this.seekedTasks,
        required this.completedTasks,
    });

    factory MyTaskModel2.fromJson(Map<String, dynamic> json) => MyTaskModel2(
        offerTasks: List<OfferTask>.from(json["offer_tasks"].map((x) => OfferTask.fromJson(x))),
        seekedTasks: List<dynamic>.from(json["seeked_tasks"].map((x) => x)),
        completedTasks: List<dynamic>.from(json["completed_tasks"].map((x) => x)),
    );

   
}

class OfferTask {
    List<String>? skills;
    String? category;
    int? id;
    int? userId;
    String? title;
    String? taskId;
    String? slug;
    String? postType;
    String? path;
    dynamic? taskRating;
    LatLng? latLng;
    String? location;
    String? description;
    String? status;
    int? personNeed;
    var date;
    String? time;
    int? hour;
    int? amount;
    String? user;
    var createdAt;

    OfferTask({
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
         this.latLng,
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

    factory OfferTask.fromJson(Map<String, dynamic> json) => OfferTask(
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
        latLng: LatLng.fromJson(json["lat_lng"]),
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

class LatLng {
    String lat;
    String lng;

    LatLng({
        required this.lat,
        required this.lng,
    });

    factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
        lat: json["lat"],
        lng: json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}
