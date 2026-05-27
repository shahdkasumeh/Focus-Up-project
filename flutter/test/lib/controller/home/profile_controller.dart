import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/profile/profile_data.dart';
import 'package:test/model/static/profile/profile_model.dart';

class ProfileController extends GetxController {
  final ProfileData profileData = ProfileData(Crud());

  /// STATES
  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;
  RxBool isUploadingImage = false.obs;

  /// DATA
  Rxn<ProfileModel> profile = Rxn<ProfileModel>();

  RxString userName = "".obs;
  RxString userEmail = "".obs;

  /// CONTROLLERS
  final addressController = TextEditingController();
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();
  final studyLevelController = TextEditingController();

  File? imageFile;

  bool get hasProfile => profile.value != null;

  @override
  void onInit() {
    super.onInit();

    /// فقط جلب البروفايل
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

  /// =========================
  /// FILL CONTROLLERS
  /// =========================
  void fillControllers() {
    final p = profile.value;

    if (p == null) return;

    addressController.text = p.address;
    birthDateController.text = p.birthDate;
    genderController.text = p.gender;
    studyLevelController.text = p.studyLevel;
  }

  /// =========================
  /// SAVE PROFILE
  /// =========================
  Future<void> saveProfile() async {
    if (hasProfile) {
      await updateProfile();
    } else {
      await createProfile();
    }
  }

  /// =========================
  /// CREATE PROFILE
  /// =========================
  Future<void> createProfile() async {
    try {
      isSaving.value = true;

      final response = await profileData.createProfile(
        address: addressController.text.trim(),
        birthDate: birthDateController.text.trim(),
        gender: genderController.text.trim(),
        studyLevel: studyLevelController.text.trim(),
      );

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) async {
          Get.snackbar("تم", "تم إنشاء البروفايل بنجاح");

          await getProfile();
        },
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;

      final response = await profileData.getProfile();

      response.fold(
        (failure) {
          print("GET PROFILE ERROR => ${failure.message}");

          profile.value = null;
        },
        (success) {
          final data = success["data"];

          if (data == null) {
            profile.value = null;
            return;
          }

          userName.value =
              data["user"]?["fullname"] ?? data["user"]?["name"] ?? "";

          userEmail.value = data["user"]?["email"] ?? "";

          profile.value = ProfileModel.fromJson(data);

          fillControllers();
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================
  /// UPDATE PROFILE
  /// =========================
  Future<void> updateProfile() async {
    try {
      isSaving.value = true;

      final response = await profileData.updateProfile(
        address: addressController.text.trim(),
        birthDate: birthDateController.text.trim(),
        gender: genderController.text.trim(),
        studyLevel: studyLevelController.text.trim(),
      );

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) async {
          Get.snackbar("تم", "تم تحديث البروفايل");
          await getProfile();
        },
      );
    } finally {
      isSaving.value = false;
    }
  }

  /// =========================
  /// PICK IMAGE
  /// =========================
  Future<void> pickImage() async {
    final picker = ImagePicker();

    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (picked == null) return;

    imageFile = File(picked.path);

    await uploadImage();
  }

  /// =========================
  /// UPLOAD IMAGE
  /// =========================
  Future<void> uploadImage() async {
    if (imageFile == null) return;

    try {
      isUploadingImage.value = true;

      final response = await profileData.uploadImage(imageFile!.path);

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) async {
          Get.snackbar("تم", "تم رفع الصورة");

          await getProfile();
        },
      );
    } finally {
      isUploadingImage.value = false;
    }
  }
}
