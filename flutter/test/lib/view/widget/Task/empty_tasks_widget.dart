import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class EmptyTasksWidget extends StatelessWidget {
  const EmptyTasksWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: Appcolor.yellowColor.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.assignment_turned_in_outlined,
              color: Appcolor.navyColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            "لا توجد مهام بهذا التاريخ",
            style: TextStyle(
              color: Appcolor.navyColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            "أضيفي مهمة جديدة لليوم المحدد",
            style: TextStyle(color: Color(0xFF8A94A6), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
