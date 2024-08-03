import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/format_date.dart';
import 'package:qubah_app/app/domain/repositories/api_client.dart';
import 'package:qubah_app/app/models/submission_type.dart';
import 'package:qubah_app/app/modules/widgets/alert.dart';
import 'package:dio/dio.dart' as d;

class SubmissionFormController extends GetxController {
  final apiClient = ApiClient();
  final appFormatDate = AppFormatDate();

  Rx<List<SubmissionType>> listSubmission = Rx<List<SubmissionType>>([]);
  final requestSSubmission = RequestState.empty.obs;
  final TextEditingController note = TextEditingController();
  final code = ''.obs;
  final selectedPeriod = DatePeriod(
          DateTime.now().subtract(const Duration(days: 0)), DateTime.now())
      .obs;
  final startDate = DateTime.now().subtract(const Duration(days: 3450));
  final endDate = DateTime.now().add(const Duration(days: 345));
  final filePick = File('').obs;
  final isDocument = '0'.obs;
  @override
  void onInit() {
    doGetSubmissionType();
    super.onInit();
  }

  void onSelectedDateChanged(DatePeriod newPeriod) {
    selectedPeriod.value = newPeriod;
  }

  doPickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      filePick.value = file;
    } else {
      // User canceled the picker
    }
  }

  doGetSubmissionType() async {
    final (ResponseStatus status, res) =
        await apiClient.get(url: 'submission-type');
    if (status == ResponseStatus.success) {
      listSubmission.value = !CommonUtil.falsyChecker(res['data'])
          ? (res['data'] as List<dynamic>)
              .map((e) => SubmissionType.fromJson(e))
              .toList()
          : [];
    }
    if (status == ResponseStatus.errorResponse ||
        status == ResponseStatus.error) {}
  }

  doPostSubmission() async {
    requestSSubmission.value = RequestState.loading;
    if (!CommonUtil.falsyChecker(code.value) &&
        !CommonUtil.falsyChecker(note.text)) {
      d.FormData formData = d.FormData.fromMap({
        if (!CommonUtil.falsyChecker(filePick.value.path))
          "picture": await d.MultipartFile.fromFile(filePick.value.path),
        "submission_type_id": code.value,
        "start_date": appFormatDate.yyyymmdd(selectedPeriod.value.start),
        "end_date": appFormatDate.yyyymmdd(selectedPeriod.value.end),
        "description": note.text
      });
      final (ResponseStatus status, res) =
          await apiClient.post(url: 'submission', data: formData);
      if (status == ResponseStatus.success) {
        if (res['status']) {
          Get.back();
          AppAlert.success(context: Get.context!, message: res['message']);
        } else {
          AppAlert.error(context: Get.context!, message: res['message']);
        }
        requestSSubmission.value = RequestState.success;
      }
      if (status == ResponseStatus.errorResponse ||
          status == ResponseStatus.error) {
        AppAlert.error(
            context: Get.context!, message: res['message'] ?? '$res');
        requestSSubmission.value = RequestState.error;
      }
    } else {
      AppAlert.error(context: Get.context!, message: 'Please fill form');
      requestSSubmission.value = RequestState.error;
    }
  }
}
