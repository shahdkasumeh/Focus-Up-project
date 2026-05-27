import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class FieldProfile extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  const FieldProfile({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Appcolor.scondary),
        filled: true,
        fillColor: const Color(0xffF7F8FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}