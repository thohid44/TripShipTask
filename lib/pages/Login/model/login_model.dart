// // To parse this JSON data, do
// //
// //     final loginModel = loginModelFromJson(jsonString);

// import 'dart:convert';

// LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

// String loginModelToJson(LoginModel data) => json.encode(data.toJson());

// class LoginModel {
//     String accessToken;
//     String tokenType;
//     int expiresIn;
//     User user;

//     LoginModel({
//         this.accessToken,
//         this.tokenType,
//         this.expiresIn,
//         this.user,
//     });

//     factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//         accessToken: json["access_token"],
//         tokenType: json["token_type"],
//         expiresIn: json["expires_in"],
//         user: User.fromJson(json["user"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "access_token": accessToken,
//         "token_type": tokenType,
//         "expires_in": expiresIn,
//         "user": user.toJson(),
//     };
// }

// class User {
//     int id;
//     int accno;
//     dynamic referrerId;
//     String fullName;
//     String email;
//     String country;
//     String education;
//     String gender;
//     String mobile;
//     dynamic residanceArea;
//     String profession;
//     String designation;
//     String companyName;
//     dynamic sector;
//     dynamic studySubject;
//     dynamic institutionName;
//     dynamic vehicleType;
//     dynamic profilePicture;
//     dynamic identityType;
//     String identityNo;
//     dynamic identityImg;
//     DateTime dob;
//     String bloodGroup;
//     dynamic fblink;
//     dynamic language;
//     int vehicle;
//     String status;
//     int freeTrial;
//     String postLimit;
//     dynamic referredBy;
//     DateTime emailVerifiedAt;
//     dynamic verificationCode;
//     String requestFrom;
//     dynamic emergencyContactPersonName;
//     dynamic emergencyContactNumber;
//     String sQuestion;
//     String sAns;
//     int employee;
//     dynamic moneyOwed;
//     dynamic received;
//     dynamic spent;
//     dynamic balance;
//     dynamic deviceToken;
//     DateTime createdAt;
//     DateTime updatedAt;

//     User({
//         this.id,
//         this.accno,
//         this.referrerId,
//         this.fullName,
//         this.email,
//         this.country,
//         this.education,
//         this.gender,
//         this.mobile,
//         this.residanceArea,
//         this.profession,
//         this.designation,
//         this.companyName,
//         this.sector,
//         this.studySubject,
//         this.institutionName,
//         this.vehicleType,
//         this.profilePicture,
//         this.identityType,
//         this.identityNo,
//         this.identityImg,
//         this.dob,
//         this.bloodGroup,
//         this.fblink,
//         this.language,
//         this.vehicle,
//         this.status,
//         this.freeTrial,
//         this.postLimit,
//         this.referredBy,
//         this.emailVerifiedAt,
//         this.verificationCode,
//         this.requestFrom,
//         this.emergencyContactPersonName,
//         this.emergencyContactNumber,
//         this.sQuestion,
//         this.sAns,
//         this.employee,
//         this.moneyOwed,
//         this.received,
//         this.spent,
//         this.balance,
//         this.deviceToken,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         accno: json["accno"],
//         referrerId: json["referrer_id"],
//         fullName: json["full_name"],
//         email: json["email"],
//         country: json["country"],
//         education: json["education"],
//         gender: json["gender"],
//         mobile: json["mobile"],
//         residanceArea: json["residance_area"],
//         profession: json["profession"],
//         designation: json["designation"],
//         companyName: json["company_name"],
//         sector: json["sector"],
//         studySubject: json["study_subject"],
//         institutionName: json["institution_name"],
//         vehicleType: json["vehicle_type"],
//         profilePicture: json["profile_picture"],
//         identityType: json["identity_type"],
//         identityNo: json["identity_no"],
//         identityImg: json["identity_img"],
//         dob: DateTime.parse(json["dob"]),
//         bloodGroup: json["blood_group"],
//         fblink: json["fblink"],
//         language: json["language"],
//         vehicle: json["vehicle"],
//         status: json["status"],
//         freeTrial: json["free_trial"],
//         postLimit: json["post_limit"],
//         referredBy: json["referred_by"],
//         emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
//         verificationCode: json["verification_code"],
//         requestFrom: json["request_from"],
//         emergencyContactPersonName: json["emergency_contact_person_name"],
//         emergencyContactNumber: json["emergency_contact_number"],
//         sQuestion: json["s_question"],
//         sAns: json["s_ans"],
//         employee: json["employee"],
//         moneyOwed: json["money_owed"],
//         received: json["received"],
//         spent: json["spent"],
//         balance: json["balance"],
//         deviceToken: json["device_token"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "accno": accno,
//         "referrer_id": referrerId,
//         "full_name": fullName,
//         "email": email,
//         "country": country,
//         "education": education,
//         "gender": gender,
//         "mobile": mobile,
//         "residance_area": residanceArea,
//         "profession": profession,
//         "designation": designation,
//         "company_name": companyName,
//         "sector": sector,
//         "study_subject": studySubject,
//         "institution_name": institutionName,
//         "vehicle_type": vehicleType,
//         "profile_picture": profilePicture,
//         "identity_type": identityType,
//         "identity_no": identityNo,
//         "identity_img": identityImg,
//         "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
//         "blood_group": bloodGroup,
//         "fblink": fblink,
//         "language": language,
//         "vehicle": vehicle,
//         "status": status,
//         "free_trial": freeTrial,
//         "post_limit": postLimit,
//         "referred_by": referredBy,
//         "email_verified_at": emailVerifiedAt.toIso8601String(),
//         "verification_code": verificationCode,
//         "request_from": requestFrom,
//         "emergency_contact_person_name": emergencyContactPersonName,
//         "emergency_contact_number": emergencyContactNumber,
//         "s_question": sQuestion,
//         "s_ans": sAns,
//         "employee": employee,
//         "money_owed": moneyOwed,
//         "received": received,
//         "spent": spent,
//         "balance": balance,
//         "device_token": deviceToken,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//     };
// }
