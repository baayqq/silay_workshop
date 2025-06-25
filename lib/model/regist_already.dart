// To parse this JSON data, do
//
//     final registAlready = registAlreadyFromJson(jsonString);

import 'dart:convert';

RegistAlready registAlreadyFromJson(String str) =>
    RegistAlready.fromJson(json.decode(str));

String registAlreadyToJson(RegistAlready data) => json.encode(data.toJson());

class RegistAlready {
  String? message;
  Errors? errors;

  RegistAlready({this.message, this.errors});

  factory RegistAlready.fromJson(Map<String, dynamic> json) => RegistAlready(
    message: json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors?.toJson(),
  };
}

class Errors {
  List<String>? email;

  Errors({this.email});

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email:
        json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
  };
}
