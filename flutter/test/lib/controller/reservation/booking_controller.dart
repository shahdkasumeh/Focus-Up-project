import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/qrcodecontroller.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/model/datasource/home/booking_data.dart';

class BookingController extends GetxController {
  final BookingData data = BookingData(Get.find());
  final StorageHandler storage = StorageHandler();

  final RxBool isLoading = false.obs;

  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final Rxn<TimeOfDay> startTime = Rxn<TimeOfDay>();
  final Rxn<TimeOfDay> endTime = Rxn<TimeOfDay>();

  int? bookingId;

  @override
  void onInit() {
    super.onInit();

    /// هون رح يجيب حجز المستخدم المسجل حالياً فقط
    final savedBookingId = storage.bookingId;

    bookingId = savedBookingId == 0 ? null : savedBookingId;

    print("BOOKING CONTROLLER USER ID => ${storage.userId}");
    print("BOOKING CONTROLLER SAVED BOOKING => $bookingId");
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void setStart(TimeOfDay time) {
    startTime.value = time;
  }

  void setEnd(TimeOfDay time) {
    endTime.value = time;
  }

  DateTime _buildDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  bool _validate() {
    if (selectedDate.value == null ||
        startTime.value == null ||
        endTime.value == null) {
      Get.snackbar(
        "خطأ",
        "كمل كل البيانات",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    final date = selectedDate.value!;
    final start = _buildDateTime(date, startTime.value!);
    final end = _buildDateTime(date, endTime.value!);

    if (!end.isAfter(start)) {
      Get.snackbar(
        "خطأ",
        "وقت النهاية لازم يكون بعد البداية",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    final openTime = DateTime(date.year, date.month, date.day, 9, 0);

    final closeTime = DateTime(date.year, date.month, date.day, 20, 0);

    if (start.isBefore(openTime) || end.isAfter(closeTime)) {
      Get.snackbar(
        "خطأ",
        "الحجز مسموح فقط من 09:00 إلى 20:00",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> _saveBookingForCurrentUser(int id) async {
    if (Get.isRegistered<QrcodecontrollerImp>()) {
      await Get.find<QrcodecontrollerImp>().setBookingId(id);
      return;
    }

    final token = storage.token ?? "";
    final currentUserName = storage.userName ?? "";

    await storage.setBookingId(id);
    await storage.setUserQr("$token|$currentUserName|$id");
  }

  Future<void> _removeBookingForCurrentUser() async {
    if (Get.isRegistered<QrcodecontrollerImp>()) {
      await Get.find<QrcodecontrollerImp>().clearBookingId();
      return;
    }

    final token = storage.token ?? "";
    final currentUserName = storage.userName ?? "";

    await storage.removeBookingId();
    await storage.setUserQr("$token|$currentUserName|null");
  }

  Future<void> createBooking(int tableId) async {
    if (!_validate()) return;

    isLoading.value = true;

    final date = selectedDate.value!;
    final start = _buildDateTime(date, startTime.value!);
    final end = _buildDateTime(date, endTime.value!);

    try {
      final res = await data.createBooking(
        tableId: tableId,
        start: start,
        end: end,
      );

      await res.fold(
        (failure) async {
          Get.snackbar(
            "خطأ",
            failure.message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
        (success) async {
          final dynamic idValue = success["data"]?["id"];

          bookingId = idValue is int
              ? idValue
              : int.tryParse(idValue.toString());
          if (bookingId == null) {
            Get.snackbar(
              "خطأ",
              "ما وصل رقم الحجز",
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          /// هون عم ينخزن الرقم للمستخدم الحالي فقط
          await _saveBookingForCurrentUser(bookingId!);

          print("USER ID => ${storage.userId}");
          print("NEW BOOKING ID => $bookingId");

          Get.snackbar(
            "نجاح",
            success["message"] ?? "تم الحجز",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelBooking() async {
    /// بجيب حجز المستخدم الحالي فقط
    bookingId ??= storage.bookingId == 0 ? null : storage.bookingId;

    if (bookingId == null) {
      Get.snackbar(
        "خطأ",
        "لا يوجد حجز لإلغائه",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final res = await data.cancelBooking(bookingId!);

      await res.fold(
        (failure) async {
          Get.snackbar(
            "خطأ",
            failure.message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
        (success) async {
          /// بيمسح حجز المستخدم الحالي فقط
          await _removeBookingForCurrentUser();

          bookingId = null;
          selectedDate.value = null;
          startTime.value = null;
          endTime.value = null;

          Get.snackbar(
            "تم",
            success["message"] ?? "تم إلغاء الحجز",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
