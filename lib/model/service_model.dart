// To parse this JSON data, do
//
//     final addservice = addserviceFromJson(jsonString);

import 'dart:convert';

Addservice addserviceFromJson(String str) =>
    Addservice.fromJson(json.decode(str));

String addserviceToJson(Addservice data) => json.encode(data.toJson());

class Addservice {
  String? message;
  ServiceData? data;

  Addservice({this.message, this.data});

  factory Addservice.fromJson(Map<String, dynamic> json) => Addservice(
    message: json["message"],
    data: json["data"] == null ? null : ServiceData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class ServiceData {
  String? vehicleType;
  String? complaint;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? status; // ✅ tambahkan ini

  ServiceData({
    this.vehicleType,
    this.complaint,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.status, // ✅ tambahkan ini
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
    vehicleType: json["vehicle_type"],
    complaint: json["complaint"],
    userId:
        json["user_id"] != null
            ? int.tryParse(json["user_id"].toString())
            : null,
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    status: json["status"], // ✅ tambahkan ini
  );

  Map<String, dynamic> toJson() => {
    "vehicle_type": vehicleType,
    "complaint": complaint,
    "user_id": userId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "status": status, // ✅ tambahkan ini
  };
}
