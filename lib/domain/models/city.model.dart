import 'dart:convert';

CityModel FromJson(String str) => CityModel.fromJson(json.decode(str));

String userToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  final String name;
  final String description;


  CityModel({
    required this.name,
    required this.description
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    name: json["name"],
    description: json["description"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
  };
}
