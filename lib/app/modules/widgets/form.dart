import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/text_style.dart';

class Forms {
  static general({
    required String title,
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? hint,
    int? maxLines,
    bool? readOnly,
    IconData? suffixIcon,
    Color? color,
    bool? moneyFormat,
    Color? textColor,
  }) {
    return TextFormField(
      cursorColor: AppColors.main,
      controller: controller ?? TextEditingController(),
      keyboardType: keyboardType ?? TextInputType.multiline,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: color ?? Colors.transparent,
        errorStyle: const TextStyle(color: Colors.red),
        contentPadding: const EdgeInsets.only(left: 8, top: 20),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: AppColors.baseGrey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: AppColors.baseGrey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: AppColors.baseGrey),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 2, color: Colors.red),
        ),
      ),
      style: TextStyle(color: textColor ?? Colors.grey[800]),
      onChanged: (string) {
        if (moneyFormat ?? false) {
          string = NumberFormat.decimalPattern('en')
              .format(int.parse((string.replaceAll(',', ''))));
          controller?.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(offset: string.length),
          );
        }
      },
    );
  }

  static generalWithValidator({
    required String title,
    required TextEditingController controller,
    required TextInputType keyboardType,
    String? hint,
    int? maxLines,
    bool? readOnly,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: AppColors.main, fontSize: 16)),
          const SizedBox(height: 2),
          TextFormField(
            cursorColor: AppColors.main,
            validator: (value) => CommonUtil.falsyChecker(value)
                ? "This field is required"
                : null,
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines ?? 1,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              fillColor: AppColors.grey10,
              contentPadding: const EdgeInsets.only(left: 8),
              hintText: hint ?? title,
            ),
          ),
        ],
      );
  static generalWithOntap({
    String? title,
    required Function onTap,
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? hint,
    int? maxLines,
    bool? readOnly,
    IconData? suffixIcon,
    Color? color,
    Color? textColor,
    Color? titleColor,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!CommonUtil.falsyChecker(title))
            AppText.textWidget14(
                text: title ?? '', color: titleColor ?? AppColors.main),
          const SizedBox(height: 2),
          TextFormField(
            onTap: () => onTap(),
            cursorColor: AppColors.main,
            controller: controller ?? TextEditingController(),
            keyboardType: keyboardType ?? TextInputType.multiline,
            maxLines: maxLines ?? 1,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              fillColor: color ?? AppColors.grey10,
              contentPadding: const EdgeInsets.only(left: 8),
              hintText: hint ?? '',
              suffixIcon: Icon(suffixIcon),
            ),
            style: TextStyle(color: textColor ?? Colors.black),
          ),
        ],
      );
}

class FormWidgetPassword extends StatefulWidget {
  final bool withValidation;
  final String? title;
  final Color? colorTitle;
  final Color? colorBorder;
  final Color? colorBorderFocused;
  final TextEditingController controller;
  final String? error;
  final double? radiusBorder;
  final Color? backgroundColor;
  const FormWidgetPassword(
      {super.key,
      required this.withValidation,
      this.title,
      this.colorTitle,
      this.colorBorder,
      this.colorBorderFocused,
      required this.controller,
      this.error,
      this.radiusBorder,
      this.backgroundColor});

  @override
  State<FormWidgetPassword> createState() => _FormWidgetPasswordState();
}

class _FormWidgetPasswordState extends State<FormWidgetPassword> {
  bool showPassword = true;

  doShowPassword() {
    setState(() {
      showPassword ? showPassword = false : showPassword = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: showPassword,
          decoration: InputDecoration(
            hintText: widget.title,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: widget.backgroundColor ?? Colors.transparent,
            suffixIcon: GestureDetector(
              onTap: () => doShowPassword(),
              child: Icon(
                Icons.remove_red_eye,
                color: !showPassword ? AppColors.main : Colors.grey[1000],
              ),
            ),
            errorStyle: const TextStyle(color: Colors.red),
            contentPadding: const EdgeInsets.only(left: 8),
            disabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.radiusBorder ?? 10)),
              borderSide: BorderSide(
                  width: 2, color: widget.colorBorder ?? AppColors.baseGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.radiusBorder ?? 10)),
              borderSide: BorderSide(
                  width: 2, color: widget.colorBorder ?? AppColors.baseGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.radiusBorder ?? 10)),
              borderSide: BorderSide(
                  width: 2,
                  color: widget.colorBorderFocused ?? AppColors.baseGrey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.radiusBorder ?? 10)),
              borderSide: const BorderSide(width: 2, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.radiusBorder ?? 10)),
              borderSide: const BorderSide(width: 2, color: Colors.red),
            ),
          ),
          validator: (value) {
            if (widget.withValidation) {
              if (value == null || value.isEmpty) {
                return widget.error ?? '*mandatory';
              }
              return null;
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
