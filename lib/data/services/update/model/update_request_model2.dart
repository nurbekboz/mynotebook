import 'dart:convert';

String updateRequestModelToJson2(UpdateRequestModel2 data) =>
    json.encode(data.toJson());

class UpdateRequestModel2 {
  final String? userId;
  final String? questionanswer;
  final String? solved;

  UpdateRequestModel2({
    this.questionanswer,
    this.userId,
    this.solved,
  });

  Map<String, dynamic> toJson() => {
        "email": userId,
        "questionanswer": questionanswer,
        "solved": solved,
      };
}
