
import 'package:turismo_cartagena/domain/models/rate.model.dart';

class Servicio {
  final int id;
  final String name;
  final String descripcion;
  final String direccion;
  final String tipo;
  List<dynamic>? imagenes;
  Tarifa? tarifa;

  Servicio({
    required this.id,
    required this.name,
    required this.descripcion,
    required this.direccion,
    required this.tipo,
    this.imagenes,
    this.tarifa,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
    id: json["id"],
    name: json["name"],
    descripcion: json["descripcion"],
    direccion: json["direccion"],
    tipo: json["tipo"],
    imagenes: List<dynamic>.from(json["imagenes"].map((x) => x)),
    tarifa: Tarifa.fromJson(json["tarifa"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "descripcion": descripcion,
    "direccion": direccion,
    "tipo": tipo,
    "imagenes": List<dynamic>.from(imagenes!.map((x) => x)),
    "tarifa": tarifa!.toJson(),
  };
}

