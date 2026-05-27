import 'package:flutter/material.dart';
import 'package:test/controller/home/luckywheel_controller.dart';
import 'package:test/view/widget/luckywheel/tab_button.dart';

class TabsWheel extends StatelessWidget {
  final LuckyWheelControllerImp controller;
  const TabsWheel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          TabButton(title: 'العجلة', index: 0, controller: controller),
          TabButton(title: 'الجوائز', index: 1, controller: controller),
          TabButton(title: 'الخصم الحالي', index: 2, controller: controller),
        ],
      ),
    );
  }
}
