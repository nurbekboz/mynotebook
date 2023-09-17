import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  PushNotificationService._();

  factory PushNotificationService() => _instance;

  static final PushNotificationService _instance = PushNotificationService._();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 1000), () async {
      if (!_initialized) {
        // For iOS request permission first.
        NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        FirebaseMessaging.instance
            .subscribeToTopic(Platform.isAndroid ? 'android' : 'ios');

        FirebaseMessaging.instance.getAPNSToken().then((value) {
          print('Token: $value');
        });

        FirebaseMessaging.instance.getToken().then((value) {
          print('FCM TOKEN: $value');
        });

        //açıkken
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print('Got a message whilst in the foreground!');
          print('Message data: ${message.data}');

          if (message.notification != null) {
            // DynamicLinkService.handleDeepLink(message.data['link']);

            print(
                'Message also contained a notification: ${message.notification}');
          }
        });

        //Uygulama kapalıyken burdan
        FirebaseMessaging.onMessageOpenedApp.listen((event) {
          print('App open: ${event.data}');
        });

        FirebaseMessaging.instance.onTokenRefresh.listen((event) {
          print('token refresh: $event');
        });

        /*  try {
          String token = await _firebaseMessaging.getToken();
          NetworkManager.instanceshjdfgs.dio.post(
            '/auth/device-token',
            data: {"deviceType": Platform.isIOS ? 'ios' : 'android', "token": "$token"},
          ).then((value) {
            debugPrint('${value.data}');
          });
        } catch (e, s) {
          debugPrint('$e, $s');
        } */

        _initialized = true;
      }
    });
  }

  Future<dynamic> _onMessageHandler(dynamic msg) async {}

  void showSnackBar(String title, String body) {}
}
