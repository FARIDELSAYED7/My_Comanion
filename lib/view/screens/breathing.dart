import 'package:flutter/material.dart';

class Breathing extends StatelessWidget {
  const Breathing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/breathing.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}