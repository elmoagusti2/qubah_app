import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/domain/repositories/api_client.dart';
import 'package:qubah_app/app/models/configuration/configuration.dart';
import 'package:qubah_app/app/routes/app_pages.dart';
import 'package:qubah_app/main.dart';

class AuthenticateController extends GetxController {
  final box = GetStorage();
  final apiClient = ApiClient();
  late Configuration configuration;
  @override
  void onInit() {
    super.onInit();
    checkAuthenticated();
    changeLanguange();
  }

  checkAuthenticated() async {
    final (ResponseStatus status, res) =
        await apiClient.get(url: 'configuration');
    if (status == ResponseStatus.success) {
      configuration = Configuration.fromJson(res['data']);
      Future.delayed(Duration.zero, () => Get.offAllNamed(Routes.HOME));
    }
    if (status == ResponseStatus.errorResponse) {
      Future.delayed(Duration.zero, () => Get.offAllNamed(Routes.LOGIN));
    }
    if (status == ResponseStatus.error) {
      Future.delayed(Duration.zero, () => Get.offAllNamed(Routes.LOGIN));
    }
    FirebaseMessaging.instance.subscribeToTopic('qubah');
    if (kDebugMode) {
      print(await FirebaseMessaging.instance.getToken());
    }
  }

  changeLanguange() {
    Future.delayed(
      Duration.zero,
      () {
        if (CommonUtil.falsyChecker(box.read('lang'))) {
          MyApp.setLocale(Get.context!, const Locale('en'));
        }
        if (!CommonUtil.falsyChecker(box.read('lang'))) {
          MyApp.setLocale(Get.context!, Locale(box.read('lang')));
        }
      },
    );
  }
}
