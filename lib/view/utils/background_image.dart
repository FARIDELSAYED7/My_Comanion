import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String url;
  const BackgroundImage({super.key,required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class BackgroundPhoto extends StatelessWidget {
  const BackgroundPhoto({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Image.asset(
            path,
            fit: BoxFit.cover,
          ),
        ),  ],
    );
  }
}
