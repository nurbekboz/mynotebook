import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/strings.dart';
import 'package:my_note_book/views/home/home_page.dart';
import 'package:my_note_book/views/question_anime/questionanim_controller.dart';

import '../../data/services/question_anim/AnimQuestion_service.dart';
import '../../data/services/question_anim/model/anim_answer_model.dart';
import '../../data/services/question_anim/model/anim_question_response_model.dart';
import '../../data/services/update/model/anim_update_model.dart';
import '../../data/services/update/model/update_response_model.dart';

class QuestionAnimePage extends StatefulWidget {
  @override
  _QuestionAnimePageState createState() => _QuestionAnimePageState();
}

class _QuestionAnimePageState extends State<QuestionAnimePage> {
  late int firstlenght;
  late int selectedvalue;
  late bool gameOver;
  bool _isLoading = false;
  late final AnimQuestionService postService;
  late List<AnimQuestionResponseModel>? items;
  late List<AnimQuestionResponseModel>? items2;
  List<AnimQuestionResponseModel> trueitems = [];
  List<AnimQuestionResponseModel> falseitems = [];
  late String isSucces;
  final userdata = GetStorage();
  final userquestion = <String>[
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  @override
  void initState() {
    super.initState();
    initGame();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchUser() async {
    _changeLoading();

    items = await postService.fetchKonularModel();
    items2 = await postService.fetchKonularModel();
    print("POPOOP" + items.toString());
    firstlenght = items?.length ?? 0;
    _uyariDialog();
    _changeLoading();
  }

  initGame() {
    postService = AnimQuestionServiceImp();
    gameOver = false;
    firstlenght = 0;
    selectedvalue = 0;
    isSucces = "başarısız";
    userdata.writeIfNull('animsolvecount', 0);
    userdata.writeIfNull('animsolvecounttrue', 0);
    fetchUser();
  }

  void _setSelectedValue() {
    setState(() {
      selectedvalue++;
    });
  }

  void questionAnswered(String? answerScore) {
    // answer was selected
    userquestion[selectedvalue] = answerScore ?? "";
    print(userquestion[selectedvalue].toString() + "ÖÖÖÖÖ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(machText),
          backgroundColor: mainColor,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildbody());
  }

  Widget _buildbody() {
    if (gameOver) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.amber,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Aşağıda verilen adımlar için doğru tercih yaptınız.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: trueitems.map((item) {
                    return Column(
                      children: [
                        Material(
                          elevation: 8,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.green,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Center(
                                child: Text(item.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }).toList()),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.amber,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Aşağıda verilen adımlar için yanlış tercih yaptınız ve sağlıksız bir ilaç hazırladınız. Lütfen daha dikkatli olunuz",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: falseitems.map((item) {
                    return Column(
                      children: [
                        Material(
                          elevation: 8,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.red,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: Center(
                                child: Text(item.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }).toList()),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  gameOver = false;
                  fetchUser();
                  falseitems = [];
                  trueitems = [];
                  selectedvalue = 0;

                  print(selectedvalue.toString() + items2.toString());
                  setState(() {});
                },
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.blue,
                  elevation: 2,
                  child: Container(
                      height: 50,
                      width: 200,
                      child: Center(
                          child: Text("Tekar Çöz",
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: items!.map((item) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: (() {
                        _solvedDialog(item.gif);
                        questionAnswered(item.name);
                        print("select" + selectedvalue.toString());
                        print(item.value.toString());
                        if (int.parse(selectedvalue.toString()) ==
                            int.parse(item.value)) {
                          trueitems.add(item);
                          items?.remove(item);
                          _setSelectedValue();
                        } else {
                          falseitems.add(item);
                          print(item.name);
                          items?.remove(item);
                          _setSelectedValue();
                        }

                        setState(() {});
                      }),
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.blue,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              item.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                          ),
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
      );
    }
  }

  void _solvedDialog(String? giflink) {
    Get.defaultDialog(
      backgroundColor: Colors.transparent,
      barrierDismissible: false,
      title: "",
      confirm: GestureDetector(
          onTap: (() {
            Get.back();
            if (selectedvalue == firstlenght) {
              if (falseitems.isEmpty) {
                isSucces = "başarılı";
                _trueDialog();
              } else {
                gameOver = true;
              }
              setLoginCount();

              setState(() {});
            }
          }),
          child: Container(
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            height: 50,
            width: 200,
            child: Center(
                child: Text(
              "Tamam",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          )),
      content: Image.network(
          giflink ?? "https://www.dersnotlarim.net/makale/gift/besdk.gif"),
    );
  }

  void _uyariDialog() {
    Get.defaultDialog(
      title: alertTitle,
      backgroundColor: green,
      barrierDismissible: false,
      textConfirm: "Başla",
      onConfirm: () {
        Get.back();
      },
      buttonColor: Colors.blue,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            "Anneler süspansiyon ilaç hazırlama basamaklarını işlem sırasına göre sıralayınız.\n Lütfen dikkatli olunuz !!!"),
      ),
    );
  }

  void _trueDialog() {
    Get.defaultDialog(
      title: alertTitle,
      backgroundColor: green,
      barrierDismissible: false,
      textConfirm: "Tamam",
      onConfirm: () {
        Get.back();
      },
      buttonColor: Colors.blue,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            "Tüm adımları doğru yaparak ilacı hazırladınız. Tebrik ederiz"),
      ),
    );
  }

  void _showInfoDialog() {
    Get.defaultDialog(
        title: alertTitle,
        middleText: eslestirmeText,
        backgroundColor: green,
        middleTextStyle: TextStyle(color: white));
  }

  void callingUpdateUserAnswerService() {
    AnimAnwserModel ansModel = new AnimAnwserModel(
        userquestion[0],
        userquestion[1],
        userquestion[2],
        userquestion[3],
        userquestion[4],
        userquestion[5],
        userquestion[6],
        userquestion[7],
        userquestion[8],
        userquestion[9],
        userquestion[10],
        userquestion[11],
        userquestion[12],
        isSucces);
    // encode / convert object into json string
    String user = jsonEncode(ansModel);

    final AnimUpdateRequestModel requestModel = AnimUpdateRequestModel(
        userId: userdata.read('userId'),
        questionanswer: user,
        animsolvecount: userdata.read('animsolvecount').toString(),
        animsolvecounttrue: userdata.read('animsolvecounttrue').toString());
    print("LOOKA" + requestModel.toString());

    postService
        .updateQuestionAnswer(requestModel)
        .then((user) {
          print("ANSWERRUUUU" + user);
        })
        .catchError((dynamic error) {})
        .whenComplete(() {});
  }

  setLoginCount() async {
    var data = await userdata.read('animsolvecount');
    var datat = await userdata.read('animsolvecounttrue');

    int aa = int.parse(data.toString());
    int bb = int.parse(datat.toString());
    if (falseitems.isEmpty) {
      bb += 1;
    } else {
      aa += 1;
    }

    print("ğğğğ" + data.toString() + "dad" + datat.toString());
    userdata.write('animsolvecount', aa).toString();
    userdata.write('animsolvecounttrue', bb).toString();

    callingUpdateUserAnswerService();
  }
}
