import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/models/recap_submission/submission_data.dart';
import 'package:qubah_app/app/models/submission.dart';
import 'package:qubah_app/app/modules/submission/views/widgets/submission_card.dart';
import 'package:qubah_app/app/modules/widgets/button.dart';
import 'package:qubah_app/app/modules/widgets/date_form.dart';
import 'package:qubah_app/app/modules/widgets/loading_list_card.dart';
import 'package:qubah_app/app/modules/widgets/shimmer.dart';
import 'package:qubah_app/app/modules/widgets/state_custom.dart';
import 'package:qubah_app/app/routes/app_pages.dart';
import '../controllers/submission_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmissionView extends GetView<SubmissionController> {
  const SubmissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmissionController>(
      init: SubmissionController(),
      initState: (_) {},
      builder: (controller) {
        final strings = AppLocalizations.of(context)!;
        return Scaffold(
          backgroundColor: AppColors.baseGrey,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.textWidgetBold16(text: strings.submission),
                  const SizedBox(height: 10),
                  Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 9),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.textWidgetBold14(text: 'Dashboard'),
                            const SizedBox(height: 4),
                            AppText.textWidget12(
                                text: strings.summary, color: Colors.grey),
                            const SizedBox(height: 20),
                            Center(
                              child: CircularPercentIndicator(
                                radius: 100,
                                animation: true,
                                animationDuration: 1200,
                                lineWidth: 15.0,
                                percent:
                                    controller.recapSubmission.value.used! /
                                        controller.recapSubmission.value.total!,
                                center: AppText.textWidgetBold28(
                                    text:
                                        '${controller.recapSubmission.value.balance}'),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor: AppColors.baseGrey,
                                progressColor: AppColors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: AppColors.blueAccent,
                                      ),
                                      const SizedBox(width: 4),
                                      AppText.textWidget12(text: strings.used)
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        size: 15,
                                        color: AppColors.baseGrey,
                                      ),
                                      const SizedBox(width: 4),
                                      AppText.textWidget12(
                                          text: strings.balance)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                                color: AppColors.baseGrey, thickness: 3),
                            const SizedBox(height: 10),
                            AppText.textWidget12(text: strings.type),
                            const SizedBox(height: 10),
                            controller.requestRecap.value ==
                                        RequestState.success &&
                                    controller.recapSubmission.value.submission!
                                        .isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.recapSubmission.value
                                        .submission?.length,
                                    itemBuilder: (context, index) {
                                      final item = controller.recapSubmission
                                          .value.submission![index];
                                      return DashboardBar(item: item);
                                    },
                                  )
                                : controller.requestRecap.value ==
                                        RequestState.loading
                                    ? Shimmers.shimmerCustom(
                                        height: 60,
                                        baseColor: AppColors.baseGrey,
                                        highColor: Colors.white)
                                    : const SizedBox.shrink(),
                          ],
                        ),
                      )),
                  if (controller.employee?.isSupervisor == '1')
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        AppButton.generalWithWidget(
                            widget: Row(
                              children: [
                                const SizedBox(width: 8),
                                AppText.textWidget14(
                                    text: strings.approvalRequest),
                                const SizedBox(width: 20),
                                const Icon(Icons.arrow_forward_ios_outlined,
                                    size: 13),
                                const SizedBox(width: 8),
                              ],
                            ),
                            onTap: () => Get.toNamed(Routes.APPROVAL)),
                        const SizedBox(height: 20),
                      ],
                    ),
                  Obx(() => Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 9),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                AppText.textWidgetBold14(
                                    text: strings.requests),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
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
                                            return DateForm(function:
                                                (DateTime start, DateTime end) {
                                              controller.doGetSubmission(
                                                  start, end);
                                              Get.back();
                                            });
                                          });
                                    },
                                    icon: Icon(
                                      Icons.filter_alt,
                                      color: Colors.grey[600],
                                    ))
                              ],
                            ),
                            const SizedBox(height: 20),
                            controller.requestSubmission.value ==
                                        RequestState.success &&
                                    controller.listSubmission.value.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        controller.listSubmission.value.length,
                                    itemBuilder: (context, index) {
                                      final Submission submission = controller
                                          .listSubmission.value[index];
                                      return SubmissionCard(item: submission);
                                    },
                                  )
                                : controller.requestSubmission.value ==
                                        RequestState.loading
                                    ? const LoadingListCard(
                                        count: 4,
                                        baseColor: AppColors.white,
                                        backgroundColor: AppColors.baseGrey,
                                      )
                                    : StateCustom.empty(
                                        title: strings.emptyRequests),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          )),
          floatingActionButton: SizedBox(
            width: 60,
            height: 60,
            child: AppButton.generalWithWidget(
                widget: const Icon(Icons.add),
                onTap: () => Get.toNamed(Routes.SUBMISSION_FORM)),
          ),
        );
      },
    );
  }
}

class DashboardBar extends StatelessWidget {
  const DashboardBar({super.key, required this.item});
  final SubmissionData item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 50,
              child: AppText.textWidget12(
                  text: item.submissionTypeName ?? '-', color: Colors.grey),
            ),
            Expanded(
              child: LinearPercentIndicator(
                lineHeight: 8.0,
                barRadius: const Radius.circular(10),
                percent: double.parse(item.result.toString()),
                progressColor: item.submissionTypeCode == 'ST02'
                    ? AppColors.greenSubmission
                    : item.submissionTypeCode == 'ST03'
                        ? AppColors.orangeSubmission
                        : item.submissionTypeCode == 'ST01'
                            ? AppColors.blueAccent
                            : AppColors.getRandomColor(),
              ),
            ),
            SizedBox(
              width: 40,
              child: AppText.textWidget12(
                  text: '${item.used}/${item.submissionMax}',
                  color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
