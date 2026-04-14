import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class QrData {
  final Crud crud;
  QrData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> checkIn(String userId) {
    return crud.postData(AppLink.checkIn, {"id": userId});
  }

  Future<Either<Failure, Map<String, dynamic>>> checkOut(String userId) {
    return crud.postData(AppLink.checkOut, {"id": userId});
  }
}
