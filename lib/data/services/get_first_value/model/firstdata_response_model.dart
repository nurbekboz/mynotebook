import 'dart:convert';

FirstValueModel firstValueModelFromJson(String str) =>
    FirstValueModel.fromJson(json.decode(str));

class FirstValueModel {
  FirstValueModel({
    required this.statu,
    required this.logincount,
    required this.animsolvecount,
    required this.animsolvecounttrue,
  });

  final String statu;
  final String logincount;
  final String animsolvecount;
  final String animsolvecounttrue;

  factory FirstValueModel.fromJson(Map<String, dynamic> json) =>
      FirstValueModel(
        statu: json["noteId"],
        logincount: json["logincount"],
        animsolvecount: json["animsolvecount"],
        animsolvecounttrue: json["animsolvecounttrue"],
      );
}
