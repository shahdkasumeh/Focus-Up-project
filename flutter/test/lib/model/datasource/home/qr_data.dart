import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class QrData {
  final Crud crud;

  QrData(this.crud);


  Future<Either<Failure, Map<String, dynamic>>> checkIn(int bookingId) {
    return crud.postData(
      AppLink.checkIn,
      {
        "booking_id": bookingId,
      },
    );
  }


  Future<Either<Failure, Map<String, dynamic>>> checkOut(int bookingId) {
    return crud.postData(
      AppLink.checkOut,
      {
        "booking_id": bookingId,
      },
    );
  }


  Future<Either<Failure, Map<String, dynamic>>> getBookingDetails(
    int bookingId,
  ) {
    return crud.getData(
      "${AppLink.bookingDetails}/$bookingId",
    );
  }
}