import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const DateField({required this.controller, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: const TextStyle(
        color: Appcolor.navyColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: "تاريخ المهمة",
        hintStyle: const TextStyle(color: Appcolor.hintColor, fontSize: 13),
        suffixIcon: const Icon(
          Icons.calendar_month_rounded,
          color: Appcolor.navyColor,
          size: 21,
        ),
        filled: true,
        fillColor: Appcolor.fieldColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
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
