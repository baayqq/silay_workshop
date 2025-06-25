// To parse this JSON data, do
//
//     final registmodel = registmodelFromJson(jsonString);

import 'dart:convert';

Registmodel registmodelFromJson(String str) => Registmodel.fromJson(json.decode(str));

String registmodelToJson(Registmodel data) => json.encode(data.toJson());

class Registmodel {
    String? message;
    Data? data;

    Registmodel({
        this.message,
        this.data,
    });

    factory Registmodel.fromJson(Map<String, dynamic> json) => Registmodel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? token;
    User? user;

    Data({
        this.token,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
    };
}

class User {
    String? name;
    String? email;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    User({
        this.name,
        this.email,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
