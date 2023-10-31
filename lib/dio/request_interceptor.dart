import 'package:dio/dio.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // here we  add any headers that need to be passed per request
    options.headers["Content-Type"] = "application/json";
    options.headers["Accept"] = "application/json";

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //here we would handle anything that is error related
    // for example check if token is expired and fire a token refresh call
  }
}
