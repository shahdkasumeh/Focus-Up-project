import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

import 'package:dartz/dartz.dart';

class LoginData {
  final Crud crud;

  LoginData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> postData(
    Map<String, dynamic> data,
  ) async {
    return await crud.postData(AppLink.login, data);
  }
}
