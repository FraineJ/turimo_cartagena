import 'dart:convert';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  String id;
  String description;
  String name;
  List<String> imagesUrl;
  double longitud;
  double latitud;
  String autor;
  String? openingDate; // Opcional
  DateTime? endDate;   // Opcional
  String dedication;
  String invite;
  String status;
  String address;
  bool? video;

  EventModel({
    required this.id,
    required this.description,
    required this.name,
    required this.imagesUrl,
    required this.longitud,
    required this.latitud,
    required this.autor,
    this.openingDate,
    this.endDate,
    required this.dedication,
    required this.invite,
    required this.status,
    required this.address,
    this.video
  });

  /// Método `fromJson` ajustado para manejar campos opcionales correctamente.
  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["_id"] ?? "", // Manejo seguro
    description: json["description"] ?? "",
    name: json["name"] ?? "",
    imagesUrl: List<String>.from(json["imagesUrl"].map((x) => x)),
    longitud: (json["longitud"] ?? 0).toDouble(),
    latitud: (json["latitud"] ?? 0).toDouble(),
    autor: json["autor"] ?? "",
    openingDate: json["openingDate"], // Campo opcional, puede ser null
    endDate: json["endDate"] != null ? DateTime.tryParse(json["endDate"]) : null,
    dedication: json["dedication"] ?? "",
    invite: json["invite"] ?? "",
    status: json["status"] ?? "",
    address: json["address"] ?? "",
    video: json["video"] ?? false
  );

  /// Método `toJson` ajustado para manejar campos opcionales.
  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    "name": name,
    "imagesUrl": List<dynamic>.from(imagesUrl.map((x) => x)),
    "longitud": longitud,
    "latitud": latitud,
    "autor": autor,
    "openingDate": openingDate, // Incluye null si no está presente
    "endDate": endDate?.toIso8601String(), // Convierte a formato ISO si no es null
    "dedication": dedication,
    "invite": invite,
    "status": status,
    "address": address,
    "video" : video
  };
}
