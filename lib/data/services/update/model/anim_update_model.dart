import 'dart:convert';

String animupdateRequestModelToJson(AnimUpdateRequestModel data) =>
    json.encode(data.toJson());

class AnimUpdateRequestModel {
  final String? userId;
  final String? questionanswer;
  final String? animsolvecount;
  final String? animsolvecounttrue;

  AnimUpdateRequestModel({
    this.questionanswer,
    this.userId,
    this.animsolvecount,
    this.animsolvecounttrue,
  });

  Map<String, dynamic> toJson() => {
        "email": userId,
        "animquestionanswer": questionanswer,
        "animsolvecount": animsolvecount,
        "animsolvecounttrue": animsolvecounttrue,
      };
}
