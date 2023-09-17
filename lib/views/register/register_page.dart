import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/login/login_page.dart';
import 'package:my_note_book/views/register/register_controller.dart';

class RegisterPage extends GetWidget<RegisterController> {
  static const String routeName = '/views/register/register_page';
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    controller.isRegister.listen((isRegister) {
      if (isRegister) _goToLogin();
    });

    controller.error.listen((error) => _errorDialog());

    return Scaffold(
        appBar: AppBar(
          title: Text(registerAppBarText),
          backgroundColor: mainColor,
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Form(
      key: _key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSpace(),
              _buildUsernameTextFormField(),
              _buildSpace(),
              _buildEmailTextFormField(),
              _buildSpace(),
              _buildBookTextFormField(),
              _buildSpace(),
              _buildPasswordTextFormField(),
              _buildSpace(),
              _buildPasswordVerifyTextFormField(),
              _buildSpace(),
              _buildButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          usernameText,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        _buildSpace2(),
        Material(
          elevation: 10,
          color: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(300),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: usernameText,
              ),
              controller: controller.usernameController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          emailText,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        _buildSpace2(),
        Material(
          elevation: 10,
          color: white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
            child: TextFormField(
              validator: phoneFormFiledValidator,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: emailText,
              ),
              controller: controller.emailController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          bookText,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        _buildSpace2(),
        Material(
          elevation: 10,
          color: white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: bookText,
              ),
              controller: controller.bookController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          passwordText,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        _buildSpace2(),
        Material(
          elevation: 10,
          color: white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: passwordText,
              ),
              controller: controller.passwordController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordVerifyTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          passwordVerifyText,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        _buildSpace2(),
        Material(
          elevation: 10,
          color: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(300),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: passwordVerifyText,
              ),
              controller: controller.passwordVerifyController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    final double size = 40;
    return SizedBox(
      height: size,
      child: ElevatedButton(
          onPressed: () => _onTap(),
          child: Text(registerText),
          style: ElevatedButton.styleFrom(
            primary: mainColor,
          )),
    );
  }

  void _onTap() async {
    print(controller.usernameController.text +controller.emailController.text+controller.bookController.text+controller.passwordController.text+
    controller.passwordController.text.length.toString());
    print( controller.passwordController.text ==
            controller.passwordVerifyController.text);
    if (controller.usernameController.text.isNotEmpty &&
        controller.emailController.text.isNotEmpty &&
        controller.bookController.text.isNotEmpty &&
        controller.passwordController.text.isNotEmpty &&
        controller.passwordController.text.length >= 5 &&
        controller.passwordController.text ==
            controller.passwordVerifyController.text) {
      _showLoggedBar();
      controller.callingRegisterService(
        controller.usernameController.text,
        controller.emailController.text,
        controller.bookController.text,
        controller.passwordController.text,
      );
    } else {
      if (controller.passwordController.text !=
          controller.passwordVerifyController.text) {
        _validPasspord();
      } else if (controller.passwordController.text.length < 5) {
        _shotpassDialog();
      } else {
        _emptyDialog();
        
      }
    }
  }

  Widget _buildSpace() {
    return SizedBox(
      height: 20,
    );
  }

  Widget _buildSpace2() {
    return SizedBox(
      height: 5,
    );
  }

  void _goToLogin() {
    Get.toNamed(LoginPage.routeName);
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

  void _shotpassDialog() {
    Get.snackbar(
      errorTitle,
      shortPassText,
      colorText: white,
      backgroundColor: red,
    );
  }

  void _validPasspord() {
    Get.snackbar(
      errorTitle,
      notmatchPasswordText,
      colorText: white,
      backgroundColor: red,
    );
  }

  _showLoggedBar() {
    Get.snackbar(
      succesTitle,
      registeredText,
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
