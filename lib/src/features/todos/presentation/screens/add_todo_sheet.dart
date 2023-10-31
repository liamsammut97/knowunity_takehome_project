import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_project/src/features/todos/presentation/controllers/todos_controller.dart';

class AddTodoSheet extends ConsumerWidget {
  final TextEditingController textEditingController = TextEditingController();
  AddTodoSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosController = ref.watch(todosControllerProvider);
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Todo",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(hintText: "Enter Todo Title"),
            ),
            const SizedBox(height: 100),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    await _onAddTodo(ref, context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  child: todosController.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Add Todo"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onAddTodo(WidgetRef ref, BuildContext context) async {
    await ref
        .read(todosControllerProvider.notifier)
        .createTodo(textEditingController.text, ref)
        .then(
      (isSuccessfull) {
        if (isSuccessfull) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Todo Added Successfuly",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          );
        }
        Navigator.pop(context);
      },
    );
  }
}
