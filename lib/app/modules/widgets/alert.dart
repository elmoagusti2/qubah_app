import 'package:flutter/material.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';

class AppAlert {
  static error({required BuildContext context, required String message}) =>
      context.showFlash<bool>(
        barrierDismissible: true,
        duration: const Duration(seconds: 3),
        builder: (context, controller) => FlashBar(
          controller: controller,
          backgroundColor: Colors.red,
          position: FlashPosition.top,
          // indicatorColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(color: Colors.transparent),
          ),
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          content: AppText.textWidget16(
              text: message, color: Colors.white, maxLines: 4),
        ),
      );

  static success({required BuildContext context, required String message}) =>
      context.showFlash<bool>(
        barrierDismissible: true,
        duration: const Duration(seconds: 3),
        builder: (context, controller) => FlashBar(
          controller: controller,
          backgroundColor: Colors.green,
          position: FlashPosition.top,
          // indicatorColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(color: Colors.transparent),
          ),
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          content: AppText.textWidget16(text: message, color: Colors.white),
        ),
      );

  static loading({required BuildContext context}) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const PopScope(
          canPop: false,
          child: Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(color: AppColors.main),
            ),
          ),
        ),
      );
}
