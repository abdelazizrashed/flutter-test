import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://caramellez.com/api",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    if (dio == null) {
      DioHelper.init();
    }
    dio!.options.headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Accept': 'application/json',
    };
    return await dio!.get(
      path,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
    url,
  }) async {
    if (dio == null) {
      DioHelper.init();
    }
    dio!.options.headers = {
      'Authorization': 'Bearer ${token ?? ''}',
      'Accept': 'application/json',
    };
    return await dio!.post(
      path,
      data: data,
      queryParameters: query,
    );
  }
}
