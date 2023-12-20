// // To parse this JSON data, do
// //
// //     final tripGivePostDetailsModel = tripGivePostDetailsModelFromJson(jsonString);

// import 'dart:convert';

// TripGivePostDetailsModel tripGivePostDetailsModelFromJson(String str) => TripGivePostDetailsModel.fromJson(json.decode(str));

// String tripGivePostDetailsModelToJson(TripGivePostDetailsModel data) => json.encode(data.toJson());

// class TripGivePostDetailsModel {
//     Data data;

//     TripGivePostDetailsModel({
//         required this.data,
//     });

//     factory TripGivePostDetailsModel.fromJson(Map<String, dynamic> json) => TripGivePostDetailsModel(
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//     };
// }

// class Data {
//     String title;
//     int id;
//     String tripId;
//     String postType;
//     int archived;
//     String status;
//     String slug;
//     String path;
//     int userId;
//     String country;
//     String currency;
//     String tripOwnerPhoto;
//     String vehicleType;
//     dynamic vehicleName;
//     String startPoint;
//     String distance;
//     String duration;
//     dynamic via;
//     DateTime date;
//     String time;
//     String destination;
//     String vehicleSeat;
//     String preferredPassenger;
//     int bidsCount;
//     Point point;
//     Userinfo userinfo;
//     String pay;
//     dynamic details;
//     String user;
//     dynamic facebook;
//     int totalTrip;
//     DateTime createdAt;
//     String userCreated;
//     List<Bid> bids;
//     String tripPosterRating;
//     List<dynamic> tripPosterFeedback;
//     int seatsAvailable;

//     Data({
//         required this.title,
//         required this.id,
//         required this.tripId,
//         required this.postType,
//         required this.archived,
//         required this.status,
//         required this.slug,
//         required this.path,
//         required this.userId,
//         required this.country,
//         required this.currency,
//         required this.tripOwnerPhoto,
//         required this.vehicleType,
//         required this.vehicleName,
//         required this.startPoint,
//         required this.distance,
//         required this.duration,
//         required this.via,
//         required this.date,
//         required this.time,
//         required this.destination,
//         required this.vehicleSeat,
//         required this.preferredPassenger,
//         required this.bidsCount,
//         required this.point,
//         required this.userinfo,
//         required this.pay,
//         required this.details,
//         required this.user,
//         required this.facebook,
//         required this.totalTrip,
//         required this.createdAt,
//         required this.userCreated,
//         required this.bids,
//         required this.tripPosterRating,
//         required this.tripPosterFeedback,
//         required this.seatsAvailable,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         title: json["title"],
//         id: json["id"],
//         tripId: json["trip_id"],
//         postType: json["post_type"],
//         archived: json["archived"],
//         status: json["status"],
//         slug: json["slug"],
//         path: json["path"],
//         userId: json["user_id"],
//         country: json["country"],
//         currency: json["currency"],
//         tripOwnerPhoto: json["trip_owner_photo"],
//         vehicleType: json["vehicle_type"],
//         vehicleName: json["vehicle_name"],
//         startPoint: json["start_point"],
//         distance: json["distance"],
//         duration: json["duration"],
//         via: json["via"],
//         date: DateTime.parse(json["date"]),
//         time: json["time"],
//         destination: json["destination"],
//         vehicleSeat: json["vehicle_seat"],
//         preferredPassenger: json["preferred_passenger"],
//         bidsCount: json["bids_count"],
//         point: Point.fromJson(json["point"]),
//         userinfo: Userinfo.fromJson(json["userinfo"]),
//         pay: json["pay"],
//         details: json["details"],
//         user: json["user"],
//         facebook: json["facebook"],
//         totalTrip: json["total_trip"],
//         createdAt: DateTime.parse(json["created_at"]),
//         userCreated: json["user_created"],
//         bids: List<Bid>.from(json["bids"].map((x) => Bid.fromJson(x))),
//         tripPosterRating: json["trip_poster_rating"],
//         tripPosterFeedback: List<dynamic>.from(json["trip_poster_feedback"].map((x) => x)),
//         seatsAvailable: json["seats_available"],
//     );

