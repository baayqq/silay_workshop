// To parse this JSON data, do
//
//     final tambahservice = tambahserviceFromJson(jsonString);

import 'dart:convert';

Tambahservice tambahserviceFromJson(String str) => Tambahservice.fromJson(json.decode(str));

String tambahserviceToJson(Tambahservice data) => json.encode(data.toJson());

class Tambahservice {
    String? message;
    Data? data;

    Tambahservice({
        this.message,
        this.data,
    });

    factory Tambahservice.fromJson(Map<String, dynamic> json) => Tambahservice(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    DateTime? bookingDate;
    String? vehicleType;
    String? description;
    int? userId;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.bookingDate,
        this.vehicleType,
        this.description,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
        vehicleType: json["vehicle_type"],
        description: json["description"],
        userId: json["user_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "booking_date": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "vehicle_type": vehicleType,
        "description": description,
        "user_id": userId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
