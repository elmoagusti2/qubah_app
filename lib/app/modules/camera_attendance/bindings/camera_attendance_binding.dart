import 'package:get/get.dart';

import '../controllers/camera_attendance_controller.dart';

class CameraAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraAttendanceController>(
      () => CameraAttendanceController(),
    );
  }
}
