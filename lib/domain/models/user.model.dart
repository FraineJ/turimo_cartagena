import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String username;
  final String name;
  final String email;
  final String numberPhone;
  final String password;
  String? nacionalidad;

  UserModel({
    required this.username,
    required this.name,
    required this.email,
    required this.numberPhone,
    required this.password,
    required this.nacionalidad,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    name: json["name"],
    email: json["email"],
    numberPhone: json["numberPhone"],
    password: json["password"],
    nacionalidad: json["nacionalidad"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "email": email,
    "numberPhone": numberPhone,
    "password": password,
    "nacionalidad": nacionalidad,
  };
}
