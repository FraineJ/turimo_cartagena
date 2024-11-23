// To parse this JSON data, do
//
//     final zona = zonaFromJson(jsonString);

import 'dart:convert';

Zona zonaFromJson(String str) => Zona.fromJson(json.decode(str));

String zonaToJson(Zona data) => json.encode(data.toJson());

class Zona {
  final int? id;
  final String? name;
  final String? code;

  Zona({
    this.id,
    this.name,
    this.code,
  });

  factory Zona.fromJson(Map<String, dynamic> json) => Zona(
    id: json["id"],
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}
