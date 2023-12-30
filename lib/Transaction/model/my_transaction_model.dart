

import 'dart:convert';

List<MyTransactionModel> myTaskModelFromJson(String str) => 
List<MyTransactionModel>.from(json.decode(str).map((x) => MyTransactionModel.fromJson(x)));


class MyTransactionModel {
    Transaction? transaction;
    BidData? bidData;
    PostData? postData;

    MyTransactionModel({
         this.transaction,
         this.bidData,
         this.postData,
    });

    factory MyTransactionModel.fromJson(Map<String, dynamic> json) => MyTransactionModel(
        transaction: Transaction.fromJson(json["transaction"]),
        bidData: BidData.fromJson(json["bidData"]),
        postData: PostData.fromJson(json["postData"]),
    );

  
}

class BidData {
    int? id;
    int? amount;
    String? coverLetter;
    String? counterOffer;
    int? agree;
    int? accepted;
    int?  taskerConfirmed;
    int?  taskerAccepted;
    int?  bidderAccepted;
    int? paid;
    int? complete;
    String? paymentMethod;
    int? feedbackGot;
    int? feedbackGiven;
    int? taskId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic vehicleType;
    dynamic vehicleName;
    int? passenger;
    int? passengerAccepted;
    int? riderAccepted;
    int? tripId;

    BidData({
         this.id,
         this.amount,
         this.coverLetter,
         this.counterOffer,
         this.agree,
         this.accepted,
        this.taskerConfirmed,
        this.taskerAccepted,
        this.bidderAccepted,
         this.paid,
         this.complete,
         this.paymentMethod,
         this.feedbackGot,
         this.feedbackGiven,
        this.taskId,
         this.userId,
         this.createdAt,
         this.updatedAt,
        this.vehicleType,
        this.vehicleName,
        this.passenger,
        this.passengerAccepted,
        this.riderAccepted,
        this.tripId,
    });

    factory BidData.fromJson(Map<String, dynamic> json) => BidData(
        id: json["id"],
        amount: json["amount"],
        coverLetter: json["cover_letter"],
        counterOffer: json["counter_offer"],
        agree: json["agree"],
        accepted: json["accepted"],
        taskerConfirmed: json["tasker_confirmed"],
        taskerAccepted: json["tasker_accepted"],
        bidderAccepted: json["bidder_accepted"],
        paid: json["paid"],
        complete: json["complete"],
        paymentMethod: json["payment_method"],
        feedbackGot: json["feedback_got"],
        feedbackGiven: json["feedback_given"],
        taskId: json["task_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        vehicleType: json["vehicle_type"],
        vehicleName: json["vehicle_name"],
        passenger: json["passenger"],
        passengerAccepted: json["passenger_accepted"],
        riderAccepted: json["rider_accepted"],
        tripId: json["trip_id"],
    );

   
}

class PostData {
    int? id;
    String? taskId;
    String? title;
    String? slug;
    String? status;
    String? country;
    String? currency;
    String? postType;
    String? location;
    double? lat;
    double? lng;
    DateTime? date;
    String? time;
    int? hourAvailable;
    int? hourNeed;
    int? personNeed;
    String? preferredGender;
    int? archive;
    String? description;
    int? amount;
    int? moduleId;
    String? category;
    var skillIds;
    int? skillId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? tripId;
    String? vehicleType;
    String? vehicleName;
    String? startPoint;
    dynamic via;
    String? destination;
    String? distance;
    String? duration;
    String? sLat;
    String? sLng;
    String? dLat;
    String? dLng;
    int? completed;
    String? passenger;
    String? preferredPassenger;
    String? pay;
    String? details;
    int? archived;
    dynamic deletedAt;

    PostData({
         this.id,
        this.taskId,
        this.title,
         this.slug,
         this.status,
         this.country,
         this.currency,
         this.postType,
        this.location,
        this.lat,
        this.lng,
         this.date,
         this.time,
        this.hourAvailable,
        this.hourNeed,
        this.personNeed,
        this.preferredGender,
        this.archive,
        this.description,
        this.amount,
        this.moduleId,
        this.category,
        this.skillIds,
        this.skillId,
         this.userId,
         this.createdAt,
         this.updatedAt,
        this.tripId,
        this.vehicleType,
        this.vehicleName,
        this.startPoint,
        this.via,
        this.destination,
        this.distance,
        this.duration,
        this.sLat,
        this.sLng,
        this.dLat,
        this.dLng,
        this.completed,
        this.passenger,
        this.preferredPassenger,
        this.pay,
        this.details,
        this.archived,
        this.deletedAt,
    });

    factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"],
        taskId: json["task_id"],
        title: json["title"],
        slug: json["slug"],
        status: json["status"],
        country: json["country"],
        currency: json["currency"],
        postType: json["post_type"],
        location: json["location"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        date: DateTime.parse(json["date"]),
        time: json["time"],
        hourAvailable: json["hour_available"],
        hourNeed: json["hour_need"],
        personNeed: json["person_need"],
        preferredGender: json["preferred_gender"],
        archive: json["archive"],
        description: json["description"],
        amount: json["amount"],
        moduleId: json["module_id"],
        category: json["category"],
        skillIds: json["skill_ids"],
        skillId: json["skill_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tripId: json["trip_id"],
        vehicleType: json["vehicle_type"],
        vehicleName: json["vehicle_name"],
        startPoint: json["start_point"],
        via: json["via"],
        destination: json["destination"],
        distance: json["distance"],
        duration: json["duration"],
        sLat: json["s_lat"],
        sLng: json["s_lng"],
        dLat: json["d_lat"],
        dLng: json["d_lng"],
        completed: json["completed"],
        passenger: json["passenger"],
        preferredPassenger: json["preferred_passenger"],
        pay: json["pay"],
        details: json["details"],
        archived: json["archived"],
        deletedAt: json["deleted_at"],
    );

 
}

class Transaction {
    int? id;
    String? type;
    String? module;
    int? bidId;
    int? amount;
    int? receivedFrom;
    DateTime? date;
    String? status;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic pgtxnid;
    dynamic mernid;
    dynamic phone;
    dynamic cardnumber;
    dynamic banktrxid;
    dynamic amountCurrency;
    dynamic currency;
    dynamic processingCharge;

    Transaction({
         this.id,
         this.type,
         this.module,
         this.bidId,
         this.amount,
         this.receivedFrom,
         this.date,
         this.status,
         this.userId,
         this.createdAt,
         this.updatedAt,
         this.pgtxnid,
         this.mernid,
         this.phone,
         this.cardnumber,
         this.banktrxid,
         this.amountCurrency,
         this.currency,
         this.processingCharge,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        type: json["type"],
        module: json["module"],
        bidId: json["bid_id"],
        amount: json["amount"],
        receivedFrom: json["received_from"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pgtxnid: json["pgtxnid"],
        mernid: json["mernid"],
        phone: json["phone"],
        cardnumber: json["cardnumber"],
        banktrxid: json["banktrxid"],
        amountCurrency: json["amount_currency"],
        currency: json["currency"],
        processingCharge: json["processing_charge"],
    );

    
}
