import 'package:flutter/material.dart';

import '../../view/navbar.dart';
import '../../view/utils/background_image.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WelcomeImage(),
              SizedBox(height: 40),
              WelcomeTitle(),
              SizedBox(height: 10),
              WelcomeDescription(),
              SizedBox(height: 40),
              GetStartedButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundPhoto(path: 'assets/images/welcomeimage.png');
  }
}

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Companion',
      style: Theme.of(context).textTheme.headlineLarge,
      textAlign: TextAlign.center,
    );
  }
}

class WelcomeDescription extends StatelessWidget {
  const WelcomeDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'This is your place to get rid of stress and anxiety through different ways of relaxing',
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NavBarScreen()));
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 18),
        backgroundColor: const Color.fromARGB(255, 245, 134, 6),
      ),
      child: const Text(
        'Get Started',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
      ),
    );
  }
}
