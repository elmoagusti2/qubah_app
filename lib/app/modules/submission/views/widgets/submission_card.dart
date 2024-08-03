import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/models/submission.dart';
import 'package:qubah_app/app/routes/app_pages.dart';

class SubmissionCard extends StatelessWidget {
  const SubmissionCard({
    super.key,
    required this.item,
  });

  final Submission item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => Get.toNamed(Routes.SUBMISSION_DETAIL, arguments: item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.baseGrey, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (item.startDate != item.endDate)
                  AppText.textWidgetBold14(
                      text: '${item.startDate} - ${item.endDate}'),
                if (item.startDate == item.endDate)
                  AppText.textWidgetBold14(text: '${item.startDate}'),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      color: item.status?.toUpperCase() == 'APPROVED'
                          ? AppColors.green10
                          : item.status?.toUpperCase() == 'PENDING'
                              ? AppColors.orange10
                              : AppColors.red10,
                      borderRadius: BorderRadius.circular(100)),
                  child: AppText.textWidget12(
                      text: item.status ?? '-',
                      color: item.status?.toUpperCase() == 'APPROVED'
                          ? Colors.green
                          : item.status?.toUpperCase() == 'PENDING'
                              ? Colors.orange
                              : Colors.red),
                )
              ],
            ),
            const SizedBox(height: 4),
            AppText.textWidget12(
                text: !CommonUtil.falsyChecker(item.description)
                    ? item.description!
                    : '-',
                color: Colors.grey),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color: item.submissionTypeCode == 'ST03'
                      ? AppColors.orangeSubmission
                      : item.submissionTypeCode == 'ST02'
                          ? AppColors.greenSubmission
                          : item.submissionTypeCode == 'ST01'
                              ? AppColors.blueAccent
                              : AppColors.getRandomColor(),
                ),
                const SizedBox(width: 4),
                AppText.textWidget12(
                    text: !CommonUtil.falsyChecker(item.submissionName)
                        ? item.submissionName!
                        : '-')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
