import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qubah_app/app/common/common_utils.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @pragma('vm:entry-point')
  static void initialize() async {
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
    );
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _notificationsPlugin.getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    if (didNotificationLaunchApp) {
      Future.delayed(const Duration(milliseconds: 1500), () {});
    } else {
      _notificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (NotificationResponse payload) {
        Future.delayed(const Duration(milliseconds: 1500), () {});
      }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    }
  }

  @pragma('vm:entry-point')
  static void display(RemoteMessage message) async {
    if (!CommonUtil.falsyChecker(message.data['imageUrl'])) {
      final id = Random().nextInt(99);
      Response response = await Dio().get('${message.data['imageUrl']}',
          options: Options(responseType: ResponseType.bytes));

      BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(response.data)));
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "default_notification_channel_id", "channelName",
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation),
      );
      await _notificationsPlugin.show(
          id, message.data['title'], message.data['body'], notificationDetails,
          payload: message.data['route']);
    } else {
      const id = 1;
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "default_notification_channel_id",
          "channelName",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );
      await _notificationsPlugin.show(
          id, message.data['title'], message.data['body'], notificationDetails,
          payload: message.data['route']);
    }
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse payload) async {}
