import 'package:dartz/dartz.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class EmailVerificationData {
  final Crud crud;

  EmailVerificationData(this.crud);
  Future<Either<Failure, Map<String, dynamic>>> resendVerification() async {
    final token = StorageHandler().token;

    return await crud.postData(
      AppLink.emailVerificationNotification,
      {},
      headers: {
        "Authorization": "Bearer ${token?.trim()}",
        "Accept": "application/json",
      },
    );
  }
}
