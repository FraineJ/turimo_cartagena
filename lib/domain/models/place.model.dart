import 'dart:convert';

import 'package:turismo_cartagena/domain/models/category.model.dart';
import 'package:turismo_cartagena/domain/models/service.model.dart';
import 'package:turismo_cartagena/domain/models/zona.model.dart';

List<PlaceModel> placeModelFromJson(String str) => List<PlaceModel>.from(json.decode(str).map((x) => PlaceModel.fromJson(x)));

String placeModelToJson(List<PlaceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaceModel {
  final int id;
  final String name;
  final String descripcion;
  final String direccion;
  final double latitud;
  final double longitud;
  final String tipo;
  List<Servicio>? servicios;
  List<dynamic>? imagenes;
  final CategoryModel categoria;
  final Zona zona;

  PlaceModel({
    required this.id,
    required this.name,
    required this.descripcion,
    required this.direccion,
    required this.latitud,
    required this.longitud,
    required this.tipo,
    this.servicios, // Servicios puede ser null
    this.imagenes,  // Imágenes puede ser null
    required this.categoria,
    required this.zona,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
    id: json["id"] ?? 0, // Manejo de null en id
    name: json["name"] ?? 'Sin nombre', // Manejo de null en name
    descripcion: json["descripcion"] ?? 'Sin descripción', // Manejo de null en descripción
    direccion: json["direccion"] ?? 'Sin dirección', // Manejo de null en dirección
    latitud: json["latitud"]?.toDouble() ?? 0.0,  // Manejo de null en latitud
    longitud: json["longitud"]?.toDouble() ?? 0.0, // Manejo de null en longitud
    tipo: json["tipo"] ?? 'Desconocido',  // Manejo de null en tipo
    servicios: json["servicios"] != null
        ? List<Servicio>.from(json["servicios"].map((x) => Servicio.fromJson(x)))
        : [],  // Si es null, se asigna una lista vacía
    imagenes: json["imagenes"] != null
        ? List<dynamic>.from(json["imagenes"].map((x) => x))
        : [],  // Si es null, se asigna una lista vacía
    categoria: CategoryModel.fromJson(json["categoria"] ?? {}), // Manejo de null en categoría
    zona: Zona.fromJson(json["zona"] ?? {}), // Manejo de null en zona
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "descripcion": descripcion,
    "direccion": direccion,
    "latitud": latitud,
    "longitud": longitud,
    "tipo": tipo,
    "servicios": servicios != null
        ? List<dynamic>.from(servicios!.map((x) => x.toJson()))
        : [],  // Si servicios es null, devolvemos una lista vacía
    "imagenes": imagenes != null
        ? List<dynamic>.from(imagenes!.map((x) => x))
        : [],  // Si imágenes es null, devolvemos una lista vacía
    "categoria": categoria.toJson(),
    "zona": zona.toJson(),
  };
}
