import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_companionm/core/data/todo.dart';

void _addNewNote(BuildContext context) async {
  final titleController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'Enter Note'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final todo = Todo(title: titleController.text, mod: null);
              Hive.box<Todo>('notes').add(todo);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
