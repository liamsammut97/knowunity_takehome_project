import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_project/dio/api_client.dart';
import 'package:knowunity_project/src/features/todos/presentation/screens/todos_screen.dart';

void main() {
  ApiClient();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodosScreen(),
    );
  }
}
