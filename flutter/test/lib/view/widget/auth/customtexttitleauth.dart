import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Customtexttitleauth extends StatelessWidget {
  final String text;
  const Customtexttitleauth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Appcolor.scondary,
          fontSize: 30,
        ),
      ),
    );
  }
}
