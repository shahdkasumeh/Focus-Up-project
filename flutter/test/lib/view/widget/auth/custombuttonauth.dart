import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Custombuttonauth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const Custombuttonauth({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        onPressed: onPressed,
        color: Appcolor.primary,
        textColor: Appcolor.scondary,
        child: Text(text),
      ),
    );
  }
}
