import 'package:dio/dio.dart';

import 'http_exception.dart';

// 自定义拦截器
class HttpInterceptor extends Interceptor {
  // 请求拦截
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
  }

  // 响应拦截
  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // do something...
    super.onResponse(response, handler);
  }

  // 异常拦截
  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // 覆盖异常为自定义的异常类
    HttpException httpException = HttpException.create(err);
    err.error = httpException;

    super.onError(err, handler);
  }
}
