import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/services/update/model/update_request_model.dart';
import 'package:my_note_book/data/services/update/update_service.dart';

import 'package:my_note_book/views/login/login_page.dart';

import '../common/common_values.dart';
import '../home/home_page.dart';

class SplashController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();

  final Rx<bool> isLoading = RxBool(true);
  final Rxn<dynamic> error = Rxn<dynamic>();
  final RxBool isSplash = RxBool(false);
  final RxnString errorTexts = RxnString();

  final userdata = GetStorage();

  final UpdateService _updateService;

  SplashController(
    this._updateService,
  );
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userdata.writeIfNull('isLogged', false);

    userdata.writeIfNull('userId', "");

    userdata.writeIfNull('logincount', 1);

    setLoginCount();
    callingLoginService();

    // _loadPage();
  }

  setLoginCount() async {
    var data = await userdata.read('logincount');
    data += 1;
    print("ğğğğ" + data.toString());
    userdata.write('logincount', data).toString();
  }

  // Future<void> _loadPage() async {
  //   await Future.delayed(const Duration(seconds: 5), () {
  //     userdata.read('isLogged') ? _goToLoginPage() : _goToLoginPage();
  //   });
  // }

  void callingLoginService() {
    if (userdata.read('isLogged')) {
      var data = userdata.read('logincount');
      data += 1;

      userdata.write('logincount', data).toString();
      final UpdateRequestModel requestModel = UpdateRequestModel(
          userId: userdata.read('userId'),
          logincount: userdata.read('logincount').toString());

      isSplash.call(true);
      isLoading.call(true);
      _updateService
          .update(requestModel)
          .then((user) {})
          .catchError((dynamic error) {
        this.error.trigger(error);
      }).whenComplete(() {
        isLoading.call(true);
        print("BURAA88");
        _loadPage();
      });
    } else {
      print("BURAA");
      isSplash.call(true);
      _loadPage();
    }
  }

  Future<void> _loadPage() async {
    //  SharedManager();

    await Future.delayed(const Duration(seconds: 5), () {
      userdata.read('isLogged') ? _goToHomePage() : _goToLoginPage();
    });
  }

  void _goToHomePage() {
    Get.offAndToNamed(HomePage.routeName);
  }

  void _goToLoginPage() {
    Get.offAndToNamed(LoginPage.routeName);
  }
}
