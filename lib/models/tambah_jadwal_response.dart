// To parse this JSON data, do
//
//     final tambahFilmResponse = tambahFilmResponseFromJson(jsonString);

import 'dart:convert';

TambahFilmResponse tambahFilmResponseFromJson(String str) =>
    TambahFilmResponse.fromJson(json.decode(str));

String tambahFilmResponseToJson(TambahFilmResponse data) =>
    json.encode(data.toJson());

class TambahFilmResponse {
  String message;
  Data data;

  TambahFilmResponse({required this.message, required this.data});

  factory TambahFilmResponse.fromJson(Map<String, dynamic> json) =>
      TambahFilmResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class Data {
  int filmId;
  DateTime startTime;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Data({
    required this.filmId,
    required this.startTime,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    filmId: json["film_id"],
    startTime: DateTime.parse(json["start_time"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "film_id": filmId,
    "start_time": startTime.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
