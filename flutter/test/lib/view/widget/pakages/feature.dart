import 'package:flutter/widgets.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Feature extends StatelessWidget {
  final String text;
  final IconData icon;
  const Feature({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Icon(icon, color: Appcolor.scondary, size: 20),
        ],
      ),
    );
  }
}