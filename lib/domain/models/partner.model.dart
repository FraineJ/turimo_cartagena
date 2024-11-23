// To parse this JSON data, do
//
//     final partnersModel = partnersModelFromJson(jsonString);

import 'dart:convert';

PartnersModel partnersModelFromJson(String str) => PartnersModel.fromJson(json.decode(str));

String partnersModelToJson(PartnersModel data) => json.encode(data.toJson());

class PartnersModel {
  String id;
  String name;
  double longitud;
  double latitud;
  List<String> imagesUrl;
  String description;
  String status;
  int whatsapp;
  int phone;
  String email;
  String link;
  String address;
  String categoryId;

  PartnersModel({
    required this.id,
    required this.name,
    required this.longitud,
    required this.latitud,
    required this.imagesUrl,
    required this.description,
    required this.status,
    required this.whatsapp,
    required this.phone,
    required this.email,
    required this.link,
    required this.address,
    required this.categoryId,
  });

  factory PartnersModel.fromJson(Map<String, dynamic> json) => PartnersModel(
    id: json["_id"],
    name: json["name"],
    longitud: json["longitud"]?.toDouble(),
    latitud: json["latitud"]?.toDouble(),
    imagesUrl: List<String>.from(json["imagesUrl"].map((x) => x)),
    description: json["description"],
    status: json["status"],
    whatsapp: json["whatsapp"],
    phone: json["phone"],
    email: json["email"],
    link: json["link"],
    address: json["address"],
    categoryId: json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "longitud": longitud,
    "latitud": latitud,
    "imagesUrl": List<dynamic>.from(imagesUrl.map((x) => x)),
    "description": description,
    "status": status,
    "whatsapp": whatsapp,
    "phone": phone,
    "email": email,
    "link": link,
    "address": address,
    "categoryId": categoryId,
  };
}
