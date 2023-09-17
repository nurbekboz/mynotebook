import 'dart:convert';

String updateRequestModelToJson(UpdateRequestModel data) =>
    json.encode(data.toJson());

class UpdateRequestModel {
  final String? userId;
  final String? logincount;

  UpdateRequestModel({
    required this.userId,
    required this.logincount,
  });

  Map<String, dynamic> toJson() => {
        "email": userId,
        "logincount": logincount,
      };
}
