import 'dart:io';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

final dioProvider = Provider(create: (_) {
  final dio = Dio();
  Dio tokenDio = Dio();
  // var appConfig = GetItUtil().sl.get<AppConfigService>().getAppConfig();
  dio.interceptors.add(LogInterceptor());
  dio.options.headers["Accept-Language"] = "en-VN;q=1.0, vi-VN;q=0.9, en-GB;q=0.8";
  dio.options.headers["Accept-Encoding"] = "gzip;q=1.0, compress;q=0.5";
  dio.options.headers["User-Agent"] = "OnWheel_Supplier onWheelSTG/10.3 (com.ahamove.onWheelSTG; build:2; iOS 15.7.9) Alamofire/5.9.1";
  dio.options.headers["Accepts-Version"] = "2";

  dio.interceptors.add(QueuedInterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }, onError: (DioException error, ErrorInterceptorHandler errorHandler) async {
    // final refreshToken = appConfig.refreshToken;
    if (error.response?.statusCode == 401) {
      //Refresh token
      try {
        final response = await tokenDio.post(
            '/api/v3/public/supplier/token/refresh',
            data: {
              'refresh_token': "",
              'mobile': "",
              'type': Platform.isAndroid ? 'android' : 'ios'
            },
            options: Options(
                headers: {
                  "User-Agent": "OnWheel_Supplier onWheelSTG/10.3 (com.ahamove.onWheelSTG; build:2; iOS 15.7.9) Alamofire/5.9.1"
                }
            )
        );
        if (response.statusCode == 200) {
          final _token = response.data['token'];
          final _refreshToken = response.data['refresh_token'];
          // appConfig = GetItUtil().sl.get<AppConfigService>().refreshToken(token: _token, refreshToken: _refreshToken);
          error.requestOptions.headers["Authorization"] = "Bearer ";
          final opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final cloneReq = await dio.request(error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);

          return errorHandler.resolve(cloneReq);
        } else {
          return errorHandler.reject(
            DioException(requestOptions: error.requestOptions),
          );
        }
      } catch (e) {
        return errorHandler.reject(
          DioException(requestOptions: error.requestOptions),
        );
      }
    }
    return errorHandler.next(error);
  }));

  return dio;
});