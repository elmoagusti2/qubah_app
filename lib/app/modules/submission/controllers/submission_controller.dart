import 'package:get/get.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/format_date.dart';
import 'package:qubah_app/app/controllers/authenticate_controller.dart';
import 'package:qubah_app/app/domain/repositories/api_client.dart';
import 'package:qubah_app/app/models/configuration/employee.dart';
import 'package:qubah_app/app/models/recap_submission/recap_submission.dart';
import 'package:qubah_app/app/models/submission.dart';

class SubmissionController extends GetxController {
  final apiClient = ApiClient();
  final appFormatDate = AppFormatDate();
  Employee? get employee =>
      Get.find<AuthenticateController>().configuration.employee;
  Rx<List<Submission>> listSubmission = Rx<List<Submission>>([]);
  final requestSubmission = RequestState.empty.obs;
  final requestRecap = RequestState.empty.obs;
  final recapSubmission =
      const RecapSubmission(balance: 0, total: 1, used: 0).obs;

  doGetRecap() async {
    requestRecap.value = RequestState.loading;
    final (ResponseStatus status, res) =
        await apiClient.get(url: 'recap-submission');
    if (status == ResponseStatus.success) {
      if (res['status']) {
        recapSubmission.value = RecapSubmission.fromJson(res['data']);
        requestRecap.value = RequestState.success;
        update();
      } else {}
    }
    if (status == ResponseStatus.errorResponse ||
        status == ResponseStatus.error) {
      requestRecap.value = RequestState.error;
    }
  }

  doGetSubmission(DateTime start, DateTime end) async {
    requestSubmission.value = RequestState.loading;
    final (ResponseStatus status, res) = await apiClient.get(
        url:
            'list-submission?start_date=${appFormatDate.yyyymmdd(start)}&end_date=${appFormatDate.yyyymmdd(end)}');
    if (status == ResponseStatus.success) {
      listSubmission.value = !CommonUtil.falsyChecker(res['data'])
          ? (res['data'] as List<dynamic>)
              .map((e) => Submission.fromJson(e))
              .toList()
          : [];
      requestSubmission.value = RequestState.success;
    }
    if (status == ResponseStatus.errorResponse ||
        status == ResponseStatus.error) {
      requestSubmission.value = RequestState.error;
    }
  }
}
