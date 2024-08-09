import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qubah_app/app/common/app_colors.dart';
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
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  @override
  void onInit() {
    doGetSubmissionType();
    super.onInit();
  }

  void onSelectedDateChanged(DatePeriod newPeriod) {
    selectedPeriod.value = newPeriod;
  }

  doPickDocument(isImage) async {
    if (isImage) {
      final XFile? result =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (result != null) {
        File file = File(result.path);
        filePick.value = file;
      } else {}
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        filePick.value = file;
      } else {}
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
        if (startTime.text.isNotEmpty) "start_time": startTime.text,
        if (endTime.text.isNotEmpty) "end_time": endTime.text,
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

  chooseTime(int status) async {
    final TimeOfDay? pick = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now().replacing(minute: 0),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.main,
                  onSurface: Colors.black,
                ),
                timePickerTheme:
                    const TimePickerThemeData(backgroundColor: Colors.white)),
            child: child!,
          ),
        );
      },
    );
    if (!CommonUtil.falsyChecker(pick)) {
      status == 0
          ? startTime.text =
              '${pick?.hour}:${pick?.minute.toString().padLeft(2, '0')}:00'
          : endTime.text =
              '${pick?.hour}:${pick?.minute.toString().padLeft(2, '0')}:00';
    }
  }
}
