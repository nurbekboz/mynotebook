import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  final int statu;
  final String? message;
  final String? userId;
  final String? username;
  final String? solved;

  LoginResponseModel.fromJson(Map<dynamic, dynamic> json)
      : statu = json["STATU"],
        message = json["MESSAGE"] == null ? null : json["MESSAGE"],
        userId = json["USER_ID"] == null ? null : json["USER_ID"],
        username = json["USERNAME"] == null ? null : json["USERNAME"],
        solved = json["SOLVED"] == null ? null : json["SOLVED"];
}
