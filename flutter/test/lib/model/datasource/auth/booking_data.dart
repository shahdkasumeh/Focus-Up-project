import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';
import 'package:dartz/dartz.dart';

class BookingData {
  final Crud crud;

  BookingData(this.crud);

  // =========================
  // 🟢 CREATE BOOKING
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> createBooking({
    required int tableId,
    required DateTime start,
    required DateTime end,
  }) async {
    return await crud.postData(AppLink.bookings, {
      "table_id": tableId,
      "scheduled_start": start.toIso8601String(),
      "scheduled_end": end.toIso8601String(),
    });
  }

  //==========================cancel booking===========================
  Future<Either<Failure, Map<String, dynamic>>> cancelBooking(
    int bookingId,
  ) async {
    return await crud.postData("${AppLink.bookings}/$bookingId/cancel", {});
  }
  // =========================
  // 🟢 CHECK IN
  // =========================
  // Future<Either<StatusRequest, Map<String, dynamic>>> checkIn(
  //   int tableId,
  // ) async {
  //   return await crud.postData("${AppLink.bookings}/check_in", {
  //     "table_id": tableId,
  //   });
  // }

  // // =========================
  // // 🔴 CHECK OUT
  // // =========================
  // Future<Either<StatusRequest, Map<String, dynamic>>> checkOut(
  //   int tableId,
  // ) async {
  //   return await crud.postData("${AppLink.bookings}/check_out", {
  //     "table_id": tableId,
  //   });
  // }
}
