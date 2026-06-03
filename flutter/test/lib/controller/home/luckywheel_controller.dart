import 'dart:math';
import 'package:get/get.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/home/wheel_data.dart';
import 'package:test/model/static/luckywheel/wheel_prize_model.dart';
import 'package:test/view/widget/luckywheel/lucky_wheel_dialog.dart';

abstract class LuckyWheelController extends GetxController {}

class LuckyWheelControllerImp extends LuckyWheelController {
  final WheelData luckyWheelData = WheelData(Crud());

  RxBool isLoading = false.obs;
  RxBool isSpinning = false.obs;
  RxBool canSpin = false.obs;

  RxDouble turns = 0.0.obs;

  RxString currentPrize = ''.obs;

  RxList<WheelPrizeModel> prizes = <WheelPrizeModel>[].obs;
  RxList<WheelPrizeModel> myPrizes = <WheelPrizeModel>[].obs;
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
    isLoading.value = true;

    await getPrizes();
    await checkCanSpin();
    await getMyPrizes();
    await getCurrentPrize();

    isLoading.value = false;
  }

  // ================= PRIZES =================
  Future<void> getPrizes() async {
    final response = await luckyWheelData.getPrizes();

    response.fold((failure) => Get.snackbar("خطأ", failure.message), (success) {
      final data = success["data"];

      if (data is List) {
        prizes.assignAll(data.map((e) => WheelPrizeModel.fromJson(e)).toList());
      } else {
        prizes.clear();
      }
    });
  }

  // ================= CAN SPIN =================
  Future<void> checkCanSpin() async {
    final response = await luckyWheelData.canSpin();

    response.fold((failure) => Get.snackbar("خطأ", failure.message), (success) {
      canSpin.value = success["can_spin"] == true;

      completedBookings.value =
          int.tryParse(success["completed_bookings"].toString()) ?? 0;

      remainingBookings.value =
          int.tryParse(success["remaining_bookings"].toString()) ?? 0;
    });
  }

  // ================= MY PRIZES =================
  Future<void> getMyPrizes() async {
    final response = await luckyWheelData.getMyPrizes();

    response.fold((failure) => Get.snackbar("خطأ", failure.message), (success) {
      final data = success["data"];

      if (data is List) {
        myPrizes.assignAll(
          data.map((e) => WheelPrizeModel.fromJson(e)).toList(),
        );
      } else {
        myPrizes.clear();
      }
    });
  }

  // ================= CURRENT PRIZE =================
  Future<void> getCurrentPrize() async {
    final response = await luckyWheelData.getCurrentPrize();

    response.fold((failure) => Get.snackbar("خطأ", failure.message), (success) {
      final data = success["data"];

      if (data is List) {
        currentPrizes.assignAll(
          data.map((e) => WheelPrizeModel.fromJson(e)).toList(),
        );
      } else if (data is Map<String, dynamic>) {
        currentPrizes.assignAll([WheelPrizeModel.fromJson(data)]);
      } else {
        currentPrizes.clear();
      }
    });
  }

  // ================= SPIN (FIXED 100%) =================
  Future<void> spin() async {
    // 🚨 شرط صحيح
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

          String name = '';
          String value = '';

          if (data is Map<String, dynamic>) {
            name =
                data["name"]?.toString() ??
                data["prize"]?["name"]?.toString() ??
                '';

            value =
                data["value"]?.toString() ??
                data["prize"]?["value"]?.toString() ??
                '';
          }

          final random = Random();
          final index = random.nextInt(prizes.length);

          final slice = 1 / prizes.length;

          turns.value = turns.value + 5 + (index * slice);

          await Future.delayed(const Duration(seconds: 4));

          currentPrize.value = (name.isEmpty && value.isEmpty)
              ? "جائزة جديدة"
              : "$name $value";

          await getMyPrizes();
          await getCurrentPrize();
          await checkCanSpin();

          isSpinning.value = false;

          Get.dialog(LuckyWheelDialog(prize: currentPrize.value));
        },
      );
    } catch (e) {
      isSpinning.value = false;
      Get.snackbar("خطأ", "حدث خطأ أثناء دوران العجلة");
    }
  }

  Future<void> refreshWheel() async {
    await initWheel();
  }
}
