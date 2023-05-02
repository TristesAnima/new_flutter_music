import 'package:dio/dio.dart';

class Request {
  static Dio dio = Dio();
  static String domain = 'http://81.68.248.232:3000';

  static String clipImg(String url, {int? x = 200, int? y = 200}) => '$url?param=${x}y$y';

  Request() {
    dio.options.baseUrl = domain;
    dio.interceptors.add(RequestInterceptor());
  }

  Future<Response<dynamic>?> get(String url, {Map<String, dynamic>? body}) async {
    try {
      var response = await dio.get(url, queryParameters: body);
      return response;
    } catch (err) {
      print("请求超时");
      return null;
    }
  }

  Future<Response<dynamic>?> post(String url, {Map<String, dynamic>? body}) async {
    try {
      var response = await dio.post(url, data: body);
      return response;
    } catch (err) {
      print("请求超时");
      return null;
    }
  }
}

/// Dio请求拦截器
class RequestInterceptor extends Interceptor {
  RequestInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method.toLowerCase() == 'get') {
      options.headers['cookie'] =
          'NMTID=00O1srolB4MDKlJ2EcOtEFcQNU1dTEAAAGH3Y1Afw; MUSIC_U=6cc85655d119c3ca32225277ee2bc1479600f8e2889ce97b5b0e562fd470516c2db2b902059571882268cf5ba262ec9f0b3e648100a125b94a64710efc3b4adae210945e6abec38ad4dbf082a8813684; __csrf=cfa01a9db09b66c50e8c01530d9ba25a';
      options.queryParameters = {
        '_t': DateTime.now().millisecondsSinceEpoch,
        ...options.queryParameters,
      };
    }
    if (options.method.toLowerCase() == 'post') {
      options.data = {'_t': DateTime.now().millisecondsSinceEpoch, ...options.data as Map};
    }
    super.onRequest(options, handler);
  }
}
