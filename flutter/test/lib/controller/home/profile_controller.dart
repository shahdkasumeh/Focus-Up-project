import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/profile/profile_data.dart';
import 'package:test/model/static/profile/profile_model.dart';

class ProfileController extends GetxController {

  final ProfileData profileData =
      ProfileData(Crud());

  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  Rxn<ProfileModel> profile =
      Rxn<ProfileModel>();

  final addressController =
      TextEditingController();

  final birthDateController =
      TextEditingController();

  final genderController =
      TextEditingController();

  final studyLevelController =
      TextEditingController();

  File? imageFile;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  @override
  void onClose() {
    addressController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    studyLevelController.dispose();
    super.onClose();
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;

      final response =
          await profileData.getProfile();

      response.fold(
        (failure) {
          Get.snackbar(
            "خطأ",
            failure.message,
          );
        },
        (success) {

          final data = success["data"];

          if (data != null) {

            profile.value =
                ProfileModel.fromJson(data);

            addressController.text =
                profile.value!.address;

            birthDateController.text =
                profile.value!.birthDate;

            genderController.text =
                profile.value!.gender;

            studyLevelController.text =
                profile.value!.studyLevel;
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {

    try {
      isSaving.value = true;

      final response =
          await profileData.updateProfile(
        address:
            addressController.text.trim(),

        birthDate:
            birthDateController.text.trim(),

        gender:
            genderController.text.trim(),

        studyLevel:
            studyLevelController.text.trim(),
      );

      response.fold(
        (failure) {
          Get.snackbar(
            "خطأ",
            failure.message,
          );
        },
        (success) {

          final data = success["data"];

          if (data != null) {
            profile.value =
                ProfileModel.fromJson(data);

            Get.snackbar(
              "تم",
              "تم تحديث البروفايل",
            );
          }
        },
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> pickImage() async {

    final picker = ImagePicker();

    final picked =
        await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (picked == null) return;

    imageFile = File(picked.path);

    await uploadImage();
  }

  Future<void> uploadImage() async {

    if (imageFile == null) return;

    final response =
        await profileData.uploadImage(
      imageFile!.path,
    );

    response.fold(
      (failure) {
        Get.snackbar(
          "خطأ",
          failure.message,
        );
      },
      (success) {

        final data = success["data"];

        if (data != null) {

          profile.value =
              ProfileModel.fromJson(data);

          profile.refresh();

          Get.snackbar(
            "تم",
            "تم رفع الصورة",
          );
        }
      },
    );
  }
}