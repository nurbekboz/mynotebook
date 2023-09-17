import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/get_controllers.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/images.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/add_notes/add_notes_page.dart';
import 'package:my_note_book/views/detail/detail_controller.dart';
import 'package:my_note_book/views/detail/detail_page.dart';
import 'package:my_note_book/views/home/home_controller.dart';
import 'package:my_note_book/views/info/info_page.dart';
import 'package:my_note_book/views/login/login_page.dart';
import 'package:my_note_book/views/profile/profile_page.dart';
import 'package:my_note_book/views/question/question_page.dart';
import 'package:my_note_book/views/search/search_page.dart';

import '../../data/services/home/home_service.dart';
import '../question_anime/questionanim_page.dart';

class HomePage extends GetWidget<HomeController> {
  HomePage({Key? key}) : super(key: key);

  static const String routeName = '/views/home/home_page';
  final userdata = GetStorage();
  late String detail;
  @override
  Widget build(BuildContext context) {
    controller.error.listen((error) => _errorDialog());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(homeAppBarText),
        backgroundColor: mainColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  controller.callingGetNotesDescription();
                },
                child: Icon(Icons.refresh_outlined)),
          )
        ],
      ),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
      //    floatingActionButton: _buildFloatingActionButton()
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _goToAddNotePage(),
      child: Icon(Icons.add),
      backgroundColor: mainColor,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(5.0),
          child: _buildCard(
              controller.notesTitle.value?[index] ?? "",
              controller.notesDate.value?[index].toString() ?? "",
              controller.notesDescription.value?[index].toString(),
              index,
              context),
        ),
        itemCount: controller.notesTitle.value?.length ?? 0,
      ),
    );
  }

  Widget _buildCard(String title, String date, String? description, int index,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.setIndexs(index);
        //controller.callingGetNotesDescription(index);
        _goToDetail(context, description ?? "YÜKLENİYOR", index);
      },
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildCardColumn(title, date.toString())),
      ),
    );
  }

  Widget _buildCardColumn(
    String title,
    String date,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Divider(),
        //_buildSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              date,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSpace() {
    return SizedBox(
      height: 10,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildTitle(homeAppBarText, Icons.home, _goToBack),
          Divider(),
          _buildTitle(searchAppBarText, Icons.search, _goToSearchPage),
          Divider(),
          _questionTitle(
              questionAppBarText, Icons.question_mark, _goToQuestion),
          Divider(),
          ListTile(
            title: Text(questionAnimAppBarText),
            leading: Icon(
              Icons.games_outlined,
              color: mainColor,
            ),
            onTap: () => _goToQuestionAnim(context),
          ),

          Divider(),
          _buildTitle(profileText, Icons.person, _goToProfile),
          Divider(),
          _buildTitle(infoText, Icons.info, _goToInfo),
          Divider(),
          _buildTitle(logoutText, Icons.logout_outlined, _goLogOut),
          Divider(),
          // _buildTitle(logoutText, Icons.logout, _goToLogout),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text('Betül İNAN'),
      accountEmail: Text('inann.betull@gmail.com'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage(githubLogo),
        backgroundColor: white,
      ),
      decoration: BoxDecoration(color: mainColor),
    );
  }

  Widget _buildTitle(String text, IconData, Function function) {
    return ListTile(
      title: Text(text),
      leading: Icon(
        IconData,
        color: mainColor,
      ),
      onTap: () => function(),
    );
  }

  Widget _questionTitle(String text, IconData, Function function) {
    return ListTile(
      title: Text(text),
      leading: Icon(
        IconData,
        color: mainColor,
      ),
      onTap: () => function(),
    );
  }

  void _goToDetail(BuildContext context, String? veri, int index) async {
    // Get.toNamed(
    //   DetailPage.routeName,
    // );
    detail = controller.notesDescription.value?[index] ?? "";
    print(detail);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailPage(
                data: detail,
                index: index,
              )),
    );
  }

  void _goToBack() {
    Get.back();
  }

  void _goToProfile() {
    Get.toNamed(ProfilePage.routeName);
  }

  void _goToInfo() {
    Get.toNamed(InfoPage.routeName);
  }

  void _goLogOut() {
    getControllers();
    userdata.write('isLogged', false);
    Get.offNamedUntil(LoginPage.routeName, (route) => false);
  }

  void _goToQuestion() {
    if (userdata.read("solved") == "1") {
      _solvedDialog();
    } else if (userdata.read("solved") == "0") {
      _ALertQuestionDialog();
    }
  }

  void _goToLogout() {
    Get.offNamedUntil(LoginPage.routeName, (route) => false);
  }

  void _goToQuestionAnim(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionAnimePage()),
    );
  }

  void _goToAddNotePage() {
    Get.toNamed(AddNotesPage.routeName);
  }

  void _goToSearchPage() {
    Get.toNamed(SearchPage.routeName);
  }

  void _errorDialog() {
    Get.snackbar(
      errorTitle,
      errorDescription,
      colorText: white,
      backgroundColor: red,
    );
  }

  void _solvedDialog() {
    Get.defaultDialog(
        title: errorTitle,
        middleText: solvedText,
        backgroundColor: red,
        middleTextStyle: TextStyle(color: white));
  }

  void _ALertQuestionDialog() {
    Get.defaultDialog(
      title: alertTitle,
      middleText: sureText,
      backgroundColor: green,
      middleTextStyle: TextStyle(color: white),
      textConfirm: "Onayla",
      textCancel: "İptal",
      cancelTextColor: Colors.white,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.offAndToNamed(QuestionPage.routeName);
      },
    );
  }
}
