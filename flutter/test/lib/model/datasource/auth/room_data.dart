// import 'package:dartz/dartz.dart';
// import 'package:test/core/class/crud.dart';
// import 'package:test/linkapi.dart';

import 'package:dartz/dartz.dart' show Either;
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class RoomsData {
  final Crud crud;

  RoomsData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> getRooms() async {
    return await crud.getData(AppLink.crowding);
  }
}
