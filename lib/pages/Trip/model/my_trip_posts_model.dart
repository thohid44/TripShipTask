

import 'dart:convert';

MyTripPostsModel myTripPostsModelFromJson(String str) => MyTripPostsModel.fromJson(json.decode(str));



class MyTripPostsModel {
    MyTrips? data;

    MyTripPostsModel({
        this.data,
    });

    factory MyTripPostsModel.fromJson(Map<String, dynamic> json) => MyTripPostsModel(
        data: MyTrips.fromJson(json["data"]),
    );

   
}

class MyTrips {
    List<EdTrip>? postedTrips;
    List<EdTrip>? seekedTrips;
    List<EdTrip>? completedTrips;

    MyTrips({
        this.postedTrips,
        this.seekedTrips,
        this.completedTrips,
    });

    factory MyTrips.fromJson(Map<String, dynamic> json) => MyTrips(
        postedTrips: List<EdTrip>.from(json["posted_trips"].map((x) => EdTrip.fromJson(x))),
        seekedTrips: List<EdTrip>.from(json["seeked_trips"].map((x) => EdTrip.fromJson(x))),
        completedTrips: List<EdTrip>.from(json["completed_trips"].map((x) => EdTrip.fromJson(x))),
    );

   
}

class EdTrip {
    var id;
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
    var userId;
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
