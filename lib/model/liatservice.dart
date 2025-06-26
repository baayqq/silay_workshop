// To parse this JSON data, do
//
//     final liatserv = liatservFromJson(jsonString);

import 'dart:convert';

Liatserv liatservFromJson(String str) => Liatserv.fromJson(json.decode(str));

String liatservToJson(Liatserv data) => json.encode(data.toJson());

class Liatserv {
    String? message;
    List<GetServ>? data;

    Liatserv({
        this.message,
        this.data,
    });

    factory Liatserv.fromJson(Map<String, dynamic> json) => Liatserv(
        message: json["message"],
        data: json["data"] == null ? [] : List<GetServ>.from(json["data"]!.map((x) => GetServ.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class GetServ {
    int? id;
    int? userId;
    String? vehicleType;
    String? complaint;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    GetServ({
        this.id,
        this.userId,
        this.vehicleType,
        this.complaint,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory GetServ.fromJson(Map<String, dynamic> json) => GetServ(
        id: json["id"],
        userId: json["user_id"],
        vehicleType: json["vehicle_type"],
        complaint: json["complaint"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
