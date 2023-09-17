import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/images.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/home/home_page.dart';
import 'package:my_note_book/views/register/register_page.dart';
import 'package:my_note_book/views/splash_screen/splash_controller.dart';

import '../login/login_page.dart';

class SplashPage extends GetWidget<SplashController> {
  static const String routeName = '/views/Splash/Splash_page';
  final userdata = GetStorage();
  @override
  Widget build(BuildContext context) {
    print("isSplash" + controller.isSplash.toString());
    //_loadPage();
    // controller.isSplash.listen((isSplash) {
    //   print(isSplash);
    //   if (isSplash) {
    //     _loadPage();
    //   }
    // });

    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: _buildImage(),
          ),
          _buildText()
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      githubLogo,
      height: Get.height * .3,
    );
  }

  Widget _buildText() {
    return Text(
      homeAppBarText,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  void _loadPage() {
    userdata.read('isLogged') ? _goToHomePage() : _goToLoginPage();
  }

  void _goToHomePage() {
    Get.offAndToNamed(HomePage.routeName);
  }

  void _goToLoginPage() {
    Get.offAndToNamed(LoginPage.routeName);
  }
}
