import 'package:dio/dio.dart';
import 'package:moth_movie/config/http_options.dart';

import 'http_interceptor.dart';

// http 请求单例类
class HttpRequest {
  // 工厂构造方法
  factory HttpRequest() => _instance;
  // 初始化一个单例实例
  static final HttpRequest _instance = HttpRequest._internal();
  // dio 实例
  Dio? dio;
  // 内部构造方法
  HttpRequest._internal() {
    if (dio == null) {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions baseOptions = BaseOptions(
        baseUrl: HttpOptions.BASE_URL,
        connectTimeout: HttpOptions.CONNECT_TIMEOUT,
        receiveTimeout: HttpOptions.RECEIVE_TIMEOUT,
        headers: {},
      );
      // 没有实例 则创建之
      dio = new Dio(baseOptions);
      // 添加拦截器
      dio!.interceptors.add(HttpInterceptor());
    }
  }

  // 初始化公共属性 如果需要覆盖原配置项 就调用它
  //
  // [baseUrl] 地址前缀
  // [connectTimeout] 连接超时赶时间
  // [receiveTimeout] 接收超时赶时间
  // [headers] 请求头
  // [interceptors] 基础拦截器
  void init({
    String? baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio!.options.baseUrl = baseUrl!;
    dio!.options.connectTimeout = connectTimeout!;
    dio!.options.receiveTimeout = receiveTimeout!;
    dio!.options.headers = headers;
    if (interceptors != null && interceptors.isNotEmpty) {
      dio!.interceptors..addAll(interceptors);
    }
  }

  // 设置请求头
  void setHeaders(Map<String, dynamic> headers) {
    dio!.options.headers.addAll(headers);
  }

  CancelToken _cancelToken = new CancelToken();
  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求
   * 当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  // 设置鉴权请求头
  Options setAuthorizationHeader(Options requestOptions) {
    String? _token;
    if (_token != null) {
      requestOptions.headers!['token'] = _token;
    }
    return requestOptions;
  }

  // restful get 操作
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());

    Response response = await dio!.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  // restful post 操作
  Future post(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());

    Response response = await dio!.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  // restful post form 表单提交操作
  Future postForm(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());

    Response response = await dio!.post(
      path,
      data: FormData.fromMap(params!),
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }
}
