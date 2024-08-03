import 'package:clock_widget/clock_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/format_date.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/modules/home/controllers/home_controller.dart';
import 'package:qubah_app/app/modules/widgets/card_attendance.dart';
import 'package:qubah_app/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (controller) {
        final strings = AppLocalizations.of(context)!;
        return Scaffold(
            backgroundColor: AppColors.baseGrey,
            body: Obx(() => SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        width: Get.size.width,
                        height: 200,
                        color: AppColors.main,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 50, bottom: 16, right: 16, left: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.textWidget20(
                                          text:
                                              'Hey ${controller.configuration.employee?.name ?? '-'}!',
                                          color: AppColors.white),
                                      AppText.textWidget12(
                                          text: strings.markYourAttendance,
                                          color: AppColors.baseGrey)
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColors.baseGrey,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      !CommonUtil.falsyChecker(controller
                                              .configuration.employee?.photo)
                                          ? controller
                                              .configuration.employee!.photo!
                                          : 'https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611731.jpg',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const SizedBox(
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              width: Get.size.width,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  const ClockWidget(
                                    clockType: ClockType.digital,
                                    bgColor: Colors.white,
                                  ),
                                  AppText.textWidgetBold12(
                                      text: AppFormatDate()
                                          .MMMMDDYYYY_EEEE(DateTime.now()),
                                      color: Colors.grey),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                      width: 140,
                                      height: 140,
                                      child: GestureDetector(
                                        onTap: () => CommonUtil.falsyChecker(
                                                controller.clockIn.value)
                                            ? Get.toNamed(
                                                Routes.CAMERA_ATTENDANCE,
                                                arguments: 'AS01')
                                            : CommonUtil.falsyChecker(
                                                    controller.clockOut.value)
                                                ? Get.toNamed(
                                                    Routes.CAMERA_ATTENDANCE,
                                                    arguments: 'AS02')
                                                : null,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Shimmer.fromColors(
                                                baseColor: AppColors.grey20,
                                                highlightColor:
                                                    const Color(0xFFcccccc),
                                                child: Container(
                                                  width: 150,
                                                  height: 150,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                    color: CommonUtil
                                                                .falsyChecker(
                                                                    controller
                                                                        .clockIn
                                                                        .value) ||
                                                            CommonUtil
                                                                .falsyChecker(
                                                                    controller
                                                                        .clockOut
                                                                        .value)
                                                        ? AppColors.main
                                                        : AppColors
                                                            .greenSubmission,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: AppText.textWidget14(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: CommonUtil
                                                                .falsyChecker(
                                                                    controller
                                                                        .clockIn
                                                                        .value)
                                                            ? strings.clockIn
                                                            : CommonUtil.falsyChecker(
                                                                    controller
                                                                        .clockOut
                                                                        .value)
                                                                ? strings
                                                                    .clockOut
                                                                : strings
                                                                    .completed,
                                                        color:
                                                            AppColors.white)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(height: 30),
                                  AppText.textWidgetBold12(
                                    text: strings.noteAttendance,
                                    color: Colors.grey,
                                  ),
                                  AttendanceDashboardBottom(
                                      controller: controller)
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              width: Get.size.width,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      AppText.textWidgetBold14(
                                          text: strings.attendance),
                                      const Spacer(),
                                      GestureDetector(
                                          onTap: () =>
                                              Get.find<HomeController>()
                                                  .index
                                                  .value = 1,
                                          child:
                                              const Icon(Icons.arrow_forward))
                                    ],
                                  ),
                                  AppText.textWidget12(text: strings.summary),
                                  CardAttendance(s: [
                                    '${controller.recapAttendance.value.totalAttendance}',
                                    '${controller.recapAttendance.value.totalSubmission}',
                                    '${controller.recapAttendance.value.absent}',
                                    '${controller.recapAttendance.value.late}',
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )));
      },
    );
  }
}

class AttendanceDashboardBottom extends StatelessWidget {
  const AttendanceDashboardBottom({
    super.key,
    required this.controller,
  });
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.update,
                      color: AppColors.greenSubmission,
                    ),
                    AppText.textWidgetBold12(
                        text: !CommonUtil.falsyChecker(controller.clockIn.value)
                            ? controller.clockIn.value
                            : '-',
                        color: Colors.grey[800]),
                    AppText.textWidget12(
                        text: strings.clockIn, color: Colors.grey[600])
                  ],
                ),
              ),
            ),
            Container(
              width: 2,
              height: 20,
              color: AppColors.baseGrey,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.update,
                      color: AppColors.orangeSubmission,
                    ),
                    AppText.textWidgetBold12(
                        text:
                            !CommonUtil.falsyChecker(controller.clockOut.value)
                                ? controller.clockOut.value
                                : '-',
                        color: Colors.grey[800]),
                    AppText.textWidget12(
                        text: strings.clockOut, color: Colors.grey[600])
                  ],
                ),
              ),
            ),
            Container(
              width: 2,
              height: 20,
              color: AppColors.baseGrey,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.blueAccent,
                    ),
                    AppText.textWidgetBold12(
                        text:
                            !CommonUtil.falsyChecker(controller.totalHrs.value)
                                ? controller.totalHrs.value
                                : '-',
                        color: Colors.grey[800]),
                    AppText.textWidget12(
                        text: strings.totalHrs, color: Colors.grey[600])
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
