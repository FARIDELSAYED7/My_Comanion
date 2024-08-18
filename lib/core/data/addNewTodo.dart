import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_companionm/core/data/todo.dart';

void _addNewTodo(BuildContext context) async {
  final titleController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'Enter todo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final todo = Todo(title: titleController.text, mod: null);
              Hive.box<Todo>('todos').add(todo);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
