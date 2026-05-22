import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LuckyWheelDialog extends StatelessWidget {
  final String prize;

  const LuckyWheelDialog({
    super.key,
    required this.prize,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.14),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withOpacity(.25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.celebration_rounded,
              color: Color(0xFFF5A623),
              size: 58,
            ),

            const SizedBox(height: 16),

            const Text(
              "مبروك 🎉",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              prize,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFF5A623),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5A623),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}