import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note_book/data/src/colors.dart';
import 'package:my_note_book/data/src/strings.dart';

import 'package:my_note_book/views/question/question_controller.dart';

import '../common/answer.dart';
import '../home/home_page.dart';

class QuestionPage extends GetWidget<QuestionController> {
  const QuestionPage({Key? key}) : super(key: key);

  static const String routeName = '/views/Question/Question_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(questionAppBarText),
          backgroundColor: mainColor,
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 12.0, right: 0, bottom: 8),
                    child: Text(
                      '${controller.totalScore..toString()}/${controller.questionDescription.value?.length}',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: Material(
                      color: Colors.white,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Image.network(
                                controller.questionDescription.value?[
                                        controller.questionIndex.value] ??
                                    "https://cdn.searchenginejournal.com/wp-content/uploads/2022/06/image-search-1600-x-840-px-62c6dc4ff1eee-sej-1520x800.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Answer(
                          answerText: "A",
                          answerColor: controller.answerWasSelected.value
                              ? controller.selectedIndex.value == 1
                                  ? Colors.green.shade400
                                  : Colors.white
                              : Colors.white,
                          answerTap: () {
                            controller.selectedIndex.value = 1;
                            print("CEVAPP" +
                                controller.answerWasSelected.value.toString() +
                                controller.selectedIndex.value.toString() +
                                controller.questionIndex.value.toString() +
                                controller.questionAnwser
                                    .value?[controller.questionIndex.value]);
                            controller.questionAnswered("A");
                            // if answer was already selected then nothing happens onTap

                            //answer is being selected
                          },
                        ),
                      ),
                      Expanded(
                        child: Answer(
                          answerText: "B",
                          answerColor: controller.answerWasSelected.value
                              ? controller.selectedIndex.value == 2
                                  ? Colors.green.shade400
                                  : Colors.white
                              : Colors.white,
                          answerTap: () {
                            controller.selectedIndex.value = 2;

                            print("CEVAPP" +
                                controller.selectedIndex.value.toString() +
                                controller.questionIndex.value.toString() +
                                controller.questionAnwser
                                    .value?[controller.questionIndex.value]);
                            controller.questionAnswered("B");
                            // if answer was already selected then nothing happens onTap
                          },
                        ),
                      ),
                      Expanded(
                        child: Answer(
                          answerText: "C",
                          answerColor: controller.answerWasSelected.value
                              ? controller.selectedIndex.value == 3
                                  ? Colors.green.shade400
                                  : Colors.white
                              : Colors.white,
                          answerTap: () {
                            controller.selectedIndex.value = 3;
                            // if answer was already selected then nothing happens onTap

                            print("CEVAPP" +
                                controller.selectedIndex.value.toString() +
                                controller.questionIndex.value.toString() +
                                controller.questionAnwser
                                    .value?[controller.questionIndex.value]);
                            controller.questionAnswered("C");
                            //answer is being selected
                          },
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 4,
                                  primary: Color(0xfff23734e),
                                  onPrimary: Colors.white,
                                  minimumSize: Size(double.infinity, 50.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24))),
                              onPressed: () {
                                //Lütfen bir sonraki soruya geçmeden önce bir cevap seçin
                                if (!controller.answerWasSelected.value) {
                                  Get.snackbar(
                                    errorTitle,
                                    nextQuestionError,
                                    colorText: white,
                                    backgroundColor: red,
                                  );

                                  return;
                                }
                                controller.totalScore.value++;
                                controller.questionIndex.value++;
                                controller.answerWasSelected.value = false;
                                controller.correctAnswerSelected.value = false;

                                // what happens at the end of the quiz
                                if (controller.questionIndex.value >=
                                    controller
                                        .questionDescription.value!.length) {
                                  controller.callingUpdateUserAnswerService();
                                  _ALertFinDialog();
                                  controller.questionIndex.value = 0;
                                  controller.totalScore.value = 0;
                                  controller.scoreTracker.value = null;
                                  controller.endOfQuiz.value = false;
                                }
                              },
                              child: Text(
                                controller.endOfQuiz.value
                                    ? 'Testi Bitir!'
                                    : 'Sonraki Soru',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.answerWasSelected.value &&
                      !controller.endOfQuiz.value)
                    Container(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/dersicon/error.png",
          height: 36,
          width: 36,
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          "Lütfen internet bağlantınızı kontrol edin!",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ],
    ));
  }

  void _ALertFinDialog() {
    Get.defaultDialog(
      title: alertTitle,
      middleText: succesText,
      backgroundColor: green,
      middleTextStyle: TextStyle(color: white),
      textConfirm: "Ana menüye dön!",
      cancelTextColor: Colors.white,
      confirmTextColor: Colors.white,
      barrierDismissible: false,
      onConfirm: () {
        Get.back();
        Get.offAndToNamed(HomePage.routeName);
      },
    );
  }
}
