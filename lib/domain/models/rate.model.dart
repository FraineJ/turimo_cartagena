
class Tarifa {
  final int id;
  final double precio;
  final String moneda;
  final String temporada;

  Tarifa({
    required this.id,
    required this.precio,
    required this.moneda,
    required this.temporada,
  });

  factory Tarifa.fromJson(Map<String, dynamic> json) => Tarifa(
    id: json["id"],
    precio: json["precio"],
    moneda: json["moneda"],
    temporada: json["temporada"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "precio": precio,
    "moneda": moneda,
    "temporada": temporada,
  };
}
