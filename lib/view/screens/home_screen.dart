import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_companionm/core/data/todo.dart';
import 'package:my_companionm/view/utils/Home_screen_text.dart';
import 'package:my_companionm/view/utils/emoji_popup.dart';

const String _goodMorning = "Good Morning";
const String _goodAfternoon = "Good Afternoon";
const String _goodEvening = "Good Evening";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimeOfDay.now().hour < 12
                  ? text(
                      title: _goodMorning,
                    )
                  : TimeOfDay.now().hour < 18
                      ? text(title: _goodAfternoon)
                      : text(title: _goodEvening),
              const Text(
                "How are you feeling today?",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EmojiPopup(
                        message:
                            "Express your anger healthily, without harming yourself or others.",
                        image: "assets/images/angry.png"),
                    SizedBox(
                      width: 15,
                    ),
                    EmojiPopup(
                        message:
                            "Strength doesn't mean you don't get hurt. It means you learn to cope.",
                        image: "assets/images/sad.png"),
                    SizedBox(
                      width: 15,
                    ),
                    EmojiPopup(
                        message:
                            "Embrace the ordinary moments. They're often the most precious.",
                        image: "assets/images/smile.png"),
                    SizedBox(
                      width: 15,
                    ),
                    EmojiPopup(
                        message:
                            "Let your smile change the world, but don't let the world change your smile.",
                        image: "assets/images/happyimo.png"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text(title: "To-Do List"),
                  IconButton(
                      onPressed: () {
                        _addNewTodo(context);
                      },
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: Colors.lightBlue,
                        size: 30,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                  future: Hive.openBox<Todo>('todos'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        final box = snapshot.data as Box<Todo>;
                        final todos = box.values.toList().cast<Todo>();
                        return ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return ListTile(
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: todo.isCompleted
                                        ? Colors.grey
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    decoration: todo.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null),
                              ),
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
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      box.deleteAt(index);
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _editTodo(context, todo),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No data'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
              titleController.text == ""
                  ? showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('You Must Add Todo'),
                          content: Text(todo.title),
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
                      })
                  : Hive.box<Todo>('todos').add(todo);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

void _editTodo(BuildContext context, Todo todo) async {
  final titleController = TextEditingController(text: todo.title);
  showDialog(
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

