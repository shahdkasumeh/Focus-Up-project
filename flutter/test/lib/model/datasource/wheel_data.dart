import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class WheelData {
  final Crud crud;

  WheelData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> getPrizes() async {
    return await crud.getData(AppLink.prizes);
  }

  Future<Either<Failure, Map<String, dynamic>>> canSpin() async {
    return await crud.getData(AppLink.canSpin);
  }

  Future<Either<Failure, Map<String, dynamic>>> spin() async {
    return await crud.postData(AppLink.spin, {});
  }

  Future<Either<Failure, Map<String, dynamic>>> getMyPrizes() async {
    return await crud.getData(AppLink.myPrizes);
  }

  Future<Either<Failure, Map<String, dynamic>>> getCurrentPrize() async {
    return await crud.getData(AppLink.currentPrize);
  }
}