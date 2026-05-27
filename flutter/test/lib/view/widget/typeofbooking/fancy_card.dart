import 'package:flutter/material.dart';

class FancyCard extends StatelessWidget {
  final IconData? icon;
  final String title;
    final Widget? child;

  const FancyCard({super.key, this.icon, required this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          child!,
        ],
      ),
    );
  }
}
