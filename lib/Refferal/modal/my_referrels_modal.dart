// To parse this JSON data, do
//
//     final myReferrelsModal = myReferrelsModalFromJson(jsonString);

import 'dart:convert';

List<MyReferrelsModal> myReferrelsModalFromJson(String str) => List<MyReferrelsModal>.from(json.decode(str).map((x) => MyReferrelsModal.fromJson(x)));


class MyReferrelsModal {
    int? id;
    int? userId;
    String? email;
    int? signup;
    int? mailCounter;
    DateTime? createdAt;
    DateTime? updatedAt;

    MyReferrelsModal({
        this.id,
        this.userId,
        this.email,
        this.signup,
        this.mailCounter,
        this.createdAt,
        this.updatedAt,
    });

    factory MyReferrelsModal.fromJson(Map<String, dynamic> json) => MyReferrelsModal(
        id: json["id"],
        userId: json["user_id"],
        email: json["email"],
        signup: json["signup"],
        mailCounter: json["mail_counter"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

   
}
