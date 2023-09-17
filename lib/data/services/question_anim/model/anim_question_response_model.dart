import 'dart:convert';

List<dynamic> animQuestionResponseModelFromJson(String str) =>
    List<dynamic>.from(json
        .decode(str)["notes"]
        .map((x) => x)
        .map((x) => AnimQuestionResponseModel.fromJson(x)));

class AnimQuestionResponseModel {
  AnimQuestionResponseModel({
    required this.noteId,
    required this.name,
    required this.value,
    required this.gif,
  });

  final String noteId;
  final String name;
  final String value;
  final String gif;

  factory AnimQuestionResponseModel.fromJson(Map<String, dynamic> json) =>
      AnimQuestionResponseModel(
        noteId: json["anim_questionId"],
        name: json["name"],
        value: json["value"],
        gif: json["gif"],
      );
}
