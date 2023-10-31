import 'package:dio/dio.dart';
import 'package:knowunity_project/dio/request_interceptor.dart';

class ApiClient {
  static final Dio dio = Dio();

  ApiClient() {
    dio.interceptors.addAll([RequestInterceptor()]);
  }
}
