import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final int maxLines;

  const TaskTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
  });
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
          color: Appcolor.hintColor,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: Icon(
          icon,
          color:Appcolor.navyColor.withValues(alpha: 0.58),
          size: 20,
        ),
        filled: true,
        fillColor: Appcolor.fieldColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: maxLines > 1 ? 15 : 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Appcolor.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Appcolor.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Appcolor.yellowColor, width: 1.5),
        ),
      ),
    );
  }
}