//     Map<String, dynamic> toJson() => {
//         "title": title,
//         "id": id,
//         "trip_id": tripId,
//         "post_type": postType,
//         "archived": archived,
//         "status": status,
//         "slug": slug,
//         "path": path,
//         "user_id": userId,
//         "country": country,
//         "currency": currency,
//         "trip_owner_photo": tripOwnerPhoto,
//         "vehicle_type": vehicleType,
//         "vehicle_name": vehicleName,
//         "start_point": startPoint,
//         "distance": distance,
//         "duration": duration,
//         "via": via,
//         "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "time": time,
//         "destination": destination,
//         "vehicle_seat": vehicleSeat,
//         "preferred_passenger": preferredPassenger,
//         "bids_count": bidsCount,
//         "point": point.toJson(),
//         "userinfo": userinfo.toJson(),
//         "pay": pay,
//         "details": details,
//         "user": user,
//         "facebook": facebook,
//         "total_trip": totalTrip,
//         "created_at": createdAt.toIso8601String(),
//         "user_created": userCreated,
//         "bids": List<dynamic>.from(bids.map((x) => x.toJson())),
//         "trip_poster_rating": tripPosterRating,
//         "trip_poster_feedback": List<dynamic>.from(tripPosterFeedback.map((x) => x)),
//         "seats_available": seatsAvailable,
//     };
// }

// class Bid {
//     int id;
//     int userId;
//     int tripId;
//     String title;
//     String tripUsername;
//     dynamic completedRating;
//     String postedRating;
//     dynamic amount;
//     int tripOwner;
//     dynamic vehicleType;
//     dynamic coverLetter;
//     String bidderName;
//     String bidderNumber;
//     String bidderEmail;
//     dynamic bidderLocation;
//     String bidderEducation;
//     dynamic bidderProfession;
//     dynamic bidderDob;
//     String bidderSex;
//     dynamic co;
//     int passenger;
//     int posted;
//     int completed;
//     int agree;
//     int complete;
//     int accepted;
//     int paid;
//     dynamic paymentMethod;
//     int feedbackGiven;
//     int feedbackGot;
//     String photo;
//     List<TripPostedFeedback> tripPostedFeedback;
//     List<dynamic> tripCompletedFeedback;
//     int passengerAccepted;

//     Bid({
//         required this.id,
//         required this.userId,
//         required this.tripId,
//         required this.title,
//         required this.tripUsername,
//         required this.completedRating,
//         required this.postedRating,
//         required this.amount,
//         required this.tripOwner,
//         required this.vehicleType,
//         required this.coverLetter,
//         required this.bidderName,
//         required this.bidderNumber,
//         required this.bidderEmail,
//         required this.bidderLocation,
//         required this.bidderEducation,
//         required this.bidderProfession,
//         required this.bidderDob,
//         required this.bidderSex,
//         required this.co,
//         required this.passenger,
//         required this.posted,
//         required this.completed,
//         required this.agree,
//         required this.complete,
//         required this.accepted,
//         required this.paid,
//         required this.paymentMethod,
//         required this.feedbackGiven,
//         required this.feedbackGot,
//         required this.photo,
//         required this.tripPostedFeedback,
//         required this.tripCompletedFeedback,
//         required this.passengerAccepted,
//     });

