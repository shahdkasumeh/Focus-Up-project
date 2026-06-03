import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class EmptyPostsWidget extends StatelessWidget {
  const EmptyPostsWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: Appcolor.yellowColor.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: Appcolor.navyColor,
                size: 38,
              ),
            ),
            const SizedBox(height: 17),
            const Text(
              "لا توجد منشورات بعد",
              style: TextStyle(
                color: Appcolor.navyColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "كوني أول شخص يشارك منشور مفيد",
              style: TextStyle(color: Color(0xFF8A94A6), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
