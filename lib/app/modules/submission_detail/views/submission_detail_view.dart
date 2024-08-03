import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/models/submission.dart';
import 'package:qubah_app/app/modules/approval/views/approval_view.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../controllers/submission_detail_controller.dart';

class SubmissionDetailView extends GetView<SubmissionDetailController> {
  SubmissionDetailView({super.key});

  final Submission data = Get.arguments as Submission;
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(width: 1.0, color: AppColors.baseGrey),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        title: AppText.textWidget14(
            text: 'Detail ${strings.submission}', color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.baseGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.textWidgetBold14(text: data.createdAt ?? '-'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.textWidget12(
                          text: !CommonUtil.falsyChecker(data.status)
                              ? data.status!
                              : '-'),
                    ],
                  )
                ],
              ),
            ),
            const Divider(color: AppColors.baseGrey, thickness: 10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  GeneralField(
                      title: strings.submission,
                      subTitle: '${data.submissionName}'),
                  const SizedBox(height: 10),
                  GeneralField(
                      title: strings.description,
                      subTitle: '${data.description}'),
                  const SizedBox(height: 10),
                  GeneralField(
                      title: strings.date,
                      subTitle: '${data.startDate} - ${data.endDate}'),
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: WidgetZoom(
                      heroAnimationTag: 'tag',
                      zoomWidget: Image.network(
                        data.picture ?? '',
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration:
                              const BoxDecoration(color: AppColors.red10),
                          height: 120,
                          width: 120,
                          child: const Icon(
                            Icons.error_outline_rounded,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
