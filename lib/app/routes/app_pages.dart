import 'package:get/get.dart';

import '../modules/approval/bindings/approval_binding.dart';
import '../modules/approval/views/approval_view.dart';
import '../modules/attendance/bindings/attendance_binding.dart';
import '../modules/attendance/views/attendance_view.dart';
import '../modules/attendance_detail/bindings/attendance_detail_binding.dart';
import '../modules/attendance_detail/views/attendance_detail_view.dart';
import '../modules/camera_attendance/bindings/camera_attendance_binding.dart';
import '../modules/camera_attendance/views/camera_attendance_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/submission/bindings/submission_binding.dart';
import '../modules/submission/views/submission_view.dart';
import '../modules/submission_detail/bindings/submission_detail_binding.dart';
import '../modules/submission_detail/views/submission_detail_view.dart';
import '../modules/submission_form/bindings/submission_form_binding.dart';
import '../modules/submission_form/views/submission_form_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.SUBMISSION,
      page: () => const SubmissionView(),
      binding: SubmissionBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.SUBMISSION_FORM,
      page: () => const SubmissionFormView(),
      binding: SubmissionFormBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.ATTENDANCE,
      page: () => const AttendanceView(),
      binding: AttendanceBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.APPROVAL,
      page: () => const ApprovalView(),
      binding: ApprovalBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.CAMERA_ATTENDANCE,
      page: () => const CameraAttendanceView(),
      binding: CameraAttendanceBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.ATTENDANCE_DETAIL,
      page: () => AttendanceDetailView(),
      binding: AttendanceDetailBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: _Paths.SUBMISSION_DETAIL,
      page: () => SubmissionDetailView(),
      binding: SubmissionDetailBinding(),
      transition: Transition.leftToRight,
    ),
  ];
}
