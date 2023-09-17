import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/services/question/model/answer_model.dart';

import 'package:my_note_book/data/services/question/question_service.dart';

import '../../data/get_controllers.dart';
import '../../data/services/update/model/update_request_model.dart';
import '../../data/services/update/model/update_request_model2.dart';
import '../../data/services/update/update_service.dart';

class QuestionController extends GetxController {
  final userdata = GetStorage();

  final Rx<bool> isLoading = RxBool(false);
  final Rxn<dynamic> error = Rxn<dynamic>();

  final Rxn<List> questionAnwser = Rxn();
  final Rxn<List> questionDescription = Rxn();
  final Rxn<String> questionDescriptionDetail = Rxn();
  final Rxn<List> questionDate = Rxn();

  final userquestion = <String>["", "", "", "", "", "", "", "", "", ""];

  final QuestionService _questionService;

  Color selectedColor = Colors.black;

  final sorusayisi = 0.obs;
  final Rxn<Icon> scoreTracker = Rxn();
  final selectedIndex = 0.obs;
  final questionIndex = 0.obs;
  final totalScore = 1.obs;
  final Rx<bool> answerWasSelected = RxBool(false);
  final Rx<bool> endOfQuiz = RxBool(false);
  final Rx<bool> correctAnswerSelected = RxBool(false);

  QuestionController(this._questionService);
  @override
  void onInit() {
    userdata.writeIfNull('solved', 0);
    _callingGetquestionAnswer();
    callingGetquestionDescription();
    calll();
    super.onInit();
  }

  Future<void> calll() async {
    await getControllers();
  }

  void questionAnswered(String answerScore) {
    // answer was selected
    userquestion[questionIndex.value] = answerScore;
    print(userquestion[questionIndex.value].toString() + "ÖÖÖÖÖ");
    answerWasSelected.call(true);
    // check if answer was correct

    //when the quiz ends
    if (questionIndex.value + 1 == questionDescription.value?.length) {
      endOfQuiz.call(true);
    }
  }

  void _callingGetquestionAnswer() {
    isLoading.call(true);

    _questionService.getQuestionAnswer().then((not) {
      questionAnwser.value = not;
    }).catchError((dynamic error) {
      this.error.trigger(error);
      print(error);
    }).whenComplete(() {
      isLoading.call(false);
    });
  }

  void callingGetquestionDescription() {
    isLoading.call(true);

    _questionService.getQuestionDescription().then((not) {
      questionDescription.value = not;
    }).catchError((dynamic error) {
      this.error.trigger(error);
      print(error);
    }).whenComplete(() {
      isLoading.call(false);
    });
  }

  void callingUpdateUserAnswerService() {
    AnwserModel ansModel = new AnwserModel(
        userquestion[0],
        userquestion[1],
        userquestion[2],
        userquestion[3],
        userquestion[4],
        userquestion[5],
        userquestion[6],
        userquestion[7],
        userquestion[8],
        userquestion[9]);
    // encode / convert object into json string
    String user = jsonEncode(ansModel);
    userdata.write("solved", "1");

    final UpdateRequestModel2 requestModel = UpdateRequestModel2(
        userId: userdata.read('userId'),
        solved: userdata.read("solved"),
        questionanswer: user);
    print("LOOKA" + requestModel.toString());
    _questionService.updateQuestionAnswer(requestModel).then((user) {
      print("ANSWERRUUUU" + user);
    }).catchError((dynamic error) {
      this.error.trigger(error);
    }).whenComplete(() {
      isLoading.call(true);
    });
  }
}
