import 'package:flutter/cupertino.dart';

class AppText {
  static const textStyle4 = TextStyle(fontFamily: 'OpenSans', fontSize: 4);
  static const textStyle8 = TextStyle(fontFamily: 'OpenSans', fontSize: 8);
  static const textStyle12 = TextStyle(fontFamily: 'OpenSans', fontSize: 12);
  static const textStyle14 = TextStyle(fontFamily: 'OpenSans', fontSize: 14);
  static const textStyle16 = TextStyle(fontFamily: 'OpenSans', fontSize: 16);
  static const textStyle20 = TextStyle(fontFamily: 'OpenSans', fontSize: 20);
  static const textStyle24 = TextStyle(fontFamily: 'OpenSans', fontSize: 24);
  static const textStyle28 = TextStyle(fontFamily: 'OpenSans', fontSize: 28);

  static textWidget4(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle4.copyWith(color: color),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidget8(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle8.copyWith(color: color),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidget12(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle12.copyWith(color: color),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidget14(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle14.copyWith(color: color),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidget16(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle16.copyWith(color: color),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidget20(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle20.copyWith(color: color),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidget24(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle24.copyWith(color: color),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidget28(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle28.copyWith(color: color),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidgetBold4(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle4.copyWith(color: color, fontWeight: FontWeight.bold),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidgetBold8(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style: textStyle8.copyWith(color: color, fontWeight: FontWeight.bold),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidgetBold12(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style:
              textStyle12.copyWith(color: color, fontWeight: FontWeight.bold),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidgetBold14(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style:
              textStyle14.copyWith(color: color, fontWeight: FontWeight.bold),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidgetBold16(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style:
              textStyle16.copyWith(color: color, fontWeight: FontWeight.bold),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidgetBold20(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style:
              textStyle20.copyWith(color: color, fontWeight: FontWeight.bold),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidgetBold24(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style:
              textStyle24.copyWith(color: color, fontWeight: FontWeight.bold),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
  static textWidgetBold28(
          {required String text,
          Color? color,
          int? maxLines = 100,
          TextAlign? textAlign}) =>
      Text(text,
          style:
              textStyle28.copyWith(color: color, fontWeight: FontWeight.bold),
          maxLines: maxLines,
          textAlign: textAlign ?? TextAlign.left,
          overflow: TextOverflow.ellipsis);
}
