import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_companionm/core/data/todo.dart';
import 'package:intl/intl.dart'; // Add this import

class NoteSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final box = Hive.box<Todo>('notes');
    final results = box.values.where((note) {
      final titleMatch = note.title.contains(query);
      final dateMatch = note.mod != null &&
          DateFormat('dd MMM yyyy').format(note.mod!).contains(query);
      return titleMatch || dateMatch;
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final note = results[index];
        return ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(note.title),
          subtitle: Text(note.mod == null
              ? ""
              : DateFormat('dd MMM yyyy, kk:mm').format(note.mod!)),
          onTap: () {
            // Handle note tap
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // You can implement suggestions if needed
  }
}
