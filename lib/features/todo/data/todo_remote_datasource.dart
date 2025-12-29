import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';

import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';

class TodoRemoteDataSource {
  final Dio dio;
  TodoRemoteDataSource(this.dio);

  Future<Response> getTodos() => dio.get(ApiConstants.todos);

  Future<Response> createTodo(String title) =>
      dio.post(ApiConstants.todos, data: {'title': title});

  Future<Response> deleteTodo(int id) =>
      dio.delete('${ApiConstants.todos}/$id');
}
