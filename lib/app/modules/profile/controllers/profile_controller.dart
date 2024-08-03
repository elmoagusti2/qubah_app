import 'package:get/get.dart';
import 'package:qubah_app/app/controllers/authenticate_controller.dart';
import 'package:qubah_app/app/models/configuration/employee.dart';

import '../../../common/common_utils.dart';
import '../../../domain/repositories/api_client.dart';
import '../../widgets/alert.dart';

class ProfileController extends GetxController {
  final apiClient = ApiClient();
  Employee? get employee =>
      Get.find<AuthenticateController>().configuration.employee;
  doChangeLanguage(lang) async {
    final (ResponseStatus status, response) =
        await apiClient.post(url: 'language', data: {
      "lang": lang,
    });
    if (status == ResponseStatus.success) {
      if (response['status'] && !CommonUtil.falsyChecker(response['data'])) {
        AppAlert.success(
            context: Get.context!, message: 'Success change language');
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
  }
}
