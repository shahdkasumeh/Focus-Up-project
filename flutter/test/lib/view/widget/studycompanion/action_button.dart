import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool isLiked;

  const ActionButton({
    required this.icon,
    required this.text,
    required this.onTap,
    this.isLiked = false,
  });

  static const Color navyColor = Color(0xFF172F4F);
  static const Color borderColor = Color(0xFFE9EDF3);

  @override
  Widget build(BuildContext context) {
    final Color activeColor = isLiked ? const Color(0xFFE05263) : navyColor;
    final Color buttonColor = isLiked
        ? const Color(0xFFE05263).withValues(alpha: 0.07)
        : const Color(0xFFF7F8FB);

    final Color currentBorderColor = isLiked
        ? const Color(0xFFE05263).withValues(alpha: 0.18)
        : borderColor;

    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: currentBorderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 19, color: activeColor),
              const SizedBox(width: 7),
              Text(
                text,
                style: TextStyle(
                  color: activeColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
