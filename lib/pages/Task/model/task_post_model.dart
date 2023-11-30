
import 'dart:convert';

TaskPostModel taskPostModelFromJson(String str) => TaskPostModel.fromJson(json.decode(str));

String taskPostModelToJson(TaskPostModel data) => json.encode(data.toJson());

class TaskPostModel {
    List<String> selectedskill;
    String? title;
    String? category;
    String? location;
    String? preferredGender;
    var date;
    String? time;
    String? details;
    String? amount;
    double? lat;
    double? lng;
    String? hourAvailable;
    int? hourNeed;
    String? postType;
    String? country;
    String? currency;
    int? moduleId;

    TaskPostModel({
       required  this.selectedskill,
         this.title,
         this.category,
         this.location,
         this.preferredGender,
         this.date,
         this.time,
         this.details,
         this.amount,
         this.lat,
         this.lng,
         this.hourAvailable,
         this.hourNeed,
         this.postType,
         this.country,
         this.currency,
         this.moduleId,
    });

    factory TaskPostModel.fromJson(Map<String, dynamic> json) => TaskPostModel(
        selectedskill: List<String>.from(json["selectedskill"].map((x) => x)),
        title: json["title"],
        category: json["category"],
        location: json["location"],
        preferredGender: json["preferred_gender"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        details: json["details"],
        amount: json["amount"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        hourAvailable: json["hour_available"],
        hourNeed: json["hour_need"],
        postType: json["post_type"],
        country: json["country"],
        currency: json["currency"],
        moduleId: json["moduleId"],
    );

    Map<String, dynamic> toJson() => {
        "selectedskill": List<dynamic>.from(selectedskill!.map((x) => x)),
        "title": title,
        "category": category,
        "location": location,
        "preferred_gender": preferredGender,
        "date": date,
        "time": time,
        "details": details,
        "amount": amount,
        "lat": lat,
        "lng": lng,
        "hour_available": hourAvailable,
        "hour_need": hourNeed,
        "post_type": postType,
        "country": country,
        "currency": currency,
        "moduleId": moduleId,
    };
}
