import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/format_date.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/models/attendance.dart';
import 'package:qubah_app/app/modules/widgets/card_attendance.dart';
import 'package:qubah_app/app/modules/widgets/date_form.dart';
import 'package:qubah_app/app/modules/widgets/loading_list_card.dart';
import 'package:qubah_app/app/modules/widgets/state_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qubah_app/app/routes/app_pages.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(
      init: AttendanceController(),
      initState: (_) {},
      builder: (controller) {
        final strings = AppLocalizations.of(context)!;
        return Scaffold(
            backgroundColor: AppColors.baseGrey,
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 50, bottom: 16, right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.textWidgetBold16(
                        text: strings.attendance, color: Colors.black),
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
                              AppText.textWidgetBold16(
                                  text: AppFormatDate()
                                      .MMMyy(controller.datenow)),
                              const Spacer(),
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(Icons.event_note))
                            ],
                          ),
                          AppText.textWidget12(text: strings.summary),
                          Obx(() => CardAttendance(s: [
                                '${controller.recapAttendance.value.totalAttendance}',
                                '${controller.recapAttendance.value.totalSubmission}',
                                '${controller.recapAttendance.value.absent}',
                                '${controller.recapAttendance.value.late}',
                              ])),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            width: Get.size.width,
                            decoration: const BoxDecoration(
                                color: AppColors.grey10,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                border: Border(
                                  bottom: BorderSide.none,
                                  top: BorderSide(color: Colors.grey),
                                  left: BorderSide(color: Colors.grey),
                                  right: BorderSide(color: Colors.grey),
                                )),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.textWidgetBold14(
                                            text: strings.listOfAttendance),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor: Colors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                              ),
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return DateForm(function:
                                                    (DateTime start,
                                                        DateTime end) {
                                                  controller.doGetAttendance(
                                                      start, end);
                                                  Get.back();
                                                });
                                              });
                                        },
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Obx(() => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                width: Get.size.width,
                                decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)),
                                    border: Border(
                                      top: BorderSide.none,
                                      bottom: BorderSide(color: Colors.grey),
                                      left: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey),
                                    )),
                                child: controller.requestSSubmission.value ==
                                            RequestState.success &&
                                        controller
                                            .listAttendance.value.isNotEmpty
                                    ? ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .listAttendance.value.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final attendance = controller
                                              .listAttendance.value[index];
                                          return ListAttendanceCard(
                                              item: attendance);
                                        },
                                      )
                                    : controller.requestSSubmission.value ==
                                            RequestState.loading
                                        ? const LoadingListCard(
                                            count: 4,
                                            baseColor: AppColors.white,
                                            backgroundColor: AppColors.baseGrey,
                                          )
                                        : StateCustom.empty(
                                            title: strings.emptyAttendance),
                              )),
                        ],
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

class ListAttendanceCard extends StatelessWidget {
  const ListAttendanceCard({
    super.key,
    required this.item,
  });
  final Attendance item;
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ATTENDANCE_DETAIL, arguments: item),
      child: GridView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisExtent: 100),
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.baseGrey),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.textWidgetBold14(
                    text: !CommonUtil.falsyChecker(item.dateFormat)
                        ? item.dateFormat!
                        : '-',
                    color: Colors.grey[800]),
                AppText.textWidgetBold12(
                    text: !CommonUtil.falsyChecker(item.dayName)
                        ? item.dayName!
                        : '-',
                    color: Colors.grey[800]),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !CommonUtil.falsyChecker(item.checkIn)
                    ? const Icon(
                        Icons.update,
                        color: AppColors.greenSubmission,
                      )
                    : const Icon(
                        Icons.cancel,
                        color: AppColors.red20,
                      ),
                AppText.textWidgetBold12(
                    text: !CommonUtil.falsyChecker(item.checkIn)
                        ? item.checkIn!
                        : '-',
                    color: Colors.grey[800]),
                AppText.textWidget12(
                    textAlign: TextAlign.center,
                    text: strings.clockIn,
                    maxLines: 1,
                    color: Colors.grey[600])
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !CommonUtil.falsyChecker(item.checkOut)
                    ? const Icon(
                        Icons.update,
                        color: AppColors.orangeSubmission,
                      )
                    : const Icon(
                        Icons.cancel,
                        color: AppColors.red20,
                      ),
                AppText.textWidgetBold12(
                    text: !CommonUtil.falsyChecker(item.checkOut)
                        ? item.checkOut!
                        : '-',
                    color: Colors.grey[800]),
                AppText.textWidget12(
                    textAlign: TextAlign.center,
                    text: strings.clockOut,
                    maxLines: 1,
                    color: Colors.grey[600])
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !CommonUtil.falsyChecker(item.totalHours)
                    ? const Icon(
                        Icons.check_circle,
                        color: AppColors.blueAccent,
                      )
                    : const Icon(
                        Icons.cancel,
                        color: AppColors.red20,
                      ),
                AppText.textWidgetBold12(
                    text: !CommonUtil.falsyChecker(item.totalHours)
                        ? item.totalHours!
                        : '-',
                    color: Colors.grey[800]),
                AppText.textWidget12(
                    textAlign: TextAlign.center,
                    text: strings.totalHrs,
                    maxLines: 1,
                    color: Colors.grey[600])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
