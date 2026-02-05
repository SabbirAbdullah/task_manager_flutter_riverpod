import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../shared/di/storage/hive_service.dart';
import '../../constants/api_constants.dart';


final dioProvider = Provider<Dio>((ref) {
  final token = HiveService.getToken();

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: false,
        maxWidth: 120,
      ),
    );
  }

  return dio;
});
