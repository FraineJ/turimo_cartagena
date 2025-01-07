import 'dart:convert';

import 'package:turismo_cartagena/domain/models/category.model.dart';
import 'package:turismo_cartagena/domain/models/service.model.dart';
import 'package:turismo_cartagena/domain/models/zona.model.dart';

List<PlaceModel> placeModelFromJson(String str) => List<PlaceModel>.from(json.decode(str).map((x) => PlaceModel.fromJson(x)));

String placeModelToJson(List<PlaceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaceModel {
  final int id;
  final String name;
  final String description;
  final String address;
  final double latitud;
  final double longitud;
  List<dynamic>? imagesUrl;

  PlaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitud,
    required this.longitud,
    this.imagesUrl,  // Imágenes puede ser null
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
    id: json["id"] ?? 0, // Manejo de null en id
    name: json["name"] ?? 'Sin nombre', // Manejo de null en name
    description: json["description"] ?? 'Sin descripción', // Manejo de null en descripción
    address: json["address"] ?? 'Sin dirección', // Manejo de null en dirección
    latitud: json["latitud"]?.toDouble() ?? 0.0,  // Manejo de null en latitud
    longitud: json["longitud"]?.toDouble() ?? 0.0, // Manejo de null en longitud// Si es null, se asigna una lista vacía
    imagesUrl: json["imagesUrl"] != null
        ? List<dynamic>.from(json["imagesUrl"].map((x) => x))
        : [],  // Si es null, se asigna una lista vacía
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description ?? "",
    "address": address,
    "latitud": latitud,
    "longitud": longitud, // Si servicios es null, devolvemos una lista vacía
    "imagesUrl": imagesUrl != null
        ? List<dynamic>.from(imagesUrl!.map((x) => x))
        : [],  // Si imágenes es null, devolvemos una lista vacía
  };
}
