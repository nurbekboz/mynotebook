import 'dart:convert';

List<dynamic> questionResponseModelFromJson(String str) =>
    List<dynamic>.from(json
        .decode(str)["notes"]
        .map((x) => x)
        .map((x) => QuestionResponseModel.fromJson(x)));

class QuestionResponseModel {
  QuestionResponseModel({
    required this.questionId,
    required this.description,
    required this.answer,
  });

  final String questionId;
  final String description;
  final String answer;

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) =>
      QuestionResponseModel(
        questionId: json["questionId"],
        description: json["description"],
        answer: json["answer"],
      );
}
