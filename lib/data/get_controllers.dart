import 'package:get/get.dart';
import 'package:my_note_book/data/services/add_notes/add_notes_service.dart';
import 'package:my_note_book/data/services/home/home_service.dart';
import 'package:my_note_book/data/services/login/login_service.dart';
import 'package:my_note_book/data/services/question/question_service.dart';
import 'package:my_note_book/data/services/question_anim/AnimQuestion_service.dart';
import 'package:my_note_book/data/services/register/register_service.dart';
import 'package:my_note_book/data/services/search/search_service.dart';
import 'package:my_note_book/data/services/update/update_service.dart';
import 'package:my_note_book/views/add_notes/add_notes_controller.dart';
import 'package:my_note_book/views/detail/detail_controller.dart';
import 'package:my_note_book/views/home/home_controller.dart';
import 'package:my_note_book/views/info/info_controller.dart';
import 'package:my_note_book/views/login/login_controller.dart';
import 'package:my_note_book/views/profile/profile_controller.dart';

import 'package:my_note_book/views/register/register_controller.dart';
import 'package:my_note_book/views/search/search_controller.dart';
import 'package:my_note_book/views/splash_screen/splash_controller.dart';

import '../views/question/question_controller.dart';
import '../views/question_anime/questionanim_controller.dart';

Future getControllers() async {
  //Pages
  Get.create(() => LoginController(Get.find(), Get.find()), permanent: false);
  Get.create(() => RegisterController(Get.find()), permanent: false);
  Get.create(() => HomeController(Get.find()), permanent: false);
  Get.create(() => AddNotesController(Get.find()), permanent: false);

  Get.create(() => ProfileController(), permanent: false);
  Get.create(() => SearchControllerr(Get.find()), permanent: false);
  Get.create(() => SplashController(Get.find()), permanent: false);
  Get.create(() => DetailController(Get.find(), Get.find()), permanent: false);
  Get.create(() => QuestionController(Get.find()), permanent: false);
  Get.create(() => QuestionAnimeController(Get.find()), permanent: false);

  //Services
  Get.lazyPut<RegisterService>(() => RegisterServiceImp());
  Get.lazyPut<LoginService>(() => LoginServiceImp());
  Get.lazyPut<AddNotesService>(() => AddNotesServiceImp());
  Get.lazyPut<HomeService>(() => HomeServiceImp());
  Get.lazyPut<SearchService>(() => SearchServiceImp());
  Get.lazyPut<UpdateService>(() => UpdateServiceImp());
  Get.lazyPut<QuestionService>(() => QuestionServiceImp());
  Get.lazyPut<AnimQuestionService>(() => AnimQuestionServiceImp());
}
