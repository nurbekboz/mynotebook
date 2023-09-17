import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_note_book/data/get_controllers.dart';
import 'package:my_note_book/data/routing/get_pages.dart';
import 'package:my_note_book/views/splash_screen/splash_page.dart';

import 'locator.dart';

Future main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setupLocator();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<void> main() async {
    await getControllers();
  }

  @override
  Widget build(BuildContext context) {
    main();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      home: SplashPage(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}
