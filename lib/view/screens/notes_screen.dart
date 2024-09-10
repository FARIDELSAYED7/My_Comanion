import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_companionm/core/data/todo.dart';
import 'package:my_companionm/view/screens/note_search_delegate.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Set the background color to white
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Notes",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: NoteSearchDelegate());
                    },
                  ),
                ],
              ),
              Expanded(
                child: ValueListenableBuilder<Box<Todo>>(
                  valueListenable: Hive.box<Todo>('notes').listenable(),
                  builder: (context, box, _) {
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final notes = box.getAt(index)!;
                        return _buildNoteCard(context, notes, index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addNewNote(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, Todo note, int index) {
    return Card(
      color: Colors.grey[200],
      elevation: 4,
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.mod == null
            ? ""
            : DateFormat('dd MMM yyyy, kk:mm').format(note.mod!)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editNote(context, note),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Hive.box<Todo>('notes').deleteAt(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addNewNote(BuildContext context) async {
    final titleController = TextEditingController();
    DateTime? dateTime;

    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter note',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final newDateTime = await showDatePicker(
                    context: context,
                    initialDate: dateTime ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (newDateTime != null) {
                    dateTime = newDateTime;
                  }
                },
                child: Text(dateTime == null
                    ? 'Enter date'
                    : '${dateTime!.day}/${dateTime!.month}/${dateTime!.year}'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (dateTime == null) return;
                final todo = Todo(
                  title: titleController.text,
                  mod: DateTime(
                      dateTime!.year, dateTime!.month, dateTime!.day, 0, 0),
                );

                Hive.box<Todo>('notes').add(todo);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
    if (result != null) {
      Navigator.pop(context);
    }
  }

  Future<void> _editNote(BuildContext context, Todo note) async {
    final titleController = TextEditingController(text: note.title);
    DateTime? dateTime = note.mod;

    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: const Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLines: null,
                minLines: null,
                autofocus: true,
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Edit note',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final newDateTime = await showDatePicker(
                    context: context,
                    initialDate: dateTime ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (newDateTime != null) {
                    dateTime = DateTime.now();
                  }
                },
                child: Text(dateTime == null
                    ? 'Edit date'
                    : '${dateTime!.day}/${dateTime!.month}/${dateTime!.year}'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (dateTime == null) return;
                final todo = Todo(
                  title: titleController.text,
                  mod: DateTime(
                      dateTime!.year, dateTime!.month, dateTime!.day, 0, 0),
                );

                final box = Hive.box<Todo>('notes');
                final index = box.values.toList().indexOf(note);
                if (index >= 0) {
                  box.putAt(index, todo);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (result != null) {
      Navigator.pop(context);
    }
  }
}
