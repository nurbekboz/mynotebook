import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/services/question_anim/AnimQuestion_service.dart';
import 'package:my_note_book/data/services/register/model/register_request_model.dart';
import 'package:my_note_book/data/services/register/model/register_response_model.dart';
import 'package:my_note_book/data/services/register/register_service.dart';

import '../../data/services/question_anim/model/anim_question_response_model.dart';

class QuestionAnimeController extends GetxController {
  final Rx<bool> isLoading = RxBool(false);
  final Rxn<dynamic> error = Rxn<dynamic>();

  final selectedvalue = 0.obs;

  final Rxn<List<AnimQuestionResponseModel>> animName = Rxn();
  final Rxn<List<AnimQuestionResponseModel>> animValue = Rxn();
  final Rxn<List<AnimQuestionResponseModel>> allData = Rxn();
  late Rxn<List<ItemModel>> items;
  late List<AnimQuestionResponseModel> items2;

  final Rxn<List> userNotes = Rxn();

  final AnimQuestionService _animquestionService;

  QuestionAnimeController(this._animquestionService);

  @override
  void onInit() {
    //_callingGetNotesTitle();
    // callingGetNotesDescription();
    //_getAlldata();
    super.onInit();
  }

  void calls() {
    selectedvalue.value = 0;
  }

  void increaseSelectedValue(int index) {
    if ("0" == allData.value?[index].value) {
      selectedvalue.value++;
      allData.value?.remove(allData.value?[index]);
      allData.value?.remove(allData.value?[index]);
    } else {
      print("ÇÇÇÇÇ" + selectedvalue.value.toString());
    }
    // print(allData.value?[index].value.toString());
  }

  // void _callingGetNotesTitle() {
  //   isLoading.call(true);

  //   _animquestionService.getQuestionName().then((not) {
  //     animName.value = not;
  //   }).catchError((dynamic error) {
  //     this.error.trigger(error);
  //     print(error);
  //   }).whenComplete(() {
  //     isLoading.call(false);
  //   });
  // }

  // void callingGetNotesDescription() {
  //   isLoading.call(true);

  //   _animquestionService.getQuestionValue().then((not) {
  //     animValue.value = not;
  //   }).catchError((dynamic error) {
  //     this.error.trigger(error);
  //     print(error);
  //   }).whenComplete(() {
  //     isLoading.call(false);
  //   });
  // }

  // void _getAlldata() {
  //   isLoading.call(true);

  //   _animquestionService.getQuestionName().then((not) {
  //     allData.value = not;

  //     print("ADADAWDAW");
  //   }).catchError((dynamic error) {
  //     this.error.trigger(error);
  //     print(error);
  //   }).whenComplete(() {
  //     isLoading.call(false);
  //   });
  // }
}

class ItemModel {
  final String? name;

  final String? numbervalue;

  bool accepting;

  ItemModel(
      {required this.name, required this.numbervalue, this.accepting = false});
}