//     factory Bid.fromJson(Map<String, dynamic> json) => Bid(
//         id: json["id"],
//         userId: json["user_id"],
//         tripId: json["trip_id"],
//         title: json["title"],
//         tripUsername: json["trip_username"],
//         completedRating: json["completed_rating"],
//         postedRating: json["posted_rating"],
//         amount: json["amount"],
//         tripOwner: json["trip_owner"],
//         vehicleType: json["vehicle_type"],
//         coverLetter: json["cover_letter"],
//         bidderName: json["bidder_name"],
//         bidderNumber: json["bidder_number"],
//         bidderEmail: json["bidder_email"],
//         bidderLocation: json["bidder_location"],
//         bidderEducation: json["bidder_education"],
//         bidderProfession: json["bidder_profession"],
//         bidderDob: json["bidder_dob"],
//         bidderSex: json["bidder_sex"],
//         co: json["co"],
//         passenger: json["passenger"],
//         posted: json["posted"],
//         completed: json["completed"],
//         agree: json["agree"],
//         complete: json["complete"],
//         accepted: json["accepted"],
//         paid: json["paid"],
//         paymentMethod: json["payment_method"],
//         feedbackGiven: json["feedback_given"],
//         feedbackGot: json["feedback_got"],
//         photo: json["photo"],
//         tripPostedFeedback: List<TripPostedFeedback>.from(json["trip_posted_feedback"].map((x) => TripPostedFeedback.fromJson(x))),
//         tripCompletedFeedback: List<dynamic>.from(json["trip_completed_feedback"].map((x) => x)),
//         passengerAccepted: json["passenger_accepted"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "trip_id": tripId,
//         "title": title,
//         "trip_username": tripUsername,
//         "completed_rating": completedRating,
//         "posted_rating": postedRating,
//         "amount": amount,
//         "trip_owner": tripOwner,
//         "vehicle_type": vehicleType,
//         "cover_letter": coverLetter,
//         "bidder_name": bidderName,
//         "bidder_number": bidderNumber,
//         "bidder_email": bidderEmail,
//         "bidder_location": bidderLocation,
//         "bidder_education": bidderEducation,
//         "bidder_profession": bidderProfession,
//         "bidder_dob": bidderDob,
//         "bidder_sex": bidderSex,
//         "co": co,
//         "passenger": passenger,
//         "posted": posted,
//         "completed": completed,
//         "agree": agree,
//         "complete": complete,
//         "accepted": accepted,
//         "paid": paid,
//         "payment_method": paymentMethod,
//         "feedback_given": feedbackGiven,
//         "feedback_got": feedbackGot,
//         "photo": photo,
//         "trip_posted_feedback": List<dynamic>.from(tripPostedFeedback.map((x) => x.toJson())),
//         "trip_completed_feedback": List<dynamic>.from(tripCompletedFeedback.map((x) => x)),
//         "passenger_accepted": passengerAccepted,
//     };
// }

// class TripPostedFeedback {
//     String title;
//     int ownerId;
//     String reviewedby;
//     double rating;
//     String review;

//     TripPostedFeedback({
//         required this.title,
//         required this.ownerId,
//         required this.reviewedby,
//         required this.rating,
//         required this.review,
//     });

//     factory TripPostedFeedback.fromJson(Map<String, dynamic> json) => TripPostedFeedback(
//         title: json["title"],
//         ownerId: json["ownerId"],
//         reviewedby: json["reviewedby"],
//         rating: json["rating"]?.toDouble(),
//         review: json["review"],
//     );

//     Map<String, dynamic> toJson() => {
//         "title": title,
//         "ownerId": ownerId,
//         "reviewedby": reviewedby,
//         "rating": rating,
//         "review": review,
//     };
// }

// class Point {
//     String sLat;
//     String sLng;
//     String dLat;
//     String dLng;

//     Point({
//         required this.sLat,
//         required this.sLng,
//         required this.dLat,
//         required this.dLng,
//     });

//     factory Point.fromJson(Map<String, dynamic> json) => Point(
//         sLat: json["s_lat"],
//         sLng: json["s_lng"],
//         dLat: json["d_lat"],
//         dLng: json["d_lng"],
//     );

//     Map<String, dynamic> toJson() => {
//         "s_lat": sLat,
//         "s_lng": sLng,
//         "d_lat": dLat,
//         "d_lng": dLng,
//     };
// }

// class Userinfo {
//     String name;
//     String created;
//     String education;
//     String profession;
//     DateTime dob;
//     String gender;

//     Userinfo({
//         required this.name,
//         required this.created,
//         required this.education,
//         required this.profession,
//         required this.dob,
//         required this.gender,
//     });

//     factory Userinfo.fromJson(Map<String, dynamic> json) => Userinfo(
//         name: json["name"],
//         created: json["created"],
//         education: json["education"],
//         profession: json["profession"],
//         dob: DateTime.parse(json["dob"]),
//         gender: json["gender"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "created": created,
//         "education": education,
//         "profession": profession,
//         "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
//         "gender": gender,
//     };
// }
