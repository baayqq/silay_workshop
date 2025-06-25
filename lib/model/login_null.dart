import 'dart:convert';

LoginNull loginNullFromJson(String str) => LoginNull.fromJson(json.decode(str));

String loginNullToJson(LoginNull data) => json.encode(data.toJson());

class LoginNull {
  String? message;
  dynamic data;

  LoginNull({this.message, this.data});

  factory LoginNull.fromJson(Map<String, dynamic> json) =>
      LoginNull(message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {"message": message, "data": data};
}
