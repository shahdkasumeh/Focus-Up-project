import 'package:flutter/material.dart';
import 'package:test/controller/home/luckywheel_controller.dart';
import 'package:test/view/widget/luckywheel/empty_box_wheel.dart';

class CurrentPrizeTab extends StatelessWidget {
  final LuckyWheelControllerImp controller;
  const CurrentPrizeTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final discounts = controller.currentPrizes
        .where((item) => item.name.toLowerCase().trim() == 'discount')
        .toList();

    if (discounts.isEmpty) {
      return EmptyBoxWheel(text: 'لا يوجد خصم حالي');
    }
    return Column(
      children: discounts.map((item) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.local_offer_rounded,
                color: Color(0xFFF5A623),
                size: 44,
              ),
              const SizedBox(height: 14),
              const Text(
                'الخصم الحالي',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 14),
              Text(
                item.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
