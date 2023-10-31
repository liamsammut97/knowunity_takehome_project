import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_project/src/features/todos/data/todos_repo.dart';
import 'package:knowunity_project/src/features/todos/domain/todos.dart';

final todosControllerProvider =
    StateNotifierProvider.autoDispose<TodosController, AsyncValue<Todos?>>(
        (ref) {
  final todosRepository = ref.watch(todosRepositoryProvider);
  return TodosController(todosRepository: todosRepository);
});

class TodosController extends StateNotifier<AsyncValue<Todos?>> {
  TodosController({required this.todosRepository})
      : super(const AsyncValue<Todos?>.data(null));

  TodosRepository todosRepository;

  Future<bool> createTodo(String todoTitle, WidgetRef ref) async {
    try {
      state = const AsyncValue.loading();

      final Todos todo = Todos(
          userId: 1,
          id: Random().nextInt(100),
          title: todoTitle,
          completed: false);

      final response = await todosRepository.createTodo(todo);

      // if we were using a real api once below line of code runs
      // we would see newly added todo
      ref.invalidate(todosFutureProvider);
      state = AsyncValue.data(response);
      return true;
    } catch (err) {
      state = AsyncValue.error(err, StackTrace.current);
      return false;
    }
  }

  // here we would add more functions like updating a todo
  // deleting a todo etc

  // using a controller with these methods gives us flexibilty to create more complex functions if needed
  // also handling errors and loading states also becomes very simple
}
