
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/network/dio/dio_provider.dart';
import '../data/model/todo_model.dart';
import '../data/repositories/todo_repository.dart';
import '../data/remote/todo_remote_datasource.dart';



final todoViewModelProvider =
StateNotifierProvider<TodoViewModel, List<TodoModel>>((ref) {
  final dio = ref.read(dioProvider);
  return TodoViewModel(TodoRepository(TodoRemoteDataSource(dio)));
});

class TodoViewModel extends StateNotifier<List<TodoModel>> {
  final TodoRepository repo;
  TodoViewModel(this.repo) : super([]);

  bool isLoading = false; // ✅ track loading

  Future<void> loadTodos() async {
    isLoading = true; // start loading
    try {
      final todos = await repo.fetchTodos();
      state = todos;
    } catch (e) {
      // handle error if needed
    } finally {
      isLoading = false; // stop loading
    }
  }

  Future<void> addTodo(String title) async {
    isLoading = true;
    try {
      await repo.addTodo(title);
      await loadTodos(); // refresh after add
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteTodo(int id) async {
    isLoading = true;
    try {
      await repo.deleteTodo(id);
      await loadTodos(); // refresh after delete
    } finally {
      isLoading = false;
    }
  }
}
