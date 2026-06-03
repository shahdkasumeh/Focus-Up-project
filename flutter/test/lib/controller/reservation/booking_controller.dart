import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/qrcodecontroller.dart';
import 'package:test/controller/reservation/room_details_controller.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/model/datasource/home/booking_data.dart';

class BookingController extends GetxController {
  final BookingData data = BookingData(Get.find());
  final StorageHandler storage = StorageHandler();

  final RxBool isLoading = false.obs;

  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final Rxn<TimeOfDay> startTime = Rxn<TimeOfDay>();
  final Rxn<TimeOfDay> endTime = Rxn<TimeOfDay>();

  final Rxn<Map<String, dynamic>> currentBooking = Rxn<Map<String, dynamic>>();

  int? bookingId;

  @override
  void onInit() {
    super.onInit();

    final savedBookingId = storage.bookingId;
    bookingId = savedBookingId == 0 ? null : savedBookingId;

    print("BOOKING CONTROLLER USER ID => ${storage.userId}");
    print("BOOKING CONTROLLER SAVED BOOKING => $bookingId");

    getPendingBookings();
    
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

  String _formatDateTime(DateTime value) {
    return value.toString().split(".")[0];
  }

  bool _validate() {
    if (selectedDate.value == null ||
        startTime.value == null ||
        endTime.value == null) {
      Get.snackbar(
        "خطأ",
        "كمل كل البيانات",
        snackPosition: SnackPosition.TOP,
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
        snackPosition: SnackPosition.TOP,
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
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  Future<void> getPendingBookings() async {
    try {
      final res = await data.getBookings();

      await res.fold(
        (failure) async {
          print("GET BOOKINGS ERROR => ${failure.message}");
          currentBooking.value = null;
          bookingId = null;
        },
        (success) async {
          final List bookings = success["data"] ?? [];

          final pendingBookings = bookings.where((e) {
            return e["status"] == "pending";
          }).toList();

          if (pendingBookings.isEmpty) {
            print("NO PENDING BOOKINGS");

            bookingId = null;
            currentBooking.value = null;
            await _removeBookingForCurrentUser();
            return;
          }

          final booking = pendingBookings.first;

          final dynamic idValue = booking["id"];
          bookingId = idValue is int
              ? idValue
              : int.tryParse(idValue.toString());

          if (bookingId != null) {
            await _saveBookingForCurrentUser(bookingId!);
          }

          currentBooking.value = {
            "id": booking["id"],
            "status": booking["status"] ?? "pending",
            "start": booking["scheduled_start"] ?? booking["actual_start"],
            "end": booking["scheduled_end"] ?? booking["actual_end"],
            "table_id": booking["table"]?["id"],
            "table_num": booking["table"]?["table_num"],
          };

          print("CURRENT PENDING BOOKING => ${currentBooking.value}");
        },
      );
    } catch (e) {
      print("getPendingBookings Exception => $e");
      currentBooking.value = null;
    }
  }

  Future<void> refreshTablesAfterBookingChange() async {
    await getPendingBookings();

    if (Get.isRegistered<RoomDetailsController>()) {
      print("REFRESH TABLES AFTER BOOKING CHANGE");
      await Get.find<RoomDetailsController>().fetchTables();
    }
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
            snackPosition: SnackPosition.TOP,
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
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          await _saveBookingForCurrentUser(bookingId!);

          currentBooking.value = {
            "id": bookingId,
            "status": success["data"]?["status"] ?? "pending",
            "start":
                success["data"]?["scheduled_start"] ?? _formatDateTime(start),
            "end": success["data"]?["scheduled_end"] ?? _formatDateTime(end),
            "table_id": success["data"]?["table"]?["id"] ?? tableId,
            "table_num": success["data"]?["table"]?["table_num"],
          };

          selectedDate.value = null;
          startTime.value = null;
          endTime.value = null;

          if (Get.isBottomSheetOpen == true) {
            Get.back();
          }

          Get.snackbar(
            "نجاح",
            success["message"] ?? "تم الحجز",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          await refreshTablesAfterBookingChange();
        },
      );
    } catch (e) {
      Get.snackbar(
        "خطأ",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelBooking() async {
    bookingId ??= storage.bookingId == 0 ? null : storage.bookingId;
    if (bookingId == null) {
      Get.snackbar(
        "خطأ",
        "لا يوجد حجز لإلغائه",
        snackPosition: SnackPosition.TOP,
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
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
        (success) async {
          await _removeBookingForCurrentUser();

          bookingId = null;
          currentBooking.value = null;

          selectedDate.value = null;
          startTime.value = null;
          endTime.value = null;

          Get.snackbar(
            "تم",
            success["message"] ?? "تم إلغاء الحجز",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          await refreshTablesAfterBookingChange();
        },
      );
    } catch (e) {
      Get.snackbar(
        "خطأ",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
