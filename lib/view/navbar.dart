import 'package:flutter/material.dart';
import 'package:my_companionm/view/screens/ai_chat_screen.dart';
import 'package:my_companionm/view/screens/audio_list_screen.dart';
import 'package:my_companionm/view/screens/home_screen.dart';
import 'package:my_companionm/view/screens/mange_breeth.dart';
import 'package:my_companionm/view/screens/notes_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({
    super.key,
  });
  @override
  State<NavBarScreen> createState() => _NavBarState();
}

class _NavBarState extends State<NavBarScreen> {
  int _selectedIndex = 0;
  void _onItemTap(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  List<Widget> get _screens => [
        const HomeScreen(),
        const NotesScreen(),
        const AiChatScreen(),
        BreathScreen(),
        AudioListScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: "Notes"),
          BottomNavigationBarItem(icon: Icon(Icons.assistant), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.nights_stay), label: "Breath"),
          BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack), label: "Audios"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: Colors.deepOrange,
      ),
    );
  }
}
