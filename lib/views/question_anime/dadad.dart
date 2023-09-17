/**
 * 
 * 
 * 
 import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/question_anime/questionanim_controller.dart';

class QuestionAnimePage extends StatefulWidget {
  @override
  _QuestionAnimePageState createState() => _QuestionAnimePageState();
}

class _QuestionAnimePageState extends State<QuestionAnimePage> {
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late QuestionAnimeController animcontroller;
  late int score;
  late int selectedvalue;
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    animcontroller = QuestionAnimeController();
    gameOver = false;
    score = 0;
    selectedvalue = 0;
    items = [
      ItemModel(
          icon: FontAwesomeIcons.coffee,
          name: "Coffee",
          value: "Coffee",
          numbervalue: 0),
      ItemModel(
          icon: FontAwesomeIcons.dog,
          name: "dog",
          value: "dog",
          numbervalue: 1),
      ItemModel(
          icon: FontAwesomeIcons.cat,
          name: "Cat",
          value: "Cat",
          numbervalue: 2),
      ItemModel(
          icon: FontAwesomeIcons.birthdayCake,
          name: "Cake",
          value: "Cake",
          numbervalue: 3),
      ItemModel(
          icon: FontAwesomeIcons.bus,
          name: "bus",
          value: "bus",
          numbervalue: 4),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  void _setSelectedValue() {
    setState(() {
      selectedvalue++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) gameOver = true;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        centerTitle: true,
        title: Text(machText),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: items2.map((item) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: (() {
                        if (selectedvalue == item.numbervalue) {
                          _setSelectedValue();
                          _solvedDialog();
                          items.remove(item);
                          items2.remove(item);
                        } else {}
                        setState(() {});
                      }),
                      child: Material(
                        color: Colors.blue,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          child: Center(child: Text(item.name)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              }).toList()),
        ),
      ),
    );
  }

  void _solvedDialog() {
    Get.defaultDialog(
      title: "",
      content:
          Image.network("https://www.dersnotlarim.net/makale/gift/besdk.gif"),
    );
  }

  void _showInfoDialog() {
    Get.defaultDialog(
        title: alertTitle,
        middleText: eslestirmeText,
        backgroundColor: green,
        middleTextStyle: TextStyle(color: white));
  }
}

class ItemModel {
  final String name;
  final String value;
  final int numbervalue;
  final IconData icon;
  bool accepting;

  ItemModel(
      {required this.name,
      required this.value,
      required this.icon,
      required this.numbervalue,
      this.accepting = false});
}
/ */

/*
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/question_anime/questionanim_controller.dart';

import '../../data/services/question_anim/model/anim_question_response_model.dart';

class QuestionAnimePage extends GetWidget<QuestionAnimeController> {
  QuestionAnimePage({Key? key}) : super(key: key);
  static const String routeName = '/views/question_anime/questionanim_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        centerTitle: true,
        title: Text(machText),
        backgroundColor: mainColor,
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: (() {
                controller.increaseSelectedValue(index);
              }),
              child: Material(
                color: Colors.blue,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                          controller.allData.value?[index].name.toString() ??
                              "")),
                ),
              ),
            ),
          ),
          itemCount: controller.allData.value?.length ?? 0,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    print(controller.animName.value?.length);
    return Obx(
      () => ListView.builder(
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: (() {
              controller.animName.value
                  ?.remove(controller.animName.value?[index]);
              controller.animValue.value
                  ?.remove(controller.animValue.value?[index]);
              if (controller.selectedvalue.value ==
                  controller.animValue.value?[index].value.toString()) {
                _solvedDialog();
                controller.animName.value
                    ?.remove(controller.animName.value?[index]);
                controller.animValue.value
                    ?.remove(controller.animValue.value?[index]);
              } else {
                print(controller.animValue.value?[index].value.toString());
              }
            }),
            child: Material(
              color: Colors.blue,
              child: Container(
                height: 50,
                width: double.infinity,
                child: Center(
                    child: Text(
                        controller.animName.value?[index].name.toString() ??
                            "")),
              ),
            ),
          ),
        ),
        itemCount: controller.animName.value?.length ?? 0,
      ),
    );
  }

  void _solvedDialog() {
    Get.defaultDialog(
      title: "",
      content:
          Image.network("https://www.dersnotlarim.net/makale/gift/besdk.gif"),
    );
  }

  void _showInfoDialog() {
    Get.defaultDialog(
        title: alertTitle,
        middleText: eslestirmeText,
        backgroundColor: green,
        middleTextStyle: TextStyle(color: white));
  }
}

 
 */