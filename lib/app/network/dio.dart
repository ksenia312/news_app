import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'app_config.dart';

abstract class DioRegister {
  static Dio get dio {
    final instance = Dio(
      BaseOptions(
        baseUrl: AppConfig.newsBaseUrl,
      ),
    );

    instance.interceptors.add(const DioAuthInterceptor());
    if (kDebugMode) {
      instance.interceptors.add(
        LogInterceptor(requestBody: true),
      );
    }

    return instance;
  }
}

class DioAuthInterceptor extends Interceptor {
  const DioAuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final updatedOptions = options.copyWith(
      headers: {
        'Authorization': 'Bearer ${AppConfig.newsApiKey}',
      },
    );
    super.onRequest(updatedOptions, handler);
  }
}
