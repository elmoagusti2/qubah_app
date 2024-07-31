// ignore_for_file: non_constant_identifier_names

import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'common_utils.dart';

class AppFormatDate {
  final box = GetStorage();
  String MMMMDDYYYY_EEEE(DateTime date) => DateFormat('MMMM dd, yyyy - EEEE',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);
  String EEE(DateTime date) => DateFormat('EEE',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String yy(DateTime date) => DateFormat('yy',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String MMM(DateTime date) => DateFormat('MMM',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String dd(DateTime date) => DateFormat('dd',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String MMMyy(DateTime date) => DateFormat('MMM yy',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String MMMyyyy(DateTime date) => DateFormat('MMM yyyy',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String ddMMMyyyy(DateTime date) => DateFormat('dd MMM yyyy',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String ddMMMMyyyy(DateTime date) => DateFormat('dd MMMM yyyy',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String yyyymmdd(DateTime date) => DateFormat('yyyy-MM-dd',
          !CommonUtil.falsyChecker(box.read('lang')) ? box.read('lang') : 'en')
      .format(date);

  String custom(DateTime date, String custom) =>
      DateFormat(custom).format(date);
}
