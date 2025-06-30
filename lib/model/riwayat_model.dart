// To parse this JSON data, do
//
//     final riwayatServ = riwayatServFromJson(jsonString);

import 'dart:convert';

RiwayatServ riwayatServFromJson(String str) => RiwayatServ.fromJson(json.decode(str));

String riwayatServToJson(RiwayatServ data) => json.encode(data.toJson());

class RiwayatServ {
    String? message;
    List<HistoryModel>? data;

    RiwayatServ({
        this.message,
        this.data,
    });

    factory RiwayatServ.fromJson(Map<String, dynamic> json) => RiwayatServ(
        message: json["message"],
        data: json["data"] == null ? [] : List<HistoryModel>.from(json["data"]!.map((x) => HistoryModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class HistoryModel {
    int? id;
    int? userId;
    String? vehicleType;
    String? complaint;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    HistoryModel({
        this.id,
        this.userId,
        this.vehicleType,
        this.complaint,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: int.tryParse(json['id'].toString()),
        userId: int.tryParse(json['user_id'].toString()),
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
