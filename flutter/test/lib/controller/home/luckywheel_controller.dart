import 'dart:math';
import 'package:get/get.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/wheel_data.dart';
import 'package:test/model/static/luckywheel/wheel_prize_model.dart';
import 'package:test/view/widget/luckywheel/lucky_wheel_dialog.dart';

abstract class LuckyWheelController extends GetxController {}

class LuckyWheelControllerImp extends LuckyWheelController {
  final WheelData luckyWheelData = WheelData(Crud());

  RxBool isLoading = false.obs;
  RxBool isSpinning = false.obs;
  RxBool canSpin = false.obs;

  RxDouble turns = 0.0.obs;

  /// آخر جائزة بعد اللف
  RxString currentPrize = ''.obs;

  /// كل جوائز العجلة
  RxList<WheelPrizeModel> prizes = <WheelPrizeModel>[].obs;

  /// كل الجوائز
  RxList<WheelPrizeModel> myPrizes = <WheelPrizeModel>[].obs;

  /// الخصومات الحالية
  RxList<WheelPrizeModel> currentPrizes = <WheelPrizeModel>[].obs;

  RxInt remainingBookings = 0.obs;
  RxInt completedBookings = 0.obs;

  RxInt selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initWheel();
  }

  Future<void> initWheel() async {
    try {
      isLoading.value = true;

      await getPrizes();
      await checkCanSpin();
      await getMyPrizes();
      await getCurrentPrize();
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================
  /// GET PRIZES
  /// =========================

  Future<void> getPrizes() async {
    final response = await luckyWheelData.getPrizes();

    response.fold(
      (failure) {
        Get.snackbar("خطأ", failure.message);
      },
      (success) {
        final data = success["data"];

        if (data != null && data is List) {
          prizes.assignAll(
            data
                .map((e) => WheelPrizeModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
        } else {
          prizes.clear();
        }
      },
    );
  }

  /// =========================
  /// CAN SPIN
  /// =========================

  Future<void> checkCanSpin() async {
    final response = await luckyWheelData.canSpin();

    response.fold(
      (failure) {
        Get.snackbar("خطأ", failure.message);
      },
      (success) {
        print("CAN SPIN RESPONSE => $success");

        canSpin.value = success["can_spin"] == true;

        completedBookings.value =
            int.tryParse(success["completed_bookings"]?.toString() ?? '0') ?? 0;

        remainingBookings.value =
            int.tryParse(success["remaining_bookings"]?.toString() ?? '0') ?? 0;
      },
    );
  }

  /// =========================
  /// MY PRIZES
  /// =========================

  Future<void> getMyPrizes() async {
    final response = await luckyWheelData.getMyPrizes();

    response.fold(
      (failure) {
        Get.snackbar("خطأ", failure.message);
      },
      (success) {
        final data = success["data"];

        if (data != null && data is List) {
          myPrizes.assignAll(
            data
                .map((e) => WheelPrizeModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
        } else {
          myPrizes.clear();
        }
      },
    );
  }

  /// =========================
  /// CURRENT PRIZES
  /// =========================

  Future<void> getCurrentPrize() async {
    final response = await luckyWheelData.getCurrentPrize();

    response.fold(
      (failure) {
        Get.snackbar("خطأ", failure.message);
      },
      (success) {
        final data = success["data"];

        if (data != null && data is List) {
          currentPrizes.assignAll(
            data
                .map((e) => WheelPrizeModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
        } else if (data != null && data is Map<String, dynamic>) {
          currentPrizes.assignAll([WheelPrizeModel.fromJson(data)]);
        } else {
          currentPrizes.clear();
        }
      },
    );
  }

  /// =========================
  /// SPIN
  /// =========================

  Future<void> spin() async {
    if (!canSpin.value || isSpinning.value || prizes.isEmpty) {
      return;
    }

    try {
      isSpinning.value = true;

      currentPrize.value = '';

      final response = await luckyWheelData.spin();

      await response.fold(
        (failure) async {
          Get.snackbar("خطأ", failure.message);

          isSpinning.value = false;
        },
        (success) async {
          final data = success["data"];

          String wonPrizeName = '';
          String wonPrizeValue = '';

          if (data != null && data is Map<String, dynamic>) {
            wonPrizeName =
                data["name"]?.toString() ??
                data["prize"]?["name"]?.toString() ??
                '';

            wonPrizeValue =
                data["value"]?.toString() ??
                data["prize"]?["value"]?.toString() ??
                '';
          }

          final random = Random();

          turns.value += 5 + random.nextDouble();

          await Future.delayed(const Duration(seconds: 3));

          if (wonPrizeName.isEmpty && wonPrizeValue.isEmpty) {
            currentPrize.value = "جائزة جديدة";
          } else {
            currentPrize.value = "$wonPrizeName $wonPrizeValue";
          }

          await getMyPrizes();
          await getCurrentPrize();
          await checkCanSpin();

          isSpinning.value = false;

          Get.dialog(
        LuckyWheelDialog(prize: currentPrize.value),
          );
        },
      );
    } catch (e) {
      isSpinning.value = false;

      Get.snackbar("خطأ", "حدث خطأ أثناء دوران العجلة");
    }
  }

  /// =========================
  /// REFRESH
  /// =========================

  Future<void> refreshWheel() async {
    await initWheel();
  }
}
