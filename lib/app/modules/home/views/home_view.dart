import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/modules/attendance/controllers/attendance_controller.dart';
import 'package:qubah_app/app/modules/attendance/views/attendance_view.dart';
import 'package:qubah_app/app/modules/dashboard/views/dashboard_view.dart';
import 'package:qubah_app/app/modules/profile/views/profile_view.dart';
import 'package:qubah_app/app/modules/submission/controllers/submission_controller.dart';
import 'package:qubah_app/app/modules/submission/views/submission_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (controller) {
        return Obx(() => Scaffold(
              body: IndexedStack(
                index: controller.index.value,
                children: const [
                  DashboardView(),
                  AttendanceView(),
                  SubmissionView(),
                  ProfileView()
                ],
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.6),
                  //     blurRadius: 10,
                  //   ),
                  // ],
                ),
                child: ClipRRect(
                  // borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: BottomAppBar(
                    padding: EdgeInsets.zero,
                    surfaceTintColor: Colors.white,
                    height: 55,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => controller.index.value = 0,
                          icon: Icon(
                            CupertinoIcons.rectangle_3_offgrid_fill,
                            color: controller.index.value == 0
                                ? AppColors.main
                                : AppColors.baseGrey,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.index.value = 1;
                            Get.find<AttendanceController>().doGetAttendance(
                                DateTime.now()
                                    .subtract(const Duration(days: 5)),
                                DateTime.now());
                            Get.find<AttendanceController>().doGetRecap(
                                DateTime(DateTime.now().year,
                                    DateTime.now().month, 1),
                                DateTime(DateTime.now().year,
                                    DateTime.now().month + 1, 0));
                          },
                          icon: Icon(
                            Icons.access_time_filled,
                            color: controller.index.value == 1
                                ? AppColors.main
                                : AppColors.baseGrey,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.index.value = 2;
                            Get.find<SubmissionController>().doGetSubmission(
                                DateTime.now()
                                    .subtract(const Duration(days: 5)),
                                DateTime.now());
                            Get.find<SubmissionController>().doGetRecap();
                          },
                          icon: Icon(
                            Icons.event_repeat,
                            color: controller.index.value == 2
                                ? AppColors.main
                                : AppColors.baseGrey,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.index.value = 3;
                          },
                          icon: Icon(
                            Icons.account_circle,
                            color: controller.index.value == 3
                                ? AppColors.main
                                : AppColors.baseGrey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
