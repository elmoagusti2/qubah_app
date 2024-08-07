import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/controllers/authenticate_controller.dart';
import 'package:qubah_app/app/domain/repositories/api_client.dart';
import 'package:qubah_app/app/modules/widgets/alert.dart';

class LoginController extends GetxController {
  final apiClient = ApiClient();
  final box = GetStorage();
  final TextEditingController name = TextEditingController();
  final TextEditingController passowrd = TextEditingController();
  final auth = Get.find<AuthenticateController>();
  final requestLogin = RequestState.empty.obs;

  doLogin() async {
    requestLogin.value = RequestState.loading;
    try {
      final token = await FirebaseMessaging.instance.getToken();
      final (ResponseStatus status, response) = await apiClient.post(
          url: 'login',
          data: {
            "username": name.text,
            "password": passowrd.text,
            "token": token
          });
      if (status == ResponseStatus.success) {
        if (response['status'] && !CommonUtil.falsyChecker(response['data'])) {
          box.write('user', response['data']);
          await box.read('user');
          box.write('token', response['data']['token']);
          // Future.delayed(Duration.zero, () => Get.offAllNamed(Routes.HOME));
          await auth.checkAuthenticated();
          AppAlert.success(context: Get.context!, message: 'Success Login');
        } else {
          AppAlert.error(
              context: Get.context!,
              message: response['message'] ?? 'Error occurred');
        }
      }
      if (status == ResponseStatus.errorResponse) {
        AppAlert.error(
            context: Get.context!,
            message: response['message'] ?? 'Error occurred');
      }
      if (status == ResponseStatus.error) {
        AppAlert.error(
            context: Get.context!,
            message: response['message'] ?? 'Error occurred');
      }
    } catch (e) {
      AppAlert.error(context: Get.context!, message: '$e');
    }
    requestLogin.value = RequestState.success;
  }
}
