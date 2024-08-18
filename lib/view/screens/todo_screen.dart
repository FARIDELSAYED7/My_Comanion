import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_companionm/core/data/todo.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) async {
    final titleController = TextEditingController();
    await showDialog(
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
}

class _TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Todo>('todos').listenable(),
      builder: (context, Box<Todo> box, _) {
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            final todo = box.getAt(index)!;
            return ListTile(
              title: Text(todo.title),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      todo.isCompleted = value!;
                      box.putAt(index, todo);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.red),
                    onPressed: () => _showEditDialog(context, todo),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Todo todo) async {
    final titleController = TextEditingController(text: todo.title);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Edit todo'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todo.title = titleController.text;
                todo.save();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
