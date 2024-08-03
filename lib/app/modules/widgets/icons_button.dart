import 'package:flutter/material.dart';
import 'package:qubah_app/app/common/app_colors.dart';

class IconsButton {
  static mainButton({
    required String icon,
    required String title,
    required Function ontap,
  }) =>
      Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: InkWell(
                splashColor: AppColors.main,
                borderRadius: BorderRadius.circular(100),
                onTap: () => ontap(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      icon,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.main),
            ),
          ),
        ],
      );

  static menuButton(
          {required String icon,
          required String title,
          required Function ontap,
          String? errorIcon,
          Color? colors}) =>
      Column(
        children: [
          Material(
              color: colors ?? Colors.white,
              borderRadius: BorderRadius.circular(100),
              borderOnForeground: false,
              child: InkWell(
                splashColor: AppColors.main,
                borderRadius: BorderRadius.circular(100),
                onTap: () => ontap(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.main, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.network(
                      icon,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          errorIcon ?? 'assets/icons/submission.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 2,
          ),
          Expanded(
            child: Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.main),
            ),
          ),
        ],
      );

  static imageCenter(
          {required IconData icon, required Function ontap, Color? color}) =>
      ElevatedButton(
        onPressed: () => ontap(),
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          surfaceTintColor: const MaterialStatePropertyAll(AppColors.grey10),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return Colors.teal;
              return color ?? AppColors.grey10;
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(icon, color: Colors.grey),
          ],
        ),
      );
}
