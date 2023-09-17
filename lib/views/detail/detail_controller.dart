import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_note_book/data/services/home/home_service.dart';
import 'package:my_note_book/views/home/home_controller.dart';

class DetailController extends GetxController {
  final Rx<bool> isLoading = RxBool(false);
  final Rxn<dynamic> error = Rxn<dynamic>();

  final aa = 0.obs;
  final Rxn<List> notesTitle = Rxn();
  final Rxn<List> notesDescription = Rxn();
  final Rxn<String> notesDescriptionDetail = Rxn();
  final Rxn<List> notesDate = Rxn();

  final Rxn<List> userNotes = Rxn();
  final HomeController homecontroller;
  final HomeService _homeService;

  DetailController(this._homeService, this.homecontroller);

  @override
  void onInit() {
    _callingGetNotesTitle();
    print(homecontroller.indexs.value);
    callingGetNotesDescription(homecontroller.indexs.value);
    _callingGetNotesDate();

    // _callingGetUserNotesTitle();
    // _callingGetUserNotesDescription();
    //_callingGetUserNotesDate();

    super.onInit();
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

  void setIndexs(int index) async {
    aa.value = index;

    // print("XXXXX" + aa.value.toString());
  }

  void callingGetNotesDescription(int? index) {
    isLoading.call(true);

    _homeService.getNotesDescription().then((not) {
      notesDescription.value = not;

      notesDescriptionDetail.value = notesDescription.value?[index ?? 11];

      print(notesDescription.value?[index ?? 11]);
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

  //user notes
  void _callingGetUserNotesTitle() {
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

  void _callingGetUserNotesDescription() {
    isLoading.call(true);

    _homeService.getNotesDescription().then((not) {
      notesDescription.value = not;
    }).catchError((dynamic error) {
      this.error.trigger(error);
      print(error);
    }).whenComplete(() {
      isLoading.call(false);
    });
  }

  void _callingGetUserNotesDate() {
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
