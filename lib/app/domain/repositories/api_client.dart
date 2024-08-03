import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/logger.dart';

enum ResponseStatus { error, success, errorResponse }

class ApiClient {
  final dio = Dio();
  final box = GetStorage();
  final baseUrl = 'https://simaq.totalkilat.com/api/';

  get({url, data}) async {
    try {
      final Response response = await dio
          .get('$baseUrl$url',
              data: data ?? {},
              options:
                  Options(headers: {"access-token-simaq": box.read('token')}))
          .timeout(const Duration(seconds: 30));
      printInfo('${response.data}');
      return response.statusCode == 200 && response.data.runtimeType != String
          ? (ResponseStatus.success, response.data)
          : (ResponseStatus.errorResponse, {'message': '${response.data}'});
    } on TimeoutException catch (_) {
      return (ResponseStatus.error, {'message': 'Request time out'});
    } on DioException catch (e) {
      printX(e.toString());
      return (
        ResponseStatus.error,
        {'message': 'Error ${e.response?.statusCode}'}
      );
    }
  }

  post({required url, data}) async {
    try {
      final Response<dynamic> response = await dio
          .post('$baseUrl$url',
              data: data ?? {},
              options: Options(
                  headers: !CommonUtil.falsyChecker(box.read('token'))
                      ? {"access-token-simaq": box.read('token')}
                      : {}))
          .timeout(const Duration(seconds: 30));
      printInfo('${response.data}');
      return response.statusCode == 200 && response.data.runtimeType != String
          ? (ResponseStatus.success, response.data)
          : (ResponseStatus.errorResponse, {'message': '${response.data}'});
    } on TimeoutException catch (_) {
      return (ResponseStatus.error, {'message': 'Request time out'});
    } on DioException catch (e) {
      printX(e.toString());
      printX('${e.response?.statusCode}');
      return (
        ResponseStatus.error,
        {'message': 'Error ${e.response?.statusCode}'}
      );
    }
  }
}
