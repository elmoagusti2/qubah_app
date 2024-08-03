import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/format_date.dart';
import 'package:qubah_app/app/controllers/authenticate_controller.dart';
import 'package:qubah_app/app/domain/repositories/api_client.dart';
import 'package:qubah_app/app/models/configuration/configuration.dart';
import 'package:qubah_app/app/models/recap_attendance.dart';

class DashboardController extends GetxController {
  final apiClient = ApiClient();
  final appFormatDate = AppFormatDate();
  final datenow = DateTime.now();
  final Configuration configuration =
      Get.find<AuthenticateController>().configuration;
  final clockIn = ''.obs;
  final clockOut = ''.obs;
  final totalHrs = ''.obs;
  final requestRecap = RequestState.empty.obs;
  final recapAttendance = const RecapAttendance(
          absent: '0', late: '0', totalAttendance: '0', totalSubmission: '0')
      .obs;
  @override
  void onInit() async {
    doGetRecap();
    doInit();
    final permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.whileInUse ||
        permission != LocationPermission.always) {
      Geolocator.requestPermission();
    }
    super.onInit();
  }

  doInit() {
    clockIn.value = configuration.attendanceTime?.checkIn ?? '';
    clockOut.value = configuration.attendanceTime?.checkOut ?? '';
    totalHrs.value = configuration.attendanceTime?.totalHours ?? '';
  }

  doGetRecap() async {
    DateTime startOfMonth = DateTime(datenow.year, datenow.month, 1);
    DateTime endOfMonth = DateTime(datenow.year, datenow.month + 1, 0);
    requestRecap.value = RequestState.loading;
    final (ResponseStatus status, res) = await apiClient.get(
        url:
            'recap-attendance?start_date=${appFormatDate.yyyymmdd(startOfMonth)}&end_date=${appFormatDate.yyyymmdd(endOfMonth)}');
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
}
