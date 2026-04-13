import 'package:flutter/material.dart';

class Customtitleauth extends StatelessWidget {
  final String text;
  const Customtitleauth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.grey,
      ),
    );
  }
}
