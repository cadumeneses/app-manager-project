import 'dart:io';

import 'package:dio/dio.dart';

class DioClient {
  var dio = Dio(
    BaseOptions(
        baseUrl:
            'https://taskforce-47f99-default-rtdb.firebaseio.com/',
        connectTimeout: 5000,
        receiveTimeout: 5000,
        validateStatus: (int? status) {
          return status != null && status > 0;
        },
        headers: {
          HttpHeaders.userAgentHeader: 'dio',
          'common-header': 'xx',
        },
        contentType: 'application/json'),
  );
}