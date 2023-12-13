// To parse this JSON data, do
//
//     final shipSendPackageDetailsModel = shipSendPackageDetailsModelFromJson(jsonString);

import 'dart:convert';

ShipSendPackageDetailsModel shipSendPackageDetailsModelFromJson(String str) =>
    ShipSendPackageDetailsModel.fromJson(json.decode(str));

class ShipSendPackageDetailsModel {
  ShipSendPackageDetailsM? data;

  ShipSendPackageDetailsModel({
    this.data,
  });

  factory ShipSendPackageDetailsModel.fromJson(Map<String, dynamic> json) =>
      ShipSendPackageDetailsModel(
        data: ShipSendPackageDetailsM.fromJson(json["data"]),
      );
}

class ShipSendPackageDetailsM {
  int? id;
  String? shipId;
  int? shipPosterRating;
  List<dynamic>? shipPosterFeedback;
  String? title;
  String? status;
  String? postType;
  int? bidsCount;
  int? carryBidsCount;
  String? startPoint;
  String? destination;
  var pickupDate;
  var pickupTime;
  var deliveryDate;
  String? deliveryTime;
  String? path;
  String? slug;
  String? country;
  String? currency;
  String? documents;
  int? documentPrice;
  int? amount;
  dynamic ownVehicle;
  dynamic length;
  dynamic width;
  dynamic height;
  String? weight;
  String? distance;
  String? duration;
  Point? point;
  Userinfo? userinfo;
  String? packageType;
  String? goodType;
  String? details;
  int? userId;
  String? posted;
  var bids;
  String? user;
  String? userCreated;
  String? shipOwnerPhoto;
  int? totalShip;

  ShipSendPackageDetailsM({
    this.id,
    this.shipId,
    this.shipPosterRating,
    this.shipPosterFeedback,
    this.title,
    this.status,
    this.postType,
    this.bidsCount,
    this.carryBidsCount,
    this.startPoint,
    this.destination,
    this.pickupDate,
    this.pickupTime,
    this.deliveryDate,
    this.deliveryTime,
    this.path,
    this.slug,
    this.country,
    this.currency,
    this.documents,
    this.documentPrice,
    this.amount,
    this.ownVehicle,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.distance,
    this.duration,
    this.point,
    this.userinfo,
    this.packageType,
    this.goodType,
    this.details,
    this.userId,
    this.posted,
    this.bids,
    this.user,
    this.userCreated,
    this.shipOwnerPhoto,
    this.totalShip,
  });

  factory ShipSendPackageDetailsM.fromJson(Map<String?, dynamic> json) =>
      ShipSendPackageDetailsM(
        id: json["id"],
        shipId: json["ship_id"],
        shipPosterRating: json["ship_poster_rating"],
        shipPosterFeedback:
            List<dynamic>.from(json["ship_poster_feedback"].map((x) => x)),
        title: json["title"],
        status: json["status"],
        postType: json["post_type"],
        bidsCount: json["bids_count"],
        carryBidsCount: json["carry_bids_count"],
        startPoint: json["start_point"],
        destination: json["destination"],
        pickupDate: json["pickup_date"],
        pickupTime: json["pickup_time"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        path: json["path"],
        slug: json["slug"],
        country: json["country"],
        currency: json["currency"],
        documents: json["documents"],
        documentPrice: json["document_price"],
        amount: json["amount"],
        ownVehicle: json["own_vehicle"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        weight: json["weight"],
        distance: json["distance"],
        duration: json["duration"],
        point: Point.fromJson(json["point"]),
        userinfo: Userinfo.fromJson(json["userinfo"]),
        packageType: json["package_type"],
        goodType: json["good_type"],
        details: json["details"],
        userId: json["user_id"],
        posted: json["posted"],
        bids: json["bids"],
        user: json["user"],
        userCreated: json["user_created"],
        shipOwnerPhoto: json["ship_owner_photo"],
        totalShip: json["total_ship"],
      );
}

class Bid {
  dynamic completedRating;
  dynamic postedRating;
  List<dynamic>? shipPostedFeedbacks;
  List<dynamic>? shipCompletedFeedbacks;
  int? id;
  int? shipId;
  int? shipOwner;
  String? shipPosterName;
  dynamic shiptitle;
  DateTime? shipdate;
  String? shippath;
  int? paid;
  int? amount;
  dynamic paymentMethod;
  dynamic carrierAccepted;
  dynamic co;
  int? complete;
  String? bidderEducation;
  String? bidderProfession;
  String? education;
  DateTime? bidderDob;
  String? bidderSex;
  String? email;
  String? phone;
  String? address;
  String? coverLetter;
  int? completed;
  int? userId;
  int? agree;
  int? posted;
  int? accepted;
  int? feedbackGiven;
  int? feedbackGot;
  String? bidderName;
  String? bidderLocation;
  String? photo;
  dynamic rating;

  Bid({
    this.completedRating,
    this.postedRating,
    this.shipPostedFeedbacks,
    this.shipCompletedFeedbacks,
    this.id,
    this.shipId,
    this.shipOwner,
    this.shipPosterName,
    this.shiptitle,
    this.shipdate,
    this.shippath,
    this.paid,
    this.amount,
    this.paymentMethod,
    this.carrierAccepted,
    this.co,
    this.complete,
    this.bidderEducation,
    this.bidderProfession,
    this.education,
    this.bidderDob,
    this.bidderSex,
    this.email,
    this.phone,
    this.address,
    this.coverLetter,
    this.completed,
    this.userId,
    this.agree,
    this.posted,
    this.accepted,
    this.feedbackGiven,
    this.feedbackGot,
    this.bidderName,
    this.bidderLocation,
    this.photo,
    this.rating,
  });

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
        completedRating: json["completed_rating"],
        postedRating: json["posted_rating"],
        shipPostedFeedbacks:
            List<dynamic>.from(json["ship_posted_feedbacks"].map((x) => x)),
        shipCompletedFeedbacks:
            List<dynamic>.from(json["ship_completed_feedbacks"].map((x) => x)),
        id: json["id"],
        shipId: json["ship_id"],
        shipOwner: json["ship_owner"],
        shipPosterName: json["ship_poster_name"],
        shiptitle: json["shiptitle"],
        shipdate: DateTime.parse(json["shipdate"]),
        shippath: json["shippath"],
        paid: json["paid"],
        amount: json["amount"],
        paymentMethod: json["payment_method"],
        carrierAccepted: json["carrier_accepted"],
        co: json["co"],
        complete: json["complete"],
        bidderEducation: json["bidder_education"],
        bidderProfession: json["bidder_profession"],
        education: json["education"],
        bidderDob: DateTime.parse(json["bidder_dob"]),
        bidderSex: json["bidder_sex"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        coverLetter: json["cover_letter"],
        completed: json["completed"],
        userId: json["user_id"],
        agree: json["agree"],
        posted: json["posted"],
        accepted: json["accepted"],
        feedbackGiven: json["feedback_given"],
        feedbackGot: json["feedback_got"],
        bidderName: json["bidder_name"],
        bidderLocation: json["bidder_location"],
        photo: json["photo"],
        rating: json["rating"],
      );
}

class Point {
  String? pLat;
  String? pLng;
  String? dLat;
  String? dLng;

  Point({
    this.pLat,
    this.pLng,
    this.dLat,
    this.dLng,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        pLat: json["p_lat"],
        pLng: json["p_lng"],
        dLat: json["d_lat"],
        dLng: json["d_lng"],
      );
}

class Userinfo {
  String? name;
  String? created;
  String? education;
  String? profession;
  DateTime? dob;
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
}
