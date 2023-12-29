// To parse this JSON data, do
//
//     final myTicketsModel = myTicketsModelFromJson(jsonString);

import 'dart:convert';

MyTicketsModel myTicketsModelFromJson(String str) => MyTicketsModel.fromJson(json.decode(str));


class MyTicketsModel {
    List<Datum>? data;
    Links? links;
    Meta? meta;

    MyTicketsModel({
        this.data,
        this.links,
        this.meta,
    });

    factory MyTicketsModel.fromJson(Map<String, dynamic> json) => MyTicketsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
    );

  
}

class Datum {
    int? id;
    String? user;
    dynamic category;
    String? subject;
    String? message;
    String? status;
    String? number;
    DateTime? opened;
    DateTime? updated;
    var messages;

    Datum({
        this.id,
        this.user,
        this.category,
        this.subject,
        this.message,
        this.status,
        this.number,
        this.opened,
        this.updated,
        this.messages,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        user: json["user"],
        category: json["category"],
        subject: json["subject"],
        message: json["message"],
        status: json["status"],
        number: json["number"],
        opened: DateTime.parse(json["opened"]),
        updated: DateTime.parse(json["updated"]),
        messages: List<dynamic>.from(json["messages"].map((x) => x)),
    );

 
}

class Links {
    String? first;
    String? last;
    dynamic prev;
    dynamic next;

    Links({
        this.first,
        this.last,
        this.prev,
        this.next,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
    );

   
}

class Meta {
    int? currentPage;
    int? from;
    int? lastPage;
    String? path;
    int? perPage;
    int? to;
    int? total;

    Meta({
        this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
    );

   
}
