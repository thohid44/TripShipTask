// To parse this JSON data, do
//
//     final myTaskDetailsModel = myTaskDetailsModelFromJson(jsonString);

import 'dart:convert';

MyTaskDetailsModel myTaskDetailsModelFromJson(String str) => MyTaskDetailsModel.fromJson(json.decode(str));



class MyTaskDetailsModel {
    MyTaskDetailsModel2? myTaskDetailsModel;

    MyTaskDetailsModel({
         this.myTaskDetailsModel,
    });

    factory MyTaskDetailsModel.fromJson(Map<String, dynamic> json) => MyTaskDetailsModel(
        myTaskDetailsModel: MyTaskDetailsModel2.fromJson(json["data"]),
    );

}

class MyTaskDetailsModel2 {
    String? postType;
    var skills;
    String? category;
    int? id;
    var userId;
    var title;
    String? taskId;
    String? slug;
    String? type;
    String? path;
    String? preferredGender;
    String? country;
    String? currency;
    dynamic facebook;
    var latLng;
    String? location;
    String? note;
    String? status;
    int? module;
    int? hourAvailable;
    int? hourNeed;
    dynamic balance;
    dynamic taskPosterRating;
    var taskPosterFeedback;
    var bids;
    int? bidsCount;
    String? ownerPhoto;
    int? archive;
    Userinfo? userinfo;
    var date;
    String? time;
    int? amount;
    String? user;
    dynamic userLocation;
    int? totalTask;
    var createdAt;
    String? userCreated;

    MyTaskDetailsModel2({
         this.postType,
         this.skills,
         this.category,
         this.id,
         this.userId,
         this.title,
         this.taskId,
         this.slug,
         this.type,
         this.path,
         this.preferredGender,
         this.country,
         this.currency,
         this.facebook,
        this.latLng,
         this.location,
         this.note,
         this.status,
         this.module,
         this.hourAvailable,
         this.hourNeed,
         this.balance,
         this.taskPosterRating,
         this.taskPosterFeedback,
         this.bids,
         this.bidsCount,
         this.ownerPhoto,
         this.archive,
         this.userinfo,
         this.date,
         this.time,
         this.amount,
         this.user,
         this.userLocation,
         this.totalTask,
         this.createdAt,
         this.userCreated,
    });

    factory MyTaskDetailsModel2.fromJson(Map<String, dynamic> json) => MyTaskDetailsModel2(
        postType: json["post_type"],
        skills: json["skills"], 
        category: json["category"],
        id: json["id"],
        userId: json["user_id"],
        title: json["title"].toString(),
        taskId: json["task_id"],
        slug: json["slug"],
        type: json["type"],
        path: json["path"],
        preferredGender: json["preferred_gender"],
        country: json["country"],
        currency: json["currency"],
        facebook: json["facebook"],
       latLng: json["lat_lng"],
        location: json["location"],
        note: json["note"],
        status: json["status"],
        module: json["module"],
        hourAvailable: json["hour_available"],
        hourNeed: json["hour_need"],
        balance: json["balance"],
        taskPosterRating: json["task_poster_rating"],
        taskPosterFeedback: json["task_poster_feedback"],
        bids: json["bids"],
        bidsCount: json["bids_count"],
        ownerPhoto: json["owner_photo"],
        archive: json["archive"],
        userinfo: Userinfo.fromJson(json["userinfo"]),
        date: DateTime.parse(json["date"]),
        time: json["time"],
        amount: json["amount"],
        user: json["user"],
        userLocation: json["user_location"],
        totalTask: json["total_task"],
        createdAt: DateTime.parse(json["created_at"]),
        userCreated: json["user_created"],
    );

}



class Userinfo {
    String? name;
    String? created;
    String? education;
    String? profession;
    var dob;
    String? gender;

    Userinfo({
         this.name,
         this.created,
         this.education,
         this.profession,
         this.dob,
         this.gender,
    });

    factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
        name: json["name"],
        created: json["created"],
        education: json["education"],
        profession: json["profession"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "created": created,
        "education": education,
        "profession": profession,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "gender": gender,
    };
}
class LatLng {
    dynamic lat;
    dynamic lng;

    LatLng({
        this.lat,
        this.lng,
    });

    // factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
    //     lat: json["lat"].toDouble(),
    //     lng: json["lng"].toDouble(),
    // );

   
}