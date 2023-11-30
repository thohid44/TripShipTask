// To parse this JSON data, do
//
//     final myTripsModel = myTripsModelFromJson(jsonString);

import 'dart:convert';

MyTripsModel myTripsModelFromJson(String str) => MyTripsModel.fromJson(json.decode(str));

String myTripsModelToJson(MyTripsModel data) => json.encode(data.toJson());

class MyTripsModel {
    Data? data;

    MyTripsModel({
        this.data,
    });

    factory MyTripsModel.fromJson(Map<String, dynamic> json) => MyTripsModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    List<EdTrip>? postedTrips;
    List<EdTrip>? seekedTrips;
    List<EdTrip>? completedTrips;

    Data({
        this.postedTrips,
        this.seekedTrips,
        this.completedTrips,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        postedTrips: List<EdTrip>.from(json["posted_trips"].map((x) => EdTrip.fromJson(x))),
        seekedTrips: List<EdTrip>.from(json["seeked_trips"].map((x) => EdTrip.fromJson(x))),
        completedTrips: List<EdTrip>.from(json["completed_trips"].map((x) => EdTrip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "posted_trips": List<dynamic>.from(postedTrips!.map((x) => x.toJson())),
        "seeked_trips": List<dynamic>.from(seekedTrips!.map((x) => x.toJson())),
        "completed_trips": List<dynamic>.from(completedTrips!.map((x) => x.toJson())),
    };
}

class EdTrip {
    int? id;
    String? tripId;
    String? postType;
    String? title;
    String? status;
    String? vehicleType;
    dynamic? vehicleName;
    String? startPoint;
    String? destination;
    String? distance;
    String? duration;
    dynamic? via;
    DateTime? date;
    String? time;
    dynamic tripRating;
    String? vehicleSeat;
    String? preferredPassenger;
    String? amount;
    Point? point;
    String? details;
    int? userId;
    String? user;
    String? path;

    EdTrip({
        this.id,
        this.tripId,
        this.postType,
        this.title,
        this.status,
        this.vehicleType,
        this.vehicleName,
        this.startPoint,
        this.destination,
        this.distance,
        this.duration,
        this.via,
        this.date,
        this.time,
        this.tripRating,
        this.vehicleSeat,
        this.preferredPassenger,
        this.amount,
        this.point,
        this.details,
        this.userId,
        this.user,
        this.path,
    });

    factory EdTrip.fromJson(Map<String, dynamic> json) => EdTrip(
        id: json["id"],
        tripId: json["trip_id"],
        postType: json["post_type"],
        title: json["title"],
        status: json["status"],
        vehicleType: json["vehicle_type"],
        vehicleName: json["vehicle_name"],
        startPoint: json["start_point"],
        destination: json["destination"],
        distance: json["distance"],
        duration: json["duration"],
        via: json["via"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        tripRating: json["trip_rating"],
        vehicleSeat: json["vehicle_seat"],
        preferredPassenger: json["preferred_passenger"],
        amount: json["amount"],
        point: Point.fromJson(json["point"]),
        details: json["details"],
        userId: json["user_id"],
        user: json["user"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "trip_id": tripId,
        "post_type": postType,
        "title": title,
        "status": status,
        "vehicle_type": vehicleType,
        "vehicle_name": vehicleName,
        "start_point": startPoint,
        "destination": destination,
        "distance": distance,
        "duration": duration,
        "via": via,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "trip_rating": tripRating,
        "vehicle_seat": vehicleSeat,
        "preferred_passenger": preferredPassenger,
        "amount": amount,
        "point": point!.toJson(),
        "details": details,
        "user_id": userId,
        "user": user,
        "path": path,
    };
}

class Point {
    String? sLat;
    String? sLng;
    String? dLat;
    String? dLng;

    Point({
        this.sLat,
        this.sLng,
        this.dLat,
        this.dLng,
    });

    factory Point.fromJson(Map<String, dynamic> json) => Point(
        sLat: json["s_lat"],
        sLng: json["s_lng"],
        dLat: json["d_lat"],
        dLng: json["d_lng"],
    );

    Map<String, dynamic> toJson() => {
        "s_lat": sLat,
        "s_lng": sLng,
        "d_lat": dLat,
        "d_lng": dLng,
    };
}
