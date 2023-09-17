import 'package:http/http.dart' as http;

import '../update/model/update_request_model.dart';
import '../update/model/update_request_model2.dart';
import '../update/model/update_response_model.dart';
import 'model/question_response_model.dart';

abstract class QuestionService {
  Future getQuestionDescription();
  Future getQuestionAnswer();
  Future updateQuestionAnswer(UpdateRequestModel2 registerRequestModel);
}

class QuestionServiceImp extends QuestionService {
  @override
  Future getQuestionAnswer() async {
    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/get_questions.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.get(_url);

    var noteListDescription = [];

    if (response.statusCode == 200) {
      var data = questionResponseModelFromJson(response.body);
      for (int i = 0; i < data.length; i++) {
        noteListDescription.add(data[i].answer);
      }

      return noteListDescription;
    } else {
      return '';
    }
  }

  @override
  Future getQuestionDescription() async {
    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/get_questions.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.get(_url);

    var noteListDescription = [];

    if (response.statusCode == 200) {
      var data = questionResponseModelFromJson(response.body);
      for (int i = 0; i < data.length; i++) {
        noteListDescription.add(data[i].description);
      }
      return noteListDescription;
    } else {
      return '';
    }
  }

  @override
  Future updateQuestionAnswer(UpdateRequestModel2 updateRequestModel) async {
    print("IAIIAIAI" + updateRequestModel.toJson().toString());
    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/update_user_answer.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.post(_url, body: updateRequestModel.toJson());

    if (response.statusCode == 200) {
      String a = updateResponseModelFromJson(response.body).message ?? "";
      print("XXXX" + a.toString());
      return updateResponseModelFromJson(response.body);
    } else {
      print("XXXX");
      return 'dadwa';
    }
  }
}
