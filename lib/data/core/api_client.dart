import 'package:dio/dio.dart';


final dioClient = DioClient();


class DioClient {
  late final Dio _dio;

  Dio get dio => _dio;

  DioClient() {
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 3000);
    _dio = Dio(options);
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          _dio.lock();
          options.headers["Accept"] = "application/json";
          options.headers["Content-Type"] = "application/json";
          
          _dio.unlock();
          handler.next(options);
        },
      ),
      LogInterceptor(requestBody: true, responseBody: true)
    ]);
  }
}


