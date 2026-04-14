import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class RoomDetailsData {
  final Crud crud;

  RoomDetailsData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> getRoom(int id) async {
    return await crud.getData("${AppLink.room}/$id");
  }
}
