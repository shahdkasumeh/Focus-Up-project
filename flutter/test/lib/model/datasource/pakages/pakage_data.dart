import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class PakageData {
  final Crud crud;

  PakageData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> getPackages() async {
    return await crud.getData(AppLink.packages);
  }

  Future<Either<Failure, Map<String, dynamic>>> buyPackage(
    int packageId,
  ) async {
    return await crud.postData(AppLink.buyPackage, {"package_id": packageId});
  }

  Future<Either<Failure, Map<String, dynamic>>> getMyPackage() async {
    return await crud.getData(AppLink.myPackage);
  }

  Future<Either<Failure, Map<String, dynamic>>> getActivePackage() async {
    return await crud.getData(AppLink.activePackage);
  }
}
