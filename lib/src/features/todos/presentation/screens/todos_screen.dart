import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_project/src/features/todos/data/todos_repo.dart';
import 'package:knowunity_project/src/features/todos/domain/todos.dart';
import 'package:knowunity_project/src/features/todos/presentation/controllers/todos_controller.dart';
import 'package:knowunity_project/src/features/todos/presentation/screens/add_todo_sheet.dart';
import 'package:knowunity_project/src/features/todos/presentation/widgets/page_title.dart';
import 'package:knowunity_project/src/features/todos/presentation/widgets/rounded_button.dart';

class TodosScreen extends ConsumerWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosFutureProvider);

// the below is being used to display an error if there is an issue submiting a todo
    ref.listen<AsyncValue<Todos?>>(todosControllerProvider,
        ((previousState, state) {
      if (!state.isRefreshing && state.hasError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error.toString())));
      }
    }));

    return Scaffold(
      floatingActionButton: RoundedButton(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) {
              return AddTodoSheet();
            },
          );
        },
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(),
            todos.when(
              data: (todos) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      Todos todo = todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: todo.completed
                            ? const Text(
                                "Completed",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
                              )
                            : const Text(
                                "Not Completed",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.amber),
                              ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                );
              },
              error: ((error, stackTrace) {
                // here i would create a widget called ErrorText
                // this would handle the status codes and return a friendly custom error message
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      error.toString(),
                    ),
                  ),
                );
              }),
              loading: () {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
