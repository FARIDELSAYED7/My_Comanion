import 'package:flutter/material.dart';

class EmojiPopup extends StatelessWidget {
  const EmojiPopup({Key? key, required this.message, required this.image})
      : super(key: key);
  final String message;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                height: 140,
                child: Column(
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),
                  ],
                ),
              )),
        );
      },
      child: Image.asset(
        image,
        width: 55,
      ),
    );
  }
}
