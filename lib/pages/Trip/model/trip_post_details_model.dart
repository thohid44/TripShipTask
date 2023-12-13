import 'dart:convert';

TripPostDetailsModel tripPostDetailsModelFromJson(String str) =>
    TripPostDetailsModel.fromJson(json.decode(str));

class TripPostDetailsModel {
  TripDetailsModel? tripDetailsModel;

  TripPostDetailsModel({
    this.tripDetailsModel,
  });

  factory TripPostDetailsModel.fromJson(Map<String, dynamic> json) =>
      TripPostDetailsModel(
        tripDetailsModel: TripDetailsModel.fromJson(json["data"]),
      );
}

class TripDetailsModel {
  String? title;
  var id;
  var tripId;
  var postType;
  var archived;
  var status;
  var slug;
  var path;
  var userId;
  var country;
  var currency;
  var tripPosterRating;
 var tripPosterFeedback;
  var tripOwnerPhoto;
  var vehicleType;
  var vehicleName;
  var startPoint;
  var distance;
  var duration;
  var via;
  var date;
  var time;
  var seatsAvailable;
  var destination;
  var vehicleSeat;
  var preferredPassenger;
  var bids;
  var bidsCount;

  var pay;
  dynamic? details;
  var user;
  dynamic? facebook;
  var totalTrip;
  DateTime? createdAt;
  var userCreated;

  TripDetailsModel({
    this.title,
    this.id,
    this.tripId,
    this.postType,
    this.archived,
    this.status,
    this.slug,
    this.path,
    this.userId,
    this.country,
    this.currency,
    this.tripPosterRating,
    this.tripPosterFeedback,
    this.tripOwnerPhoto,
    this.vehicleType,
    this.vehicleName,
    this.startPoint,
    this.distance,
    this.duration,
    this.via,
    this.date,
    this.time,
    this.seatsAvailable,
    this.destination,
    this.vehicleSeat,
    this.preferredPassenger,
    this.bids,
    this.bidsCount,

    this.pay,
    this.details,
    this.user,
    this.facebook,
    this.totalTrip,
    this.createdAt,
    this.userCreated,
  });

  factory TripDetailsModel.fromJson(Map<String, dynamic> json) => TripDetailsModel(
        title: json["title"],
        id: json["id"],
        tripId: json["trip_id"],
        postType: json["post_type"],
        archived: json["archived"],
        status: json["status"],
        slug: json["slug"],
        path: json["path"],
        userId: json["user_id"],
        country: json["country"],
        currency: json["currency"],
        tripPosterRating: json["trip_poster_rating"],
        tripPosterFeedback:
          json["trip_poster_feedback"],
        tripOwnerPhoto: json["trip_owner_photo"],
        vehicleType: json["vehicle_type"],
        vehicleName: json["vehicle_name"],
        startPoint: json["start_point"],
        distance: json["distance"],
        duration: json["duration"],
        via: json["via"],
        date: json["date"],
        time: json["time"],
        seatsAvailable: json["seats_available"],
        destination: json["destination"],
        vehicleSeat: json["vehicle_seat"],
        preferredPassenger: json["preferred_passenger"],
        bids: json["bids"],
        bidsCount: json["bids_count"],
 
        pay: json["pay"],
        details: json["details"],
        user: json["user"],
        facebook: json["facebook"],
        totalTrip: json["total_trip"],
        createdAt: DateTime.parse(json["created_at"]),
        userCreated: json["user_created"],
      );
}

class Bid {
  var id;
  var userId;
  var tripId;
  var title;
  var tripUsername;
  dynamic completedRating;
  var postedRating;
  var amount;
  var tripOwner;
  dynamic? vehicleType;
  var coverLetter;
  var bidderName;
  var bidderNumber;
  var bidderEmail;
  dynamic? bidderLocation;
  var bidderEducation;
  var bidderProfession;
  DateTime? bidderDob;
  var bidderSex;
  dynamic co;
  var passenger;
  var posted;
  var completed;
  var agree;
  var complete;
  var accepted;
  var paid;
  dynamic? paymentMethod;
  var feedbackGiven;
  var feedbackGot;
  String? photo;
  List<dynamic>? tripPostedFeedback;
  List<dynamic>? tripCompletedFeedback;
  var passengerAccepted;

  Bid({
    this.id,
    this.userId,
    this.tripId,
    this.title,
    this.tripUsername,
    this.completedRating,
    this.postedRating,
    this.amount,
    this.tripOwner,
    this.vehicleType,
    this.coverLetter,
    this.bidderName,
    this.bidderNumber,
    this.bidderEmail,
    this.bidderLocation,
    this.bidderEducation,
    this.bidderProfession,
    this.bidderDob,
    this.bidderSex,
    this.co,
    this.passenger,
    this.posted,
    this.completed,
    this.agree,
    this.complete,
    this.accepted,
    this.paid,
    this.paymentMethod,
    this.feedbackGiven,
    this.feedbackGot,
    this.photo,
    this.tripPostedFeedback,
    this.tripCompletedFeedback,
    this.passengerAccepted,
  });

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
        id: json["id"],
        userId: json["user_id"],
        tripId: json["trip_id"],
        title: json["title"],
        tripUsername: json["trip_username"],
        completedRating: json["completed_rating"],
        postedRating: json["posted_rating"],
        amount: json["amount"],
        tripOwner: json["trip_owner"],
        vehicleType: json["vehicle_type"],
        coverLetter: json["cover_letter"],
        bidderName: json["bidder_name"],
        bidderNumber: json["bidder_number"],
        bidderEmail: json["bidder_email"],
        bidderLocation: json["bidder_location"],
        bidderEducation: json["bidder_education"],
        bidderProfession: json["bidder_profession"],
        bidderDob: DateTime.parse(json["bidder_dob"]),
        bidderSex: json["bidder_sex"],
        co: json["co"],
        passenger: json["passenger"],
        posted: json["posted"],
        completed: json["completed"],
        agree: json["agree"],
        complete: json["complete"],
        accepted: json["accepted"],
        paid: json["paid"],
        paymentMethod: json["payment_method"],
        feedbackGiven: json["feedback_given"],
        feedbackGot: json["feedback_got"],
        photo: json["photo"],
        tripPostedFeedback:
            List<dynamic>.from(json["trip_posted_feedback"].map((x) => x)),
        tripCompletedFeedback:
            List<dynamic>.from(json["trip_completed_feedback"].map((x) => x)),
        passengerAccepted: json["passenger_accepted"],
      );
}


