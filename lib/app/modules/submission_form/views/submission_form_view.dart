import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/modules/widgets/button.dart';
import 'package:qubah_app/app/modules/widgets/form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controllers/submission_form_controller.dart';

class SubmissionFormView extends StatefulWidget {
  const SubmissionFormView({super.key});

  @override
  State<SubmissionFormView> createState() => _SubmissionFormViewState();
}

class _SubmissionFormViewState extends State<SubmissionFormView> {
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: AppText.textWidgetBold16(
              text: strings.applySubmission, color: Colors.black),
        ),
        body: GetBuilder<SubmissionFormController>(
          init: SubmissionFormController(),
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppText.textWidgetBold12(
                                    text: strings.typeSubmission,
                                    color: Colors.grey),
                                AppText.textWidgetBold12(
                                    text: ' *', color: Colors.red),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              children: [
                                for (var e in controller.listSubmission.value)
                                  GestureDetector(
                                    onTap: () {
                                      controller.code.value = e.code!;
                                      controller.isDocument.value =
                                          e.isPicture!;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Chip(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        backgroundColor:
                                            controller.code.value == e.code
                                                ? AppColors.main
                                                : AppColors.white,
                                        side: const BorderSide(
                                            color: AppColors.baseGrey),
                                        label: AppText.textWidget12(
                                            text: e.name ?? '-',
                                            color:
                                                controller.code.value == e.code
                                                    ? Colors.white
                                                    : AppColors.main),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                AppText.textWidgetBold12(
                                    text: strings.date, color: Colors.grey),
                                AppText.textWidgetBold12(
                                    text: ' *', color: Colors.red),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: RangePicker(
                                initiallyShowDate: DateTime.now(),
                                selectedPeriod: controller.selectedPeriod.value,
                                onChanged: controller.onSelectedDateChanged,
                                firstDate: controller.startDate,
                                lastDate: controller.endDate,
                                datePickerLayoutSettings:
                                    DatePickerLayoutSettings(
                                        scrollPhysics:
                                            const NeverScrollableScrollPhysics(),
                                        monthPickerPortraitWidth:
                                            Get.size.width),
                                datePickerStyles: DatePickerRangeStyles(
                                    selectedPeriodMiddleDecoration:
                                        const BoxDecoration(
                                            color: AppColors.blue20),
                                    selectedPeriodMiddleTextStyle:
                                        const TextStyle(color: AppColors.main),
                                    selectedDateStyle: const TextStyle(
                                        color: AppColors.white)),
                              ),
                            ),
                            if (controller.isDocument.value == '1')
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130,
                                    child: AppButton.generalWithWidget(
                                        onTap: () =>
                                            controller.doPickDocument(false),
                                        widget: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.note_add),
                                            const SizedBox(width: 4),
                                            AppText.textWidgetBold12(
                                              text: strings.addDocument,
                                            ),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 130,
                                    child: AppButton.generalWithWidget(
                                        onTap: () =>
                                            controller.doPickDocument(true),
                                        widget: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.note_add),
                                            const SizedBox(width: 4),
                                            AppText.textWidgetBold12(
                                              text: strings.addPhoto,
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            if (!CommonUtil.falsyChecker(
                                    controller.filePick.value.path) &&
                                controller.isDocument.value == '1')
                              AppText.textWidget12(
                                text: '${controller.filePick.value}',
                              ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                AppText.textWidgetBold12(
                                    text: strings.note, color: Colors.grey),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Forms.general(
                                controller: controller.note,
                                title: '',
                                maxLines: 4),
                            const SizedBox(height: 30),
                            SizedBox(
                                height: 50,
                                child: AppButton.generalWithWidget(
                                    widget:
                                        controller.requestSSubmission.value ==
                                                RequestState.loading
                                            ? const CircularProgressIndicator(
                                                color: AppColors.white)
                                            : AppText.textWidgetBold16(
                                                text: strings.apply,
                                                color: Colors.white),
                                    onTap: () =>
                                        controller.requestSSubmission.value ==
                                                RequestState.loading
                                            ? null
                                            : controller.doPostSubmission()))
                          ],
                        ),
                      ),
                    )));
          },
        ));
  }
}
