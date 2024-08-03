import 'package:flutter/material.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardAttendance extends StatelessWidget {
  const CardAttendance({super.key, required this.s});
  final List<String> s;
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 100),
        itemCount: s.length,
        itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: index == 0
                            ? AppColors.main
                            : index == 1
                                ? Colors.blue
                                : index == 2
                                    ? Colors.red
                                    : Colors.orange,
                        width: 2)),
                borderRadius: BorderRadius.circular(10),
                color: index == 0
                    ? AppColors.blue10
                    : index == 1
                        ? AppColors.blue20
                        : index == 2
                            ? AppColors.red10
                            : AppColors.orange10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.textWidgetBold16(
                      text: s[index],
                      color: index == 0
                          ? AppColors.main
                          : index == 1
                              ? Colors.blue
                              : index == 2
                                  ? Colors.red
                                  : Colors.orange),
                  AppText.textWidget12(
                    text: index == 0
                        ? strings.attendance
                        : index == 1
                            ? strings.submission
                            : index == 2
                                ? strings.absent
                                : strings.late,
                    color: index == 0
                        ? AppColors.main
                        : index == 1
                            ? Colors.blue
                            : index == 2
                                ? Colors.red
                                : Colors.orange,
                  )
                ],
              ),
            ));
  }
}
