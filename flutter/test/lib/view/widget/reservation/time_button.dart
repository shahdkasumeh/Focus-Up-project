import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class TimeButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Widget child;

  const TimeButton({
    required this.icon,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Appcolor.scondary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 19),
          const SizedBox(width: 5),
          Flexible(child: child),
        ],
      ),
    );
  }
}
