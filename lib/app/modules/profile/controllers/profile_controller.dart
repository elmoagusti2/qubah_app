import 'package:get/get.dart';
import 'package:qubah_app/app/controllers/authenticate_controller.dart';
import 'package:qubah_app/app/models/configuration/employee.dart';
import '../../../domain/repositories/api_client.dart';
import '../../widgets/alert.dart';

class ProfileController extends GetxController {
  final apiClient = ApiClient();
  Employee? get employee =>
      Get.find<AuthenticateController>().configuration.employee;
  doChangeLanguage(lang) async {
    final (ResponseStatus status, response) =
        await apiClient.post(url: 'update-language', data: {
      "language_id": lang,
    });
    if (status == ResponseStatus.success) {
      if (response['status']) {
        AppAlert.success(
            context: Get.context!, message: 'Success chane language');
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
