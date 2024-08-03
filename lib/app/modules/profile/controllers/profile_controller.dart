import 'package:get/get.dart';
import 'package:qubah_app/app/controllers/authenticate_controller.dart';
import 'package:qubah_app/app/models/configuration/employee.dart';

class ProfileController extends GetxController {
  Employee? get employee =>
      Get.find<AuthenticateController>().configuration.employee;
}
