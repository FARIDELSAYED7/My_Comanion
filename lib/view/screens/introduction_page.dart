import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_companionm/view/utils/background_image.dart';
import 'package:my_companionm/view/screens/welcome_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      showNextButton: true,
      showDoneButton: true,
      showBackButton: true,
      back: const Text("Back", style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Text("Next", style: TextStyle(fontWeight: FontWeight.w600)),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      },
      pages: [
        PageViewModel(
          image: BackgroundImage(url: 'assets/images/anxiety.png'
          ),
          reverse: true,
          title: "Welcome to My Companion",
          body: "",
          decoration: PageDecoration(
            fullScreen: true,
            contentMargin: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.1),
            bodyAlignment: Alignment.bottomCenter,
            titleTextStyle: const TextStyle(
              color: Color.fromARGB(255, 6, 39, 23),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: const TextStyle(
              fontSize: 20,
            ),
            titlePadding: const EdgeInsets.all(10),
            bodyPadding: const EdgeInsets.only(bottom: 25),
          ),
        ),
        PageViewModel(
          image: BackgroundImage(url: 'assets/images/happy.png'),
          reverse: true,
          title: "Seek the calm within",
          body: '',
          decoration: const PageDecoration(
            fullScreen: true,
            contentMargin: EdgeInsets.only(top: 60, bottom: 120),
            bodyAlignment: Alignment.bottomCenter,
            titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 82, 39, 12),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            bodyTextStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            titlePadding: EdgeInsets.all(10),
            bodyPadding: EdgeInsets.only(bottom: 0),
          ),
        ),
        PageViewModel(
          image: BackgroundImage(url: 'assets/images/pepole.png'),
          reverse: true,
          title: "Your journey to well-being starts here.",
          body: "",
          decoration: const PageDecoration(
            fullScreen: true,
            contentMargin: EdgeInsets.only(top: 100, bottom: 160),
            bodyAlignment: Alignment.bottomCenter,
            titleTextStyle: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w700, color: Colors.black),
            bodyTextStyle: TextStyle(
              color: Color(0xff8A73FF),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            titlePadding: EdgeInsets.all(20),
            bodyPadding: EdgeInsets.only(bottom: 0),
          ),
        ),
      ],
    );
  }
}
