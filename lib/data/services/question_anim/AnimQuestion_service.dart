import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:my_note_book/views/common/common_values.dart';

import '../update/model/anim_update_model.dart';
import '../update/model/update_response_model.dart';
import 'model/anim_question_response_model.dart';

abstract class AnimQuestionService {
//user notes
  // Future getUserNotesTitle();
  // Future getUserNotesDescription();
  // Future getUserNotesDate();
  Future<List<AnimQuestionResponseModel>?> fetchKonularModel();
  Future updateQuestionAnswer(AnimUpdateRequestModel registerRequestModel);
}

class AnimQuestionServiceImp extends AnimQuestionService {
  @override
  // Future getQuestionName() async {
  //   const String _baseUrl =
  //       'https://www.dersnotlarim.net/makale/get_anim_questions.php';

  //   var _url = Uri.parse(_baseUrl);

  //   final response = await http.get(_url);

  //   var noteListTitle = [];
  //   print(animQuestionResponseModelFromJson(response.body));
  //   if (response.statusCode == 200) {
  //     var data = animQuestionResponseModelFromJson(response.body);
  //     for (int i = 0; i < data.length; i++) {
  //       noteListTitle.add(data[i].name);
  //     }
  //     return noteListTitle;
  //   } else {
  //     return '';
  //   }
  // }

  // @override
  // Future getQuestionValue() async {
  //   const String _baseUrl =
  //       'https://www.dersnotlarim.net/makale/get_anim_questions.php';

  //   var _url = Uri.parse(_baseUrl);

  //   final response = await http.get(_url);

  //   var noteListDescription = [];

  //   if (response.statusCode == 200) {
  //     var data = animQuestionResponseModelFromJson(response.body);
  //     for (int i = 0; i < data.length; i++) {
  //       noteListDescription.add(data[i].value);
  //     }
  //     return noteListDescription;
  //   } else {
  //     return '';
  //   }
  // }

  // @override
  // getAllData() async {
  //   const String _baseUrl =
  //       'https://www.dersnotlarim.net/makale/get_anim_questions.php';

  //   var _url = Uri.parse(_baseUrl);

  //   final response = await http.get(_url);
  //   late List<AnimQuestionResponseModel> items2;
  //   var noteListDescription = [];
  //   List<AnimQuestionResponseModel> items = [];
  //   if (response.statusCode == 200) {
  //     var data = animQuestionResponseModelFromJson(response.body);
  //     for (int i = 0; i < data.length; i++) {
  //       items.add(data[i]);
  //       noteListDescription.add(data[i]);
  //     }

  //     ;

  //     items2 = List<AnimQuestionResponseModel>.from(items);
  //     print("MMMMS" + items2.toString());
  //     items.shuffle();
  //     return items;
  //   } else {
  //     return '';
  //   }
  // }

  Future<List<AnimQuestionResponseModel>?> fetchKonularModel() async {
    //   try {
    //     final res = await http.get(Uri.parse(
    //         "https://www.dersnotlarim.net/makale/get_anim_questions.php"));

    //     if (res.statusCode == 200) {
    //       List<dynamic> body = jsonDecode(res.body);

    //       List<AnimQuestionResponseModel> posts = body
    //           .map<AnimQuestionResponseModel>(
    //             (item) => AnimQuestionResponseModel.fromJson((item)),
    //           )
    //           .toList();
    //       print("ÖÖÖ" + posts.toString());
    //       return posts;
    //     } else {
    //       throw "Unable to retrieve posts.";
    //     }
    //   } catch (exception) {
    //     _ShowDebug.showDioError();
    //   }
    //   return null;
    // }

    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/get_anim_questions.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.get(_url);
    late List<AnimQuestionResponseModel> items2;
    var noteListDescription = [];
    List<AnimQuestionResponseModel> items = [];
    if (response.statusCode == 200) {
      var data = animQuestionResponseModelFromJson(response.body);
      for (int i = 0; i < data.length; i++) {
        items.add(data[i]);
        noteListDescription.add(data[i]);
      }

      ;

      items2 = List<AnimQuestionResponseModel>.from(items);
      print("MMMMS" + items2.toString());
      items.shuffle();
      return items;
    }
  }

  Future updateQuestionAnswer(AnimUpdateRequestModel updateRequestModel) async {
    print("SUUSSSUU" + updateRequestModel.toJson().toString());
    const String _baseUrl =
        'https://www.dersnotlarim.net/makale/update_user_anim_answer.php';

    var _url = Uri.parse(_baseUrl);

    final response = await http.post(_url, body: updateRequestModel.toJson());

    if (response.statusCode == 200) {
      String a = updateResponseModelFromJson(response.body).message ?? "";
      print("XXXX" + a.toString());
      return updateResponseModelFromJson(response.body);
    } else {
      print("XXXX");
      return 'dadwa';
    }
  }
}

class _ShowDebug {
  static void showDioError<T>() {}
}
