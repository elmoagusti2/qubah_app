import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/modules/widgets/button.dart';
import 'package:qubah_app/app/modules/widgets/form.dart';
import '../controllers/login_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      initState: (_) {},
      builder: (controller) {
        final strings = AppLocalizations.of(context)!;
        return Scaffold(
            body: SafeArea(
                child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Center(
                child: Image.asset('assets/images/logo.png', height: 200),
              ),
              const Spacer(),
              AppText.textWidgetBold20(text: 'Qubah Apps'),
              AppText.textWidget12(text: strings.noteLogin, color: Colors.grey),
              const SizedBox(height: 20),
              Forms.general(
                  title: 'Username',
                  color: AppColors.white,
                  controller: controller.name),
              const SizedBox(height: 14),
              FormWidgetPassword(
                controller: controller.passowrd,
                title: strings.password,
                withValidation: true,
              ),
              const SizedBox(height: 40),
              Obx(() => SizedBox(
                  height: 45,
                  child: AppButton.generalWithWidget(
                      widget:
                          controller.requestLogin.value == RequestState.loading
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : AppText.textWidgetBold16(
                                  text: strings.login, color: Colors.white),
                      onTap: () =>
                          controller.requestLogin.value == RequestState.loading
                              ? null
                              : controller.doLogin())))
            ],
          ),
        )));
      },
    );
  }
}
