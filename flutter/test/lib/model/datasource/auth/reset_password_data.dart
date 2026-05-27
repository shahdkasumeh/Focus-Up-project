import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class ResetPasswordData {
  final Crud crud;

  ResetPasswordData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await crud.postData(AppLink.resetPassword, {
      "email": email,
      "token": token,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });
  }
}
