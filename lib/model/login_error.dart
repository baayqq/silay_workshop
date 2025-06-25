

import 'dart:convert';

LoginError loginErrorFromJson(String str) =>
    LoginError.fromJson(json.decode(str));

String loginErrorToJson(LoginError data) => json.encode(data.toJson());

class LoginError {
  String? message;
  dynamic data;

  LoginError({this.message, this.data});

  factory LoginError.fromJson(Map<String, dynamic> json) =>
      LoginError(message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {"message": message, "data": data};
}
