import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class WalkInData {
  final Crud crud;

  WalkInData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> getCrowding() async {
    return await crud.getData(AppLink.crowdingWalkIn);
  }
}
