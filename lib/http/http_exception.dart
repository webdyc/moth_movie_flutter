import 'package:dio/dio.dart';

// 自定义 http 异常
class HttpException implements Exception {
  final int code;
  final String msg;

  HttpException({this.code = 500, this.msg = '未知异常，请联系管理员'});

  String toString() {
    return "HttpError [$code]: $msg";
  }

  factory HttpException.create(DioError? error) {
    // dio 异常
    switch (error!.type) {
      case DioErrorType.cancel:
        return HttpException(code: -1, msg: '请求取消');
        break;
      case DioErrorType.connectTimeout:
        return HttpException(code: -1, msg: '连接超时');
        break;
      case DioErrorType.sendTimeout:
        return HttpException(code: -1, msg: '请求超时');
        break;
      case DioErrorType.receiveTimeout:
        return HttpException(code: -1, msg: '响应超时');
        break;
      case DioErrorType.response:
        // 服务器异常
        int statusCode = error.response!.statusCode!;
        switch (statusCode) {
          case 400:
            return HttpException(code: statusCode, msg: '请求语法错误');
            break;
          case 401:
            return HttpException(code: statusCode, msg: '没有权限');
            break;
          case 403:
            return HttpException(code: statusCode, msg: '服务器拒绝执行');
            break;
          case 404:
            return HttpException(code: statusCode, msg: '无法连接服务器');
            break;
          case 500:
            return HttpException(code: statusCode, msg: '服务器内部错误');
            break;
          case 502:
            return HttpException(code: statusCode, msg: '无效的请求');
            break;
          case 503:
            return HttpException(code: statusCode, msg: '服务器挂了');
            break;
          case 505:
            return HttpException(code: statusCode, msg: '不支持HTTP协议请求');
            break;
          default:
            return HttpException(
              code: statusCode,
              msg: error.response!.statusMessage!,
            );
        }
        break;
      default:
        return HttpException(code: 500, msg: error.message);
    }
  }
}
