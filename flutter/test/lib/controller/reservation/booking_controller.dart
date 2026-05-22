// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:test/model/datasource/auth/booking_data.dart';

// class BookingController extends GetxController {
//   BookingData data = BookingData(Get.find());

//   var isLoading = false.obs;

//   var selectedDate = Rxn<DateTime>();
//   var startTime = Rxn<TimeOfDay>();
//   var endTime = Rxn<TimeOfDay>();

//   int? bookingId;

//   void setDate(DateTime date) => selectedDate.value = date;
//   void setStart(TimeOfDay time) => startTime.value = time;
//   void setEnd(TimeOfDay time) => endTime.value = time;

//   DateTime _buildDateTime(DateTime date, TimeOfDay time) {
//     return DateTime(
//       date.year,
//       date.month,
//       date.day,
//       time.hour,
//       time.minute,
//     );
//   }

//   String formatDateTime(DateTime dt) {
//     return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
//         "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
//   }

//   bool _validate() {
//     if (selectedDate.value == null ||
//         startTime.value == null ||
//         endTime.value == null) {
//       Get.snackbar("خطأ", "كمل كل البيانات");
//       return false;
//     }

//     final date = selectedDate.value!;
//     final start = _buildDateTime(date, startTime.value!);
//     final end = _buildDateTime(date, endTime.value!);

//     if (!end.isAfter(start)) {
//       Get.snackbar("خطأ", "وقت النهاية لازم يكون بعد البداية");
//       return false;
//     }

//     return true;
//   }

//   Future<void> createBooking(int tableId) async {
//     if (!_validate()) return;

//     isLoading.value = true;

//     final date = selectedDate.value!;
//     final start = _buildDateTime(date, startTime.value!);
//     final end = _buildDateTime(date, endTime.value!);

//     try {
//       var res = await data.createBooking(
//         tableId: tableId,
//         start: start,
//         end: end,
//       );

//       res.fold(
//         (failure) {
//           Get.snackbar(
//             "خطأ",
//             failure.message,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         },
//         (success) {
//           Get.snackbar(
//             "نجاح",
//             success['message'] ?? "تم الحجز",
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//           );

//           bookingId = success["data"]?["id"];
//         },
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> cancelBooking() async {
//     if (bookingId == null) {
//       Get.snackbar("خطأ", "لا يوجد حجز لإلغائه");
//       return;
//     }

//     isLoading.value = true;

//     try {
//       var res = await data.cancelBooking(bookingId!);

//       res.fold(
//         (failure) {
//           Get.snackbar(
//             "خطأ",
//             failure.message,
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//         },
//         (success) {
//           Get.snackbar(
//             "تم",
//             success['message'] ?? "تم إلغاء الحجز",
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//           );

//           bookingId = null;
//           selectedDate.value = null;
//           startTime.value = null;
//           endTime.value = null;
//         },
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:test/model/datasource/auth/booking_data.dart';

class BookingController extends GetxController {
  BookingData data = BookingData(Get.find());

  var isLoading = false.obs;

  var selectedDate = Rxn<DateTime>();
  var startTime = Rxn<TimeOfDay>();
  var endTime = Rxn<TimeOfDay>();

  int? bookingId;

  void setDate(DateTime date) => selectedDate.value = date;

  void setStart(TimeOfDay time) => startTime.value = time;

  void setEnd(TimeOfDay time) => endTime.value = time;

  DateTime _buildDateTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  String formatDateTime(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
  }

  bool _validate() {
    if (selectedDate.value == null ||
        startTime.value == null ||
        endTime.value == null) {
      Get.snackbar("خطأ", "كمل كل البيانات");
      return false;
    }

    final date = selectedDate.value!;
    final start = _buildDateTime(date, startTime.value!);
    final end = _buildDateTime(date, endTime.value!);

    /// النهاية لازم تكون بعد البداية
    if (!end.isAfter(start)) {
      Get.snackbar("خطأ", "وقت النهاية لازم يكون بعد البداية");
      return false;
    }

    /// أوقات الدوام المسموحة
    final openTime = DateTime(
      date.year,
      date.month,
      date.day,
      9,
      0,
    );

    final closeTime = DateTime(
      date.year,
      date.month,
      date.day,
      20,
      0,
    );

    /// التحقق من الوقت
    if (start.isBefore(openTime) || end.isAfter(closeTime)) {
      Get.snackbar(
        "خطأ",
        "الحجز مسموح فقط من 09:00 إلى 20:00",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      return false;
    }

    print("START => ${formatDateTime(start)}");
    print("END => ${formatDateTime(end)}");

    return true;
  }

  Future<void> createBooking(int tableId) async {
    if (!_validate()) return;

    isLoading.value = true;

    final date = selectedDate.value!;

    final start = _buildDateTime(date, startTime.value!);

    final end = _buildDateTime(date, endTime.value!);

    try {
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

          bookingId = success["data"]?["id"];
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelBooking() async {
    if (bookingId == null) {
      Get.snackbar("خطأ", "لا يوجد حجز لإلغائه");
      return;
    }

    isLoading.value = true;

    try {
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

          bookingId = null;
          selectedDate.value = null;
          startTime.value = null;
          endTime.value = null;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}