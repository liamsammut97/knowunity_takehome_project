import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_project/src/features/todos/domain/todos.dart';
import 'package:knowunity_project/src/features/todos/services/create_todo.dart';
import 'package:knowunity_project/src/features/todos/services/get_todos.dart';

final todosRepositoryProvider = Provider.autoDispose<TodosRepository>((ref) {
  return TodosRepository();
});

// since get request is not complex i opted to use a light FutureProvider
final todosFutureProvider = FutureProvider<List<Todos>>((ref) {
  return ref.read(todosRepositoryProvider).getTodos();
});

class TodosRepository {
  Future<List<Todos>> getTodos() async {
    try {
      final response = await GetTodosService.getTodos();

      return response;
    } catch (err) {
      rethrow;
    }
  }

  Future<Todos> createTodo(Todos todo) async {
    try {
      final response = await CreateTodoService.createTodo(todo);

      return response;
    } catch (err) {
      rethrow;
    }
  }
}
