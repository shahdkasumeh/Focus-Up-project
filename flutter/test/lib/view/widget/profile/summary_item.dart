import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const SummaryItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Appcolor.scondary, size: 22),
        const SizedBox(height: 7),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF172F4F),
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}


