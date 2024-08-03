import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/models/approval.dart';
import 'package:qubah_app/app/modules/widgets/alert.dart';
import 'package:qubah_app/app/modules/widgets/button.dart';
import 'package:qubah_app/app/modules/widgets/dialogs.dart';
import 'package:qubah_app/app/modules/widgets/loading_list_card.dart';
import 'package:qubah_app/app/modules/widgets/state_custom.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../controllers/approval_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApprovalView extends GetView<ApprovalController> {
  const ApprovalView({super.key});
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return GetBuilder<ApprovalController>(
      init: ApprovalController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.baseGrey,
            body: Container(
              margin: const EdgeInsets.only(
                  top: 50, bottom: 16, right: 16, left: 16),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText.textWidgetBold16(
                            text: strings.approvalRequest, color: Colors.black),
                        const Spacer(),
                        IconButton(
                            onPressed: () => controller.doGetApproval(),
                            icon: const Icon(
                              Icons.refresh,
                              color: AppColors.main,
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        width: Get.size.width,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: controller.requestApproval.value ==
                                    RequestState.success &&
                                controller.listApproval.value.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: controller.listApproval.value.length,
                                itemBuilder: (context, index) {
                                  final dataList =
                                      controller.listApproval.value[controller
                                          .listApproval.value.keys
                                          .elementAt(index)];
                                  final date = controller
                                      .listApproval.value.keys
                                      .elementAt(index);
                                  return ApprovalCardGroup(
                                      strings: strings,
                                      date: date,
                                      dataList: dataList);
                                },
                              )
                            : controller.requestApproval.value ==
                                    RequestState.loading
                                ? const LoadingListCard(
                                    count: 15,
                                    baseColor: AppColors.white,
                                    backgroundColor: AppColors.baseGrey,
                                  )
                                : StateCustom.empty(
                                    title: strings.emptyApproval),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

class ApprovalCardGroup extends StatelessWidget {
  ApprovalCardGroup({
    super.key,
    required this.date,
    required this.dataList,
    required this.strings,
  });
  final AppLocalizations strings;

  final String date;
  final List<Approval>? dataList;
  final controller = Get.find<ApprovalController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.textWidgetBold12(text: date, color: Colors.grey[600]),
        const SizedBox(height: 10),
        Column(
          children: dataList!
              .map((data) => GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return ModalApproval(
                              controller: controller,
                              data: data,
                              strings: strings,
                            );
                          });
                    },
                    child: ApprovalCard(
                      item: data,
                      strings: strings,
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ModalApproval extends StatelessWidget {
  final AppLocalizations strings;
  const ModalApproval({
    super.key,
    required this.controller,
    required this.data,
    required this.strings,
  });

  final ApprovalController controller;
  final Approval data;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.35,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 3))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralField(
                      title: strings.name,
                      subTitle: !CommonUtil.falsyChecker(data.name)
                          ? data.name!
                          : '-'),
                  GeneralField(
                      title: strings.submission,
                      subTitle: !CommonUtil.falsyChecker(data.submissionName)
                          ? data.submissionName!
                          : '-'),
                  GeneralField(
                      title: strings.description,
                      subTitle: !CommonUtil.falsyChecker(data.description)
                          ? data.description!
                          : '-'),
                  GeneralField(
                      title: strings.date,
                      subTitle: !CommonUtil.falsyChecker(data.startDate)
                          ? '${data.startDate!} -  ${data.endDate!}'
                          : '-'),
                  if (!CommonUtil.falsyChecker(data.picture))
                    Row(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: WidgetZoom(
                              heroAnimationTag: 'tag',
                              zoomWidget: Image.network(
                                data.picture ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.warning,
                                    size: 30,
                                    color: AppColors.red10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (!CommonUtil.falsyChecker(data.picture))
                          GestureDetector(
                              onTap: () async => await launchUrl(
                                  Uri.parse('${data.picture}'),
                                  mode: LaunchMode.externalApplication),
                              child: AppText.textWidget12(
                                  text: strings.openDocument,
                                  color: AppColors.blueAccent)),
                      ],
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AppButton.generalWithWidget(
                          color: AppColors.red10,
                          widget: AppText.textWidgetBold14(
                              text: strings.decline, color: Colors.red),
                          onTap: () => Dialogs.confirm(
                              context: context,
                              message: strings.confirm,
                              subMessage: strings.areYouSure,
                              desc: controller.description,
                              confirm: () => controller.description.text.isEmpty
                                  ? AppAlert.error(
                                      context: context,
                                      message: strings.pleaseFill)
                                  : controller.doUpdateApproval(data.id, '2')))
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AppButton.generalWithWidget(
                          color: AppColors.green10,
                          widget: AppText.textWidgetBold14(
                              text: strings.approve, color: Colors.green),
                          onTap: () => Dialogs.confirm(
                              context: context,
                              message: strings.confirm,
                              subMessage: strings.areYouSure,
                              confirm: () =>
                                  controller.doUpdateApproval(data.id, '1')))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GeneralField extends StatelessWidget {
  const GeneralField({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: AppText.textWidget12(text: title),
        ),
        Expanded(
          child: AppText.textWidget12(text: ':  $subTitle'),
        )
      ],
    );
  }
}

class ApprovalCard extends StatelessWidget {
  const ApprovalCard({
    super.key,
    required this.item,
    required this.strings,
  });
  final AppLocalizations strings;
  final Approval item;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.submissionTypeCode == 'ST03'
                    ? AppColors.red10
                    : AppColors.blue10),
            child: Icon(
              item.submissionTypeCode == 'ST03'
                  ? Icons.vaccines
                  : Icons.departure_board,
              color:
                  item.submissionTypeCode == 'ST03' ? Colors.red : Colors.blue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.textWidgetBold14(
                    text: !CommonUtil.falsyChecker(item.submissionName)
                        ? '${strings.applicationFor} ${item.submissionName}'
                        : '-'),
                const SizedBox(height: 2),
                AppText.textWidget12(
                    color: Colors.grey[600],
                    text: !CommonUtil.falsyChecker(item.name)
                        ? '${strings.from} ${item.name}'
                        : '-'),
                const SizedBox(height: 2),
                AppText.textWidget12(
                    color: Colors.grey[600],
                    text: !CommonUtil.falsyChecker(item.description)
                        ? item.description!
                        : '-'),
                const SizedBox(height: 2),
              ],
            ),
          )
        ],
      ),
    );
  }
}
