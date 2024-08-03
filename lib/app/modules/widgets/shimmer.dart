import 'package:flutter/material.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers {
  static Widget shimmerCustom(
      {double? width,
      double? height,
      double? circular,
      Color? baseColor,
      Color? highColor}) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.grey20,
      highlightColor: highColor ?? const Color(0xFFcccccc),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(circular ?? 10)),
      ),
    );
  }
}
