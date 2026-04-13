import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:test/controller/home/luckywheel_controller.dart';
import 'package:test/view/widget/luckywheel/wheelpainter.dart';

class LuckywheelScreen extends StatelessWidget {
  const LuckywheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LuckyWheelControllerImp controller = Get.put(LuckyWheelControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xFF1A3A5C),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),

          onPressed: () => Get.back(),
        ),

        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'عجلة الحظ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            '!دوّر العجلة مرة واحدة هذا الأسبوع',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 32),

          // Wheel
          Center(
            child: Obx(
              () => AnimatedRotation(
                turns: controller.turns.value,
                duration: const Duration(seconds: 3),
                curve: Curves.easeOutBack,
                child: SizedBox(
                  width: 260,
                  height: 260,
                  child: CustomPaint(painter: WheelPainter()),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Prize display
          Obx(
            () => controller.prize.value.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🎉 مبروك ربحت',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          controller.prize.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFF5A623),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
            child: Obx(
              () => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      controller.canSpin.value && !controller.isSpinning.value
                      ? controller.spin
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5A623),
                    disabledBackgroundColor: Colors.white.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    controller.isSpinning.value
                        ? 'جاري الدوران...'
                        : controller.canSpin.value
                        ? "دوّر العجلة"
                        : 'استخدمت دورتك هذا الأسبوع',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: controller.canSpin.value
                          ? const Color(0xFF1A3A5C)
                          : Colors.white38,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
