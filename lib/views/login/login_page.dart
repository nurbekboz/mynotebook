import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note_book/data/get_controllers.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/images.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/home/home_controller.dart';
import 'package:my_note_book/views/home/home_page.dart';
import 'package:my_note_book/views/login/login_controller.dart';
import 'package:my_note_book/views/register/register_page.dart';

import '../../data/services/home/home_service.dart';

class LoginPage extends GetWidget<LoginController> {
  static const String routeName = '/views/login/login_page';

  @override
  Widget build(BuildContext context) {
    controller.error.listen((error) => _errorDialog);
    controller.isLogin.listen((isLogin) {
      if (isLogin) {
        _loginDialog();
        _goToHomePage();
      }
    });
    controller.errorTexts.listen((errorTexts) {
      if (errorTexts != null) _errorTextsDialog(errorTexts);
    });

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(loginAppBarText),
          backgroundColor: mainColor,
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSpace(),
              _buildImage(),
              _buildMaxSpace(),
              _buildUsernameTextField(),
              _buildSpace(),
              _buildPasswordTextField(),
              _buildMaxSpace(),
              _buildButton(),
              _buildSpace(),
              _buildRegisterText()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      githubLogo,
      height: Get.height * .3,
    );
  }

  Widget _buildUsernameTextField() {
    return Material(
      elevation: 10,
      color: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(300),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
        child: TextFormField(
          textInputAction: TextInputAction.next,
          validator: phoneFormFiledValidator,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: emailText,
          ),
          controller: controller.usernameController,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Material(
      elevation: 10,
      color: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(300),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: passwordText,
          ),
          controller: controller.passwordControler,
        ),
      ),
    );
  }

  Widget _buildButton() {
    final double size = 40;
    return SizedBox(
      height: size,
      child: ElevatedButton(
          onPressed: () {
            if (controller.usernameController.text.isNotEmpty &&
                controller.passwordControler.text.isNotEmpty) {
              controller.callingLoginService(
                controller.usernameController.text,
                controller.passwordControler.text,
              );
            } else {
              _emptyDialog();
            }
          },
          child: Text(loginButton),
          style: ElevatedButton.styleFrom(
            primary: mainColor,
          )),
    );
  }

  Widget _buildSpace() {
    return SizedBox(
      height: 20,
    );
  }

  Widget _buildMaxSpace() {
    return SizedBox(
      height: 40,
    );
  }

  Widget _buildRegisterText() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: registerQuestionText,
            style: TextStyle(color: black),
          ),
          TextSpan(
              text: registerButtonText,
              style: TextStyle(color: black, fontStyle: FontStyle.italic),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  getControllers();
                  Get.toNamed(RegisterPage.routeName);
                }),
        ]));
  }

  void _goToHomePage() {
    getControllers();
    Get.offAndToNamed(HomePage.routeName);
  }

  void _errorDialog() {
    Get.snackbar(
      errorTitle,
      errorDescription,
      colorText: white,
      backgroundColor: red,
    );
  }

  void _emptyDialog() {
    Get.snackbar(
      errorTitle,
      emptyText,
      colorText: white,
      backgroundColor: red,
    );
  }

  void _errorTextsDialog(String description) {
    Get.snackbar(
      errorTitle,
      description,
      colorText: white,
      backgroundColor: red,
    );
  }

  void _loginDialog() {
    Get.snackbar(
      "Tebrikler",
      "Giriş Başarılı",
      colorText: white,
      backgroundColor: green,
    );
  }

  String? phoneFormFiledValidator(String? value) {
    //String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    String patttern = r'(^(?:[+0]9)?[0-9]{11}$)';
    RegExp regExp = new RegExp(patttern);
    print("value");
    if (value?.length == 0 && value!.length < 11) {
      return null;
    } else if (!regExp.hasMatch(value ?? "")) {
      return 'Lütfen telefon numaranızı doğru giriniz';
    }
    return null;
  }
}
