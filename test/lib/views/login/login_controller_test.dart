// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:my_note_book/data/services/login/login_service.dart';
// import 'package:my_note_book/data/services/login/model/login_response_model.dart';
// import 'package:my_note_book/views/login/login_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../test_observer.dart';

// class MockLoginService extends Mock implements LoginService {}

// class FakeLoginResponseModel extends Fake implements LoginResponseModel {}

// void main() {
//   late LoginController _controller;
//   late LoginService _LoginService;
//   late SharedPreferences? _preferences;

//   setUp(() {
//     _LoginService = MockLoginService();
//     _preferences = SharedPreferences();
//     _controller = LoginController(_LoginService, _preferences);
//   });

//   test('isLoading changes', () {
//     final TestObserver<bool> loadingObserver =
//         _controller.isLoading.testObserver;
//     const String username = 'kadriye';
//     const String password = '123456';

//     when(() => _controller.callingLoginService(username, password))
//         .thenAnswer((invocation) {
//       expect(loadingObserver.history, containsAllInOrder([true, false]));
//     });
//   });

//   test('isLogin should be true', () {
//     const String username = 'kadriye';
//     const String password = '123456';

//     when(() => _controller.callingLoginService(username, password))
//         .thenAnswer((invocation) {
//       expect(_controller.isLogin.value, true);
//     });
//   });

//   test('callingLoginService', () {
//     const String username = 'kadriye';
//     const String password = '123456';

//     when(() => _controller.callingLoginService(username, password))
//         .thenAnswer((invocation) {
//       expect(_controller.user.value, isInstanceOf<LoginResponseModel>());
//     });
//   });
// }
