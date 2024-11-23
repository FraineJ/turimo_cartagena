import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String lastName;
  final String name;
  final String email;
  //String? phone;
  final String password;
  String? nationality;
  String status;

  UserModel({
    required this.lastName,
    required this.name,
    required this.email,
    required this.password,
    required this.nationality,
    required  this.status
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    lastName: json["lastName"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    nationality: json["nationality"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "lastName": lastName,
    "name": name,
    "email": email,
    "password": password,
    "nationality": nationality,
    "status": status,
  };
}
