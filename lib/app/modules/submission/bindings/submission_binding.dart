import 'package:get/get.dart';

import '../controllers/submission_controller.dart';

class SubmissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmissionController>(
      () => SubmissionController(),
    );
  }
}
