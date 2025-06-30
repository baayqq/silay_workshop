// To parse this JSON data, do
//
//     final statusService = statusServiceFromJson(jsonString);

import 'dart:convert';

StatusService statusServiceFromJson(String str) => StatusService.fromJson(json.decode(str));

String statusServiceToJson(StatusService data) => json.encode(data.toJson());

class StatusService {
    String? message;
    Data? data;

    StatusService({
        this.message,
        this.data,
    });

    factory StatusService.fromJson(Map<String, dynamic> json) => StatusService(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? status;

    Data({
        this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
    };
}
