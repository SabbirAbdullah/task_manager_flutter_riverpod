import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/todo_viewmodel.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';
import 'package:go_router/go_router.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  final ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(todoViewModelProvider.notifier).loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoViewModelProvider);
    final todoVM = ref.read(todoViewModelProvider.notifier);
    final isLoading = todoVM.isLoading; // ✅ check loading

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todos'),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => _showProfileDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authViewModelProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Input field + Add button
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ctrl,
                          decoration: const InputDecoration(
                            hintText: 'Add new todo...',
                            border: InputBorder.none,
                          ),
                          enabled: !isLoading,
                        ),
                      ),
                      isLoading
                          ? const CircularProgressIndicator()
                          : IconButton(
                        icon: const Icon(Icons.add, color: Colors.blueAccent),
                        onPressed: () async {
                          final text = ctrl.text.trim();
                          if (text.isEmpty) return;
                          await todoVM.addTodo(text);
                          ctrl.clear();
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Todo list or loading indicator
              Expanded(
                child: isLoading && todos.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : todos.isEmpty
                    ? Center(
                  child: Text(
                    'No todos yet',
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: 16),
                  ),
                )
                    : ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (_, i) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 0),
                    child: ListTile(
                      title: Text(
                        todos[i].title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: IconButton(
                        icon:
                        const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => todoVM.deleteTodo(todos[i].id),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Profile'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('John Doe'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('johndoe@example.com'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
