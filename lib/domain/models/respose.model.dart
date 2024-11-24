import 'dart:convert';

ResponsePages resultadosPagesFromJson(String str) => ResponsePages.fromJson(json.decode(str));

String resultadosPagesToJson(ResponsePages data) => json.encode(data.toJson());

class ResponsePages {
  final List<dynamic> data;
  final String menssage;
  final int status;

  ResponsePages({
    required this.data,
    required this.menssage,
    required this.status,
  });

  factory ResponsePages.fromJson(Map<String, dynamic> json) => ResponsePages(
    data: List<dynamic>.from(json["data"].map((x) => x)),
    menssage: json["menssage"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
    "menssage": menssage,
    "status": status,
  };
}
