import 'dart:convert';
import 'package:knowunity_project/constants.dart';
import 'package:knowunity_project/dio/api_client.dart';
import 'package:knowunity_project/src/features/todos/domain/todos.dart';

class GetTodosService {
  static Future<List<Todos>> getTodos() async {
    final response = await ApiClient.dio.get("${Constants.baseUrl}/todos");
    return todosFromJson(jsonEncode(response.data));
  }
}
