import 'package:flutter/material.dart';
import 'package:test/controller/home/luckywheel_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class TabButton extends StatelessWidget {
  final String title;
  final int index;
  final LuckyWheelControllerImp controller;

  const TabButton({
    super.key,
    required this.title,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectedTab.value = index;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: isSelected ? Appcolor.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFF1A3A5C) : Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
