// To parse this JSON data, do
//
//     final liatserv = liatservFromJson(jsonString);

import 'dart:convert';

Liatserv liatservFromJson(String str) => Liatserv.fromJson(json.decode(str));

String liatservToJson(Liatserv data) => json.encode(data.toJson());

class Liatserv {
  String? message;
  List<GetServ>? data;

  Liatserv({this.message, this.data});

  factory Liatserv.fromJson(Map<String, dynamic> json) => Liatserv(
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<GetServ>.from(json["data"]!.map((x) => GetServ.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetServ {
  String? bookingDate;
  String? vehicleType;
  String? description;

  GetServ({this.bookingDate, this.vehicleType, this.description});

  factory GetServ.fromJson(Map<String, dynamic> json) => GetServ(
    bookingDate: json['booking_date'],
    vehicleType: json['vehicle_type'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'booking_date': bookingDate,
    'vehicle_type': vehicleType,
    'description': description,
  };
}
