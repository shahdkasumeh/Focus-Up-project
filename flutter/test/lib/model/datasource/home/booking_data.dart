
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';
import 'package:dartz/dartz.dart';

class BookingData {
  final Crud crud;

  BookingData(this.crud);

  String formatDateTime(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
  }

  Future<Either<Failure, Map<String, dynamic>>> createBooking({
    required int tableId,
    required DateTime start,
    required DateTime end,
  }) async {
    return await crud.postData(AppLink.bookings, {
      "table_id": tableId,
      "scheduled_start": formatDateTime(start),
      "scheduled_end": formatDateTime(end),
    });
  }
 Future<Either<Failure, Map<String, dynamic>>> getBookings() async {
    return await crud.getData(AppLink.bookings);
  }
  

  Future<Either<Failure, Map<String, dynamic>>> cancelBooking(
    int bookingId,
  ) async {
    return await crud.postData("${AppLink.bookings}/$bookingId/cancel", {});
  }
}