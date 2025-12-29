import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';

class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource(this.dio);

  Future<Response> login(String email, String password) {
    return dio.post(ApiConstants.login, data: {
      'email': email,
      'password': password,
    });
  }

  Future<Response> register(Map<String, dynamic> data) {
    return dio.post(ApiConstants.register, data: data);
  }

  Future<Response> forgetPassword(
      String email, String currentPassword, String newPassword) {
    return dio.put(ApiConstants.forgetPassword, data: {
      'email': email,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
  }
}
