import 'dart:convert';

List<TicketCategoryModel> ticketCategoryModelFromJson(String str) =>
    List<TicketCategoryModel>.from(
        json.decode(str).map((x) => TicketCategoryModel.fromJson(x)));

class TicketCategoryModel {
  int? id;
  String? name;

  TicketCategoryModel({
    this.id,
    this.name,
  });

  factory TicketCategoryModel.fromJson(Map<String, dynamic> json) =>
      TicketCategoryModel(
        id: json["id"],
        name: json["name"],
      );
}
