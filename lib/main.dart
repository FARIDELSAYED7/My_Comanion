import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_companionm/core/gemini/consts.dart';
import 'package:my_companionm/core/data/todo.dart';
import 'package:my_companionm/view/screens/introduction_page.dart';

main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapter
  Hive.registerAdapter(TodoAdapter());

  // Open box
  await Hive.openBox<Todo>('todos');
  await Hive.openBox<Todo>('notes');
  await Hive.openBox<Todo>('moods');

  runApp(MyCompanion());
}

class MyCompanion extends StatelessWidget {
  const MyCompanion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: IntroductionPage());
  }
}
