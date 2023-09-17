import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_note_book/data/services/home/home_service.dart';

import '../../data/get_controllers.dart';

class HomeController extends GetxController {
  final Rx<bool> isLoading = RxBool(false);
  final Rxn<dynamic> error = Rxn<dynamic>();

  final indexs = 11.obs;
  final data = "".obs;
  final Rxn<List> notesTitle = Rxn();
  final Rxn<List> notesDescription = Rxn();
  final Rxn<String> notesDescriptionDetail = Rxn();
  final Rxn<List> notesDate = Rxn();

  final Rxn<List> userNotes = Rxn();

  final HomeService _homeService;

  HomeController(this._homeService);

  @override
  void onInit() {
    print("dadawdad");
    _callingGetNotesTitle();
    //   _callingGetNotesDescription(1);
    _callingGetNotesDate();

    // _callingGetUserNotesTitle();
    // _callingGetUserNotesDescription();
    //_callingGetUserNotesDate();
    calll();
    super.onInit();
  }

  Future<void> calll() async {
    await getControllers();
  }

  void setIndexs(int index) async {
    indexs.value = index;
    callingGetNotesDescription(aa: index);
  }

  void _callingGetNotesTitle() {
    isLoading.call(true);

    _homeService.getNotesTitle().then((not) {
      notesTitle.value = not;
    }).catchError((dynamic error) {
      this.error.trigger(error);
      print(error);
    }).whenComplete(() {
      isLoading.call(false);
    });
  }

  void callingGetNotesDescription({int? aa}) {
    isLoading.call(true);

    _homeService.getNotesDescription().then((not) {
      notesDescription.value = not;
      notesDescriptionDetail.value = notesDescription.value?[aa ?? 0];
    }).catchError((dynamic error) {
      this.error.trigger(error);
      print(error);
    }).whenComplete(() {
      isLoading.call(false);
    });
  }

  void _callingGetNotesDate() {
    isLoading.call(true);

    _homeService.getNotesDate().then((not) {
      notesDate.value = not;
    }).catchError((dynamic error) {
      this.error.trigger(error);
      print(error);
    }).whenComplete(() {
      isLoading.call(false);
    });
  }
}
