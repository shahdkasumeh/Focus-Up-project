import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class ForgetPasswordData {
  final Crud crud;

  ForgetPasswordData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> sendEmail(
    String email,
  ) async {
    return await crud.postData(
      AppLink.forgetPassword,
      {
        "email": email,
      },
      headers: {
        "Accept": "application/json",
      },
    );
  }
}