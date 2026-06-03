import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class PostsSummaryCard extends StatelessWidget {
  final int postsCount;

  const PostsSummaryCard({required this.postsCount});

  // static const Color navyColor = Color(0xFF172F4F);
  // static const Color yellowColor = Color(0xFFF4C542);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE9EDF3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: Appcolor.yellowColor.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(Icons.forum_rounded, color: Appcolor.navyColor, size: 23),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "مجتمع الطلاب",
                  style: TextStyle(
                    color: Appcolor.navyColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "اسأل، شارك، وتفاعل مع الآخرين",
                  style: TextStyle(color: Color(0xFF8792A5), fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: Appcolor.navyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "$postsCount منشور",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}