import 'package:flutter/material.dart';

class Custombodytitle extends StatelessWidget {
  final String text;
  const Custombodytitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
    );
  }
}
