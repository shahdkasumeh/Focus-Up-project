import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class SelectFieldProfile extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final VoidCallback onTap;

  const SelectFieldProfile({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Appcolor.scondary),
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.grey,
        ),
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