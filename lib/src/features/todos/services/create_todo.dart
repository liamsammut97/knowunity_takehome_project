import 'package:knowunity_project/constants.dart';
import 'package:knowunity_project/dio/api_client.dart';
import 'package:knowunity_project/src/features/todos/domain/todos.dart';

class CreateTodoService {
  static Future<Todos> createTodo(Todos todo) async {
    final repsonse = await ApiClient.dio.post(
      "${Constants.baseUrl}/todos",
      data: todo.toJson(),
    );
    return todoFromJson(repsonse.toString());
  }
}
