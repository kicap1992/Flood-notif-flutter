import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/app.logger.dart';

class MyHttpServices {
  final _log = getLogger('MyHttpServices');
  final _snackbarService = locator<SnackbarService>();
  final _options = BaseOptions(
    baseUrl: dotenv.env['api_url']!,
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
  );

  late Dio _dio;

  MyHttpServices() {
    _dio = Dio(_options);
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioException catch (e) {
      String response = e.response != null
          ? e.response!.data['message'].toString()
          : e.toString();
      _log.e('ini errornya: $response');
      _snackbarService.showSnackbar(
        message: response,
        title: 'Error',
        duration: const Duration(milliseconds: 1000),
      );
      rethrow;
    }
  }

  Future<Response> postWithFormData(String path, FormData formData) async {
    try {
      return await _dio.post(path, data: formData);
    } on DioException catch (e) {
      String response = e.response != null
          ? e.response!.data['message'].toString()
          : e.toString();
      _log.e('ini errornya: $response');
      _snackbarService.showSnackbar(
        message: response,
        title: 'Error',
        duration: const Duration(milliseconds: 1000),
      );
      rethrow;
    }
  }

  // putWithFormData
  Future<Response> putWithFormData(String path, FormData formData) async {
    try {
      return await _dio.put(path, data: formData);
    } on DioException catch (e) {
      String response = e.response != null
          ? e.response!.data['message'].toString()
          : e.toString();
      _log.e('ini errornya: $response');
      _snackbarService.showSnackbar(
        message: response,
        title: 'Error',
        duration: const Duration(milliseconds: 1000),
      );
      rethrow;
    }
  }

  // // delete
  // Future<Response> delete(String path, FormData data) async {
  //   try {
  //     // log.i('path: $path');
  //     return await _dio.delete(
  //       path,
  //       data: data,
  //       // encoding: Encoding.getByName('utf-8'),
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/x-www-form-urlencoded',
  //         },
  //       ),
  //     );
  //   } on DioError catch (e) {
  //     log.e(e.message);
  //     log.e(e.response);
  //     rethrow;
  //   }
  // }
}
