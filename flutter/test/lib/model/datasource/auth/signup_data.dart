import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';
import 'package:test/model/static/auth/signup_model.dart';

class SignupData {
  final Crud crud;

  SignupData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> postData(
    SignupModel model,
  ) async {
    return await crud.postData(AppLink.SignUP, model.toJson());
  }
}
