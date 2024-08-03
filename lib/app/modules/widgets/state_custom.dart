import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qubah_app/app/common/app_colors.dart';

class StateCustom {
  static Widget empty({String? title, String? description}) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/empty.json',
          repeat: false,
          height: 150,
          width: 150,
        ),
        Text(
          '$title',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: AppColors.main, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          description ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600]),
        )
      ],
    ));
  }
}
