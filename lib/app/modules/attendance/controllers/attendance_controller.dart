import 'package:get/get.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/format_date.dart';
import 'package:qubah_app/app/domain/repositories/api_client.dart';
import 'package:qubah_app/app/models/attendance.dart';
import 'package:qubah_app/app/models/recap_attendance.dart';

class AttendanceController extends GetxController {
  final apiClient = ApiClient();
  final appFormatDate = AppFormatDate();
  final datenow = DateTime.now();

  Rx<List<Attendance>> listAttendance = Rx<List<Attendance>>([]);
  final requestSSubmission = RequestState.empty.obs;
  final requestRecap = RequestState.empty.obs;
  final recapAttendance = const RecapAttendance(
          absent: '0', late: '0', totalAttendance: '0', totalSubmission: '0')
      .obs;

  doGetRecap(start, end) async {
    requestRecap.value = RequestState.loading;
    final (ResponseStatus status, res) = await apiClient.get(
        url:
            'recap-attendance?start_date=${appFormatDate.yyyymmdd(start)}&end_date=${appFormatDate.yyyymmdd(end)}');
    if (status == ResponseStatus.success) {
      if (res['status']) {
        recapAttendance.value = RecapAttendance.fromJson(res['data']);
        requestRecap.value = RequestState.success;
        update();
      } else {}
    }
    if (status == ResponseStatus.errorResponse ||
        status == ResponseStatus.error) {
      requestRecap.value = RequestState.error;
    }
  }

  doGetAttendance(DateTime start, DateTime end) async {
    requestSSubmission.value = RequestState.loading;
    final (ResponseStatus status, res) = await apiClient.get(
        url:
            'attendance-time-date?start_date=${appFormatDate.yyyymmdd(start)}&end_date=${appFormatDate.yyyymmdd(end)}');
    if (status == ResponseStatus.success) {
      listAttendance.value = !CommonUtil.falsyChecker(res['data'])
          ? (res['data'] as List<dynamic>)
              .map((e) => Attendance.fromJson(e))
              .toList()
          : [];
      requestSSubmission.value = RequestState.success;
    }
    if (status == ResponseStatus.errorResponse ||
        status == ResponseStatus.error) {
      requestSSubmission.value = RequestState.error;
    }
  }
}
