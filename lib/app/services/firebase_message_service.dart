import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/services/notification_service.dart';

class FirebaseMessageService extends GetxService {
  Future<FirebaseMessageService> init() async {
    getPermission();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((message) async {
      if (kDebugMode) {
        print(message.data);
      }
      LocalNotificationService.display(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {});
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackground);
    return this;
  }

  Future getPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackground(RemoteMessage message) async {
  await Firebase.initializeApp();
  LocalNotificationService.display(message);
}
