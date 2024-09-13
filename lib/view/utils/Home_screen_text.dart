import 'package:flutter/material.dart';

late final String title;
Widget text({required String title}) {
  return Text(
    "$title",
    style: TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.w500,
    ),
  );
}
