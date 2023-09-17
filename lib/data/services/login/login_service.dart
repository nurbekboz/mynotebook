import 'package:http/http.dart' as http;
import 'package:my_note_book/data/services/login/model/login_request_model.dart';
import 'package:my_note_book/data/services/login/model/login_response_model.dart';

import '../get_first_value/model/firstdata_response_model.dart';

abstract class LoginService {
  Future login(LoginRequestModel registerRequestModel);
  Future getFirstDataLogincount(LoginRequestModel loginRequestModel);
  Future getFirstDataanimsolvecount(LoginRequestModel loginRequestModel);
  Future getFirstDataanimsolvecounttrue(LoginRequestModel loginRequestModel);
}

class LoginServiceImp extends LoginService {
  @override
  Future login(LoginRequestModel loginRequestModel) async {
    const String _baseUrl = 'https://www.dersnotlarim.net/makale/login.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.post(_url, body: loginRequestModel.toJson());
    print("IAIIAIAI" + loginResponseModelFromJson(response.body).toString());
    if (response.statusCode == 200) {
      return loginResponseModelFromJson(response.body);
    } else {
      return '';
    }
  }

  @override
  Future getFirstDataLogincount(LoginRequestModel loginRequestModel) async {
    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/get_user_notes.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.post(_url, body: loginRequestModel.toJson());

    if (response.statusCode == 200) {
      var data = firstValueModelFromJson(response.body).logincount;
      print("logincount" + data.toString());
      return data;
    } else {
      return '';
    }
  }

  @override
  Future getFirstDataanimsolvecount(LoginRequestModel loginRequestModel) async {
    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/get_user_notes.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.post(_url, body: loginRequestModel.toJson());

    if (response.statusCode == 200) {
      var data = firstValueModelFromJson(response.body).animsolvecount;
      print("animsolvecount" + data.toString());
      return data;
    } else {
      return '';
    }
  }

  @override
  Future getFirstDataanimsolvecounttrue(
      LoginRequestModel loginRequestModel) async {
    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/get_user_notes.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.post(_url, body: loginRequestModel.toJson());

    if (response.statusCode == 200) {
      var data = firstValueModelFromJson(response.body).animsolvecounttrue;
      print("animsolvecounttrue" + data.toString());
      return data;
    } else {
      return '';
    }
  }
}
