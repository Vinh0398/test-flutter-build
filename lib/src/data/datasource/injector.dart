import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

final dioProvider = Provider(create: (_) {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor());
  return dio;
});