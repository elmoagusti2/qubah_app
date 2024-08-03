import 'package:flutter/material.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/text_style.dart';

class AppButton {
  static general({
    required String title,
    Color? color,
    Function? onTap,
  }) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.main,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () => onTap!(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.textWidgetBold16(text: title, color: Colors.white)
          ],
        ));
  }

  static generalWithWidget({
    required Widget widget,
    Color? color,
    Function? onTap,
  }) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: color ?? AppColors.main,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () => onTap!(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [widget],
        ));
  }
}
