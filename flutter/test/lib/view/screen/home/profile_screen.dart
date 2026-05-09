// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/profile_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Appcolor.scondary),
          );
        }

        final profile = controller.profile.value;

        if (profile == null) {
          return const Center(child: Text("لا يوجد بيانات"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _Header(profileName: profile.fullName),

              Transform.translate(
                offset: const Offset(0, -38),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 32),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolor.scondary,
                              blurRadius: 22,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Appcolor.scondary.withOpacity(.25),
                                      width: 3,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.grey.shade100,
                                    backgroundImage: profile.image.isNotEmpty
                                        ? NetworkImage(profile.image)
                                        : null,
                                    child: profile.image.isEmpty
                                        ? const Icon(
                                            Icons.person_rounded,
                                            size: 50,
                                            color: Appcolor.scondary,
                                          )
                                        : null,
                                  ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: controller.pickImage,
                                    child: Container(
                                      padding: const EdgeInsets.all(11),
                                      decoration: BoxDecoration(
                                        color: Appcolor.scondary,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Appcolor.scondary
                                                .withOpacity(.35),
                                            blurRadius: 12,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            Text(
                              profile.fullName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              profile.email,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 26),

                            _field(
                              controller: controller.addressController,
                              hint: "العنوان",
                              icon: Icons.location_on_rounded,
                            ),

                            const SizedBox(height: 14),

                            _field(
                              controller: controller.birthDateController,
                              hint: "تاريخ الميلاد",
                              icon: Icons.calendar_month_rounded,
                            ),

                            const SizedBox(height: 14),

                            _selectField(
                              controller: controller.genderController,
                              hint: "الجنس",
                              icon: Icons.wc_rounded,
                              onTap: () {
                                _showOptionsSheet(
                                  title: "اختار الجنس",
                                  options: const ["male", "female"],
                                  onSelected: (value) {
                                    controller.genderController.text = value;
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 14),

                            _selectField(
                              controller: controller.studyLevelController,
                              hint: "المرحلة الدراسية",
                              icon: Icons.school_rounded,
                              onTap: () {
                                _showOptionsSheet(
                                  title: "اختاري المرحلة الدراسية",
                                  options: const [
                                    "إعدادي",
                                    "ثانوي",
                                    "جامعة",
                                    "دراسات عليا",
                                    "متخرج",
                                  ],
                                  onSelected: (value) {
                                    controller.studyLevelController.text =
                                        value;
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 28),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: controller.isSaving.value
                                      ? null
                                      : controller.updateProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Appcolor.scondary,
                                    disabledBackgroundColor: Appcolor.scondary
                                        .withOpacity(.45),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: controller.isSaving.value
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.save_rounded, size: 22),
                                            SizedBox(width: 8),
                                            Text(
                                              "حفظ التعديلات",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Appcolor.scondary),
        filled: true,
        fillColor: const Color(0xffF7F8FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _selectField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Appcolor.scondary),
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: const Color(0xffF7F8FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _showOptionsSheet({
    required String title,
    required List<String> options,
    required Function(String value) onSelected,
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            ...options.map(
              (option) => InkWell(
                onTap: () {
                  onSelected(option);
                  Get.back();
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F8FA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    option,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class _Header extends StatelessWidget {
  final String profileName;

  const _Header({required this.profileName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 48, 18, 78),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Appcolor.scondary, Appcolor.scondary],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(34),
          bottomRight: Radius.circular(34),
        ),
        boxShadow: [
          BoxShadow(
            color: Appcolor.scondary.withOpacity(.25),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.14),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(.25)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const Spacer(),
          const Column(
            children: [
              Text(
                'الملف الشخصي',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'عدّل معلوماتك بسهولة',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(width: 46),
        ],
      ),
    );
  }
}
