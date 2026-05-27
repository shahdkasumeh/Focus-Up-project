import 'package:flutter/material.dart';

class EmptyBoxWheel extends StatelessWidget {
  final String text;
  const EmptyBoxWheel({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}