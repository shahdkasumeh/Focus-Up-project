import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class ProfileData {
  final Crud crud;

  ProfileData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> createProfile({
    required String address,
    required String birthDate,
    required String gender,
    required String studyLevel,
  }) async {
    return await crud.postData(
      AppLink.profile,
      {
        "address": address,
        "birth_date": birthDate,
        "gender": gender,
        "study_level": studyLevel,
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> getProfile() async {
    return await crud.getData(AppLink.profile);
  }

  Future<Either<Failure, Map<String, dynamic>>> updateProfile({
    required String address,
    required String birthDate,
    required String gender,
    required String studyLevel,
  }) async {
    return await crud.putData(
      AppLink.profile,
      {
        "address": address,
        "birth_date": birthDate,
        "gender": gender,
        "study_level": studyLevel,
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> uploadImage(
    String imagePath,
  ) async {
    return await crud.uploadFile(
      AppLink.uploadProfileImage,
      imagePath,
    );
  }
}