import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/luckywheel_controller.dart';
import 'package:test/view/widget/luckywheel/info_card_lucky_wheel.dart';
import 'package:test/view/widget/luckywheel/wheelpainter.dart';

class WheelTab extends StatelessWidget {
  final LuckyWheelControllerImp controller;

  const WheelTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(height: 15),

          // ---------------- WHEEL ----------------
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedRotation(
                  turns: controller.turns.value,
                  duration: const Duration(milliseconds: 4200),
                  curve: Curves.easeOutCubic,
                  child: Container(
                    width: 310,
                    height: 310,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: WheelPainter(prizes: controller.prizes.toList()),
                    ),
                  ),
                ),

                // 🔻 Pointer
                Positioned(
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 6),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF0B2A45),
                      size: 28,
                    ),
                  ),
                ),

                // ⭐️ Center
                Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Colors.white, Color(0xFF0B2A45)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ---------------- BUTTON ----------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed:
                    (controller.canSpin.value &&
                        !controller.isSpinning.value &&
                        controller.prizes.isNotEmpty)
                    ? controller.spin
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white.withValues(alpha: 0.25),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: controller.isSpinning.value
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF0B2A45),
                        ),
                      )
                    : Text(
                        controller.canSpin.value
                            ? "لف العجلة 🎯"
                            : "أكمل الشروط أولاً",
                        style: const TextStyle(
                          color: Color(0xFF0B2A45),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ---------------- INFO ----------------
          InfoCardLuckyWheel(
            title: 'الحجوزات المكتملة',
            value: controller.completedBookings.value.toString(),
          ),

          const SizedBox(height: 10),

          InfoCardLuckyWheel(
            title: 'المتبقي',
            value: controller.remainingBookings.value.toString(),
          ),

          const SizedBox(height: 14),

          // ---------------- STATUS ----------------
          Text(
            controller.canSpin.value
                ? 'جاهز للفوز 🎉'
                : 'أكمل الحجوزات المطلوبة',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
