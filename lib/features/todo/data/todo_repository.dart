import '../model/todo_model.dart';
import 'todo_remote_datasource.dart';

class TodoRepository {
  final TodoRemoteDataSource remote;
  TodoRepository(this.remote);

  Future<List<TodoModel>> fetchTodos() async {
    final res = await remote.getTodos();
    return (res.data as List)
        .map((e) => TodoModel.fromJson(e))
        .toList();
  }

  Future<void> addTodo(String title) async {
    await remote.createTodo(title);
  }

  Future<void> deleteTodo(int id) async {
    await remote.deleteTodo(id);
  }
}
