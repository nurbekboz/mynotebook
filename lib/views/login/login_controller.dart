import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/services/login/login_service.dart';
import 'package:my_note_book/data/services/login/model/login_request_model.dart';
import 'package:my_note_book/data/services/login/model/login_response_model.dart';
import 'package:my_note_book/data/services/update/update_service.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/common/common_values.dart';

import '../../data/services/update/model/update_request_model.dart';
import '../splash_screen/shared_not_initalze.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();

  final Rx<bool> isLoading = RxBool(false);
  final Rxn<dynamic> error = Rxn<dynamic>();
  final RxBool isLogin = RxBool(true);
  final RxnString errorTexts = RxnString();
  final userdata = GetStorage();
  final Rxn<LoginResponseModel> user = Rxn();

  final LoginService _loginService;
  final UpdateService _updateService;
  LoginController(
    this._loginService,
    this._updateService,
  );
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata.writeIfNull('isLogged', false);

    userdata.writeIfNull('userId', "");

    userdata.writeIfNull('logincount', 1);

    userdata.writeIfNull('animsolvecount', 0);
    userdata.writeIfNull('animsolvecounttrue', 0);

    // _loadPage();
  }

  void callingLoginService(String username, String password) async {
    final LoginRequestModel requestModel =
        LoginRequestModel(email: username, password: password);
    // data();
    isLoading.call(true);
    _loginService.login(requestModel).then((user) {
      // print("ZZZZ" + user.statu);
      if (user.statu == 2) isLogin.call(true);
      if (user.statu == 1) errorTexts.value = wrongPasswordText;
      if (user.statu == 0) errorTexts.value = noUserText;

      userdata.write('isLogged', true);
      userdata.write('userId', username);
      userdata.write('solved', user.solved);
      userId.value = user.userId;
    }).catchError((dynamic error) {
      this.error.trigger(error);
    }).whenComplete(() {
      isLoading.call(false);
      callingUpdateService();
    });

    // _loginService.getFirstDataLogincount(requestModel);
    // _loginService.getFirstDataanimsolvecount(requestModel);
    // _loginService.getFirstDataanimsolvecounttrue(requestModel);

    userdata
        .write('logincount',
            await _loginService.getFirstDataLogincount(requestModel))
        .toString();
    userdata
        .write('animsolvecount',
            await _loginService.getFirstDataanimsolvecount(requestModel))
        .toString();
    userdata
        .write('animsolvecounttrue',
            await _loginService.getFirstDataanimsolvecounttrue(requestModel))
        .toString();
  }

  void callingUpdateService() async {
    if (userdata.read('isLogged')) {
      var data = await userdata.read('logincount');
      int aa = int.parse(data);
      aa += 1;

      userdata.write('logincount', aa).toString();
      final UpdateRequestModel requestModel = UpdateRequestModel(
          userId: userdata.read('userId'),
          logincount: userdata.read('logincount').toString());

      isLoading.call(true);
      _updateService
          .update(requestModel)
          .then((user) {})
          .catchError((dynamic error) {
        this.error.trigger(error);
      }).whenComplete(() {
        isLoading.call(true);
        print("BURAA88");
      });
    } else {
      print("BURAA");
    }
  }

  setLoginCount() async {
    var data = await userdata.read('logincount');
    data += 1;
    print("ğğğğ" + data.toString());
    userdata.write('logincount', data).toString();

    callingUpdateService();
  }
}
