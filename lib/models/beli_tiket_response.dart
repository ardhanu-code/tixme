// To parse this JSON data, do
//
//     final beliTiketResponse = beliTiketResponseFromJson(jsonString);

import 'dart:convert';

BeliTiketResponse beliTiketResponseFromJson(String str) =>
    BeliTiketResponse.fromJson(json.decode(str));

String beliTiketResponseToJson(BeliTiketResponse data) =>
    json.encode(data.toJson());

class BeliTiketResponse {
  String message;
  Data data;

  BeliTiketResponse({required this.message, required this.data});

  factory BeliTiketResponse.fromJson(Map<String, dynamic> json) =>
      BeliTiketResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class Data {
  int userId;
  int scheduleId;
  int quantity;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Data({
    required this.userId,
    required this.scheduleId,
    required this.quantity,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    scheduleId: json["schedule_id"],
    quantity: json["quantity"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "schedule_id": scheduleId,
    "quantity": quantity,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
