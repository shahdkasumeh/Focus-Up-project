import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Textfocusup extends StatelessWidget {
  const Textfocusup({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Focus',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Appcolor.scondary,
            ),
          ),
          TextSpan(
            text: 'Up',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Appcolor.primary,
            ),
          ),
        ],
      ),
    );
  }
}
