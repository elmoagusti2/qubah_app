import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/format_date.dart';
import 'package:qubah_app/app/domain/repositories/api_client.dart';
import 'package:qubah_app/app/models/approval.dart';
import 'package:qubah_app/app/modules/widgets/alert.dart';
import 'package:qubah_app/app/modules/widgets/dialogs.dart';

class ApprovalController extends GetxController {
  final apiClient = ApiClient();
  final appFormatDate = AppFormatDate();

  Rx<Map<String, List<Approval>>> listApproval =
      Rx<Map<String, List<Approval>>>({});
  Rx<List<Approval>> hiddenList = Rx<List<Approval>>([]);
  final TextEditingController description = TextEditingController();
  final requestApproval = RequestState.empty.obs;
  @override
  void onInit() {
    doGetApproval();
    super.onInit();
  }

  doGetApproval() async {
    requestApproval.value = RequestState.loading;
    final (ResponseStatus status, res) =
        await apiClient.get(url: 'list-submission-approved');
    if (status == ResponseStatus.success) {
      final List<Approval> list = !CommonUtil.falsyChecker(res['data'])
          ? (res['data'] as List<dynamic>)
              .map((e) => Approval.fromJson(e))
              .toList()
          : [];
      hiddenList.value = list;
      listApproval.value = groupByDate(list);
      requestApproval.value = RequestState.success;
    }
    if (status == ResponseStatus.errorResponse ||
        status == ResponseStatus.error) {
      requestApproval.value = RequestState.error;
    }
  }

  doRemove(idSubmission) {
    hiddenList.value.removeWhere((element) => element.id == idSubmission);
    listApproval.value = groupByDate(hiddenList.value);
    update();
  }

  doUpdateApproval(idSubmission, stat) async {
    Get.back();
    Get.back();
    Dialogs.loading(context: Get.context!);
    final (ResponseStatus status, res) = await apiClient.post(
        url: 'submission-approval',
        data: {
          "submission_id": idSubmission,
          "status": stat,
          "description": description.text
        });
    if (status == ResponseStatus.success) {
      doRemove(idSubmission);
      Get.back();
      AppAlert.success(
          context: Get.context!,
          message: res['message'] ?? 'Successfully approve');
    }
    if (status == ResponseStatus.errorResponse ||
        status == ResponseStatus.error) {
      Get.back();
      AppAlert.error(context: Get.context!, message: '$res');
    }
  }
}

Map<String, List<Approval>> groupByDate(List<Approval> dataList) {
  Map<String, List<Approval>> groupedData = {};

  for (var data in dataList) {
    if (groupedData.containsKey(data.createdAt)) {
      groupedData[data.createdAt]!.add(data);
    } else {
      groupedData[data.createdAt!] = [data];
    }
  }

  return groupedData;
}
