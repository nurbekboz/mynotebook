import 'dart:convert';

UpdateResponseModel updateResponseModelFromJson(String str) =>
    UpdateResponseModel.fromJson(json.decode(str));

class UpdateResponseModel {
  final int statu;
  final String? message;
  final String? userId;
  final String? username;

  UpdateResponseModel.fromJson(Map<dynamic, dynamic> json)
      : statu = json["STATU"],
        message = json["MESSAGE"] == null ? null : json["MESSAGE"],
        userId = json["USER_ID"] == null ? null : json["USER_ID"],
        username = json["USERNAME"] == null ? null : json["USERNAME"];
}
