import 'package:http/http.dart' as http;
import 'package:my_note_book/data/services/login/model/login_request_model.dart';
import 'package:my_note_book/data/services/login/model/login_response_model.dart';

import 'model/update_request_model.dart';
import 'model/update_response_model.dart';

abstract class UpdateService {
  Future update(UpdateRequestModel registerRequestModel);
}

class UpdateServiceImp extends UpdateService {
  @override
  Future update(UpdateRequestModel updateRequestModel) async {
    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/update_user.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.post(_url, body: updateRequestModel.toJson());
    print("IAIIAIAI" + updateRequestModel.toJson().toString());
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
