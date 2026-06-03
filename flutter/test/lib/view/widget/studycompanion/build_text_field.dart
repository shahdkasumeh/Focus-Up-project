import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final int maxLines;

  const BuildTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.maxLines = 1,
  });

  static const Color navyColor = Color(0xFF172F4F);
  static const Color yellowColor = Color(0xFFF4C542);
  static const Color fieldColor = Color(0xFFF7F8FB);
  static const Color borderColor = Color(0xFFE4E8F0);
  static const Color hintColor = Color(0xFF98A1B2);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: const TextStyle(
        color: Appcolor.navyColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: hintColor,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(
            prefixIcon,
            color: Appcolor.navyColor.withValues(alpha: 0.55),
            size: 20,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 43,
          minHeight: 43,
        ),
        filled: true,
        fillColor: fieldColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 13,
          vertical: maxLines > 1 ? 15 : 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: yellowColor, width: 1.5),
        ),
      ),
    );
  }
}
