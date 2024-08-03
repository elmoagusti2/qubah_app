import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/modules/widgets/dialogs.dart';
import 'package:qubah_app/app/routes/app_pages.dart';
import '../controllers/profile_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      initState: (_) {},
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            shape: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5)),
            elevation: 4,
            iconTheme: const IconThemeData(color: AppColors.main),
            title: AppText.textWidgetBold16(
                text: strings.profile, color: AppColors.main),
            actions: [
              IconButton(
                  onPressed: () => Dialogs.changeLanguange(
                      context: context,
                      function: (val) => controller.doChangeLanguage(val)),
                  icon: const Icon(Icons.language, color: AppColors.main)),
              IconButton(
                  onPressed: () {
                    GetStorage().remove('token');
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  icon:
                      const Icon(Icons.output_outlined, color: AppColors.main))
            ],
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611731.jpg',
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppText.textWidgetBold16(
                      text: controller.employee?.name ?? '-',
                      color: AppColors.main),
                  const SizedBox(height: 4),
                  AppText.textWidget12(
                      text: controller.employee?.nik ?? '-',
                      color: Colors.grey),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.textWidget16(text: strings.biodata),
                        const SizedBox(height: 12),
                        CustomCard.listTile(
                            leading: const Icon(Icons.business_center),
                            title: strings.company,
                            subTitle: controller.employee?.company ?? '-'),
                        CustomCard.listTile(
                            leading: const Icon(Icons.badge),
                            title: strings.position,
                            subTitle: controller.employee?.position ?? '-'),
                        CustomCard.listTile(
                            leading: const Icon(Icons.privacy_tip),
                            title: strings.employeeStatus,
                            subTitle:
                                controller.employee?.employeeStatus ?? '-'),
                        CustomCard.listTile(
                            leading: const Icon(Icons.today),
                            title: strings.joinDate,
                            subTitle: controller.employee?.joinDate ?? '-'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomCard {
  static listTile(
          {required String title,
          Widget? contentTitle,
          String? subTitle,
          Widget? trailing,
          Widget? leading,
          Function? function}) =>
      ListTile(
        onTap: () => function == null ? null : function(),
        contentPadding: EdgeInsets.zero,
        leading: leading,
        title: contentTitle ?? AppText.textWidget12(text: title, maxLines: 1),
        subtitle: subTitle != null
            ? AppText.textWidget12(text: subTitle, color: Colors.grey)
            : null,
        trailing: trailing,
        shape: const Border(top: BorderSide(color: Colors.grey, width: 1)),
      );
}
