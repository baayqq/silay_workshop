// To parse this JSON data, do
//
//     final editService = editServiceFromJson(jsonString);

import 'dart:convert';

EditService editServiceFromJson(String str) =>
    EditService.fromJson(json.decode(str));

String editServiceToJson(EditService data) => json.encode(data.toJson());

class EditService {
  String? message;
  Data? data;

  EditService({this.message, this.data});

  factory EditService.fromJson(Map<String, dynamic> json) => EditService(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  int? id;
  int? userId;
  String? vehicleType;
  String? complaint;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.vehicleType,
    this.complaint,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: int.tryParse(json["id"].toString()),
    userId: int.tryParse(json["user_id"].toString()),
    vehicleType: json["vehicle_type"],
    complaint: json["complaint"],
    status: json["status"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "vehicle_type": vehicleType,
    "complaint": complaint,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
