import 'dart:convert';

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

class RegisterRequestModel {
  final String username;
  final String email;
  final String book;
  final String logincount;
  final String password;

  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.book,
    required this.logincount,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "book": book,
        "logincount": logincount,
        "password": password,
      };
}
