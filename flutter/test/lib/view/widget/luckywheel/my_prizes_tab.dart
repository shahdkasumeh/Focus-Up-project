import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:test/controller/home/luckywheel_controller.dart';
import 'package:test/view/widget/luckywheel/empty_box_wheel.dart';

class MyPrizesTab extends StatelessWidget {
  final LuckyWheelControllerImp controller;

  const MyPrizesTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.myPrizes.isEmpty) {
      return const EmptyBoxWheel(text: 'لا يوجد الجوائز حصلت عليها بعد');
    }

    return Obx(
      () => Column(
        children: [
          ...controller.myPrizes.map<Widget>((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_offer_rounded,
                    color: Colors.white,
                    size: 22,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Text(
                    item.value,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
