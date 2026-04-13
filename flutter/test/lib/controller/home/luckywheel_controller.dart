import 'dart:math';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class LuckyWheelController extends GetxController {}

class LuckyWheelControllerImp extends LuckyWheelController {
  final turns = 0.0.obs;
  final canSpin = true.obs;
  final isSpinning = false.obs;
  final prize = ''.obs;

  final _prizes = [
    '50 نقطة',
    'خصم 10% على الباقة التالية',
    'حظ أوفر — حاول الأسبوع القادم!',
    '100 نقطة',
    'مشروب مجاني من البوفيه',
    'خصم 20% على حجز قاعة',
    '25 نقطة',
    'رسالة تحفيزية 🌟',
  ];

  Future<void> spin() async {
    if (!canSpin.value || isSpinning.value) return;
    isSpinning.value = true;
    prize.value = '';
    final rand = Random();
    final extra = rand.nextDouble() * 5 + 5;
    turns.value += extra;
    await Future.delayed(const Duration(seconds: 3));
    final idx = rand.nextInt(_prizes.length);
    prize.value = _prizes[idx];
    canSpin.value = false;
    isSpinning.value = false;
  }
}
