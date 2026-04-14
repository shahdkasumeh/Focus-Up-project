import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:test/model/datasource/auth/booking_data.dart';

class BookingController extends GetxController {
  BookingData data = BookingData(Get.find());

  var isLoading = false.obs;

  var selectedDate = Rxn<DateTime>();
  var startTime = Rxn<TimeOfDay>();
  var endTime = Rxn<TimeOfDay>();

  int? bookingId; // 🔥 مهم جداً للإلغاء

  void setDate(DateTime date) => selectedDate.value = date;
  void setStart(TimeOfDay time) => startTime.value = time;
  void setEnd(TimeOfDay time) => endTime.value = time;

  // =========================
  // 🔵 VALIDATION
  // =========================
  bool _validate() {
    if (selectedDate.value == null ||
        startTime.value == null ||
        endTime.value == null) {
      Get.snackbar("خطأ", "كمل كل البيانات");
      return false;
    }

    final date = selectedDate.value!;

    final start = DateTime(
      date.year,
      date.month,
      date.day,
      startTime.value!.hour,
      startTime.value!.minute,
    );

    final end = DateTime(
      date.year,
      date.month,
      date.day,
      endTime.value!.hour,
      endTime.value!.minute,
    );

    if (!end.isAfter(start)) {
      Get.snackbar("خطأ", "وقت النهاية لازم يكون بعد البداية");
      return false;
    }

    return true;
  }

  // =========================
  // 🟢 CREATE BOOKING
  // =========================
  Future<void> createBooking(int tableId) async {
    if (!_validate()) return;

    isLoading.value = true;

    final date = selectedDate.value!;

    final start = DateTime(
      date.year,
      date.month,
      date.day,
      startTime.value!.hour,
      startTime.value!.minute,
    );

    final end = DateTime(
      date.year,
      date.month,
      date.day,
      endTime.value!.hour,
      endTime.value!.minute,
    );

    var res = await data.createBooking(
      tableId: tableId,
      start: start,
      end: end,
    );

    res.fold(
      (failure) {
        Get.snackbar(
          "خطأ",
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      (success) {
        Get.snackbar(
          "نجاح",
          success['message'] ?? "تم الحجز",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // 🔥 نحفظ bookingId للإلغاء
        bookingId = success["data"]?["id"];

        print("BOOKING ID => $bookingId");
      },
    );

    isLoading.value = false;
  }

  // =========================
  // 🔴 CANCEL BOOKING
  // =========================
  Future<void> cancelBooking() async {
    if (bookingId == null) {
      Get.snackbar("خطأ", "لا يوجد حجز لإلغائه");
      return;
    }

    isLoading.value = true;

    var res = await data.cancelBooking(bookingId!);

    res.fold(
      (failure) {
        Get.snackbar(
          "خطأ",
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      (success) {
        Get.snackbar(
          "تم",
          success['message'] ?? "تم إلغاء الحجز",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // 🔥 تنظيف الحالة
        bookingId = null;
        selectedDate.value = null;
        startTime.value = null;
        endTime.value = null;
      },
    );

    isLoading.value = false;
  }
}
