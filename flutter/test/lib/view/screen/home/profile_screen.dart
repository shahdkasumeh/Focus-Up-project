// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:test/controller/home/profile_controller.dart';
// import 'package:test/core/class/constant/appcolor.dart';
// import 'package:test/view/widget/profile/field_profile.dart';
// import 'package:test/view/widget/profile/header_profile.dart';
// import 'package:test/view/widget/profile/select_field_profile.dart';
// import 'package:test/view/widget/profile/show_options_sheet_profile.dart';

// class ProfileScreen extends GetView<ProfileController> {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF7F8FA),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(
//             child: CircularProgressIndicator(color: Appcolor.scondary),
//           );
//         }

//         final profile = controller.profile.value;

//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               HeaderProfile(profileName: profile?.fullName ?? "Profile"),
//               Transform.translate(
//                 offset: const Offset(0, -38),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(18, 0, 18, 32),
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(28),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Appcolor.scondary.withValues(alpha: 0.18),
//                           blurRadius: 22,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: Appcolor.scondary.withValues(
//                                     alpha: 0.25,
//                                   ),
//                                   width: 3,
//                                 ),
//                               ),
//                               child: CircleAvatar(
//                                 radius: 55,
//                                 backgroundColor: Colors.grey.shade100,
//                                 backgroundImage:
//                                     profile != null && profile.image.isNotEmpty
//                                     ? NetworkImage(profile.image)
//                                     : null,
//                                 child: profile == null || profile.image.isEmpty
//                                     ? const Icon(
//                                         Icons.person_rounded,
//                                         size: 50,
//                                         color: Appcolor.scondary,
//                                       )
//                                     : null,
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 2,
//                               right: 2,
//                               child: GestureDetector(
//                                 onTap: profile == null
//                                     ? () {
//                                         Get.snackbar(
//                                           "تنبيه",
//                                           "احفظي البروفايل أولاً ثم ارفعي الصورة",
//                                         );
//                                       }
//                                     : controller.pickImage,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(11),
//                                   decoration: BoxDecoration(
//                                     color: Appcolor.scondary,
//                                     shape: BoxShape.circle,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Appcolor.scondary.withValues(
//                                           alpha: 0.35,
//                                         ),
//                                         blurRadius: 12,
//                                         offset: const Offset(0, 5),
//                                       ),
//                                     ],
//                                   ),
//                                   child: const Icon(
//                                     Icons.camera_alt_rounded,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 18),

//                         Text(
//                           controller.userName.value.isNotEmpty
//                               ? "${controller.userName.value}"
//                               : profile?.fullName ?? "",
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 23,
//                             fontWeight: FontWeight.w900,
//                             color: Colors.black87,
//                           ),
//                         ),

//                         const SizedBox(height: 5),

//                         Text(
//                           controller.userEmail.value.isNotEmpty
//                               ? "${controller.userEmail.value}"
//                               : profile?.email ?? "",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),

//                         const SizedBox(height: 26),

//                         FieldProfile(
//                           controller: controller.addressController,
//                           hint: "العنوان",
//                           icon: Icons.location_on_rounded,
//                         ),

//                         const SizedBox(height: 14),

//                         FieldProfile(
//                           controller: controller.birthDateController,
//                           hint: "mm/dd/yyyy",
//                           icon: Icons.calendar_month_rounded,
//                         ),

//                         const SizedBox(height: 14),

//                         SelectFieldProfile(
//                           controller: controller.genderController,
//                           hint: "الجنس",
//                           icon: Icons.wc_rounded,
//                           onTap: () {
//                             showOptionsSheetProfile(
//                               title: "اختار الجنس",
//                               options: const ["male", "female"],
//                               onSelected: (value) {
//                                 controller.genderController.text = value;
//                               },
//                             );
//                           },
//                         ),

//                         const SizedBox(height: 14),

//                         SelectFieldProfile(
//                           controller: controller.studyLevelController,
//                           hint: "المرحلة الدراسية",
//                           icon: Icons.school_rounded,
//                           onTap: () {
//                             showOptionsSheetProfile(
//                               title: "اختاري المرحلة الدراسية",
//                               options: const [
//                                 "إعدادي",
//                                 "ثانوي",
//                                 "جامعة",
//                                 "دراسات عليا",
//                                 "متخرج",
//                               ],
//                               onSelected: (value) {
//                                 controller.studyLevelController.text = value;
//                               },
//                             );
//                           },
//                         ),

//                         const SizedBox(height: 28),

//                         SizedBox(
//                           width: double.infinity,
//                           height: 56,
//                           child: Obx(
//                             () => ElevatedButton(
//                               onPressed: controller.isSaving.value
//                                   ? null
//                                   : controller.saveProfile,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Appcolor.scondary,
//                                 disabledBackgroundColor: Appcolor.scondary
//                                     .withValues(alpha: 0.45),
//                                 foregroundColor: Colors.white,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18),
//                                 ),
//                               ),
//                               child: controller.isSaving.value
//                                   ? const SizedBox(
//                                       width: 22,
//                                       height: 22,
//                                       child: CircularProgressIndicator(
//                                         color: Colors.white,
//                                         strokeWidth: 2,
//                                       ),
//                                     )
//                                   : Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         const Icon(
//                                           Icons.save_rounded,
//                                           size: 22,
//                                         ),
//                                         const SizedBox(width: 8),
//                                         Text(
//                                           profile == null
//                                               ? "إنشاء البروفايل"
//                                               : "حفظ التعديلات",
//                                           style: const TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w900,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/profile_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/profile/field_profile.dart';
import 'package:test/view/widget/profile/select_field_profile.dart';
import 'package:test/view/widget/profile/show_options_sheet_profile.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  static const Color navy = Color(0xFF172F4F);
  static const Color darkNavy = Color(0xFF10243D);
  static const Color pageBackground = Color(0xFFF4F6FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Appcolor.scondary),
          );
        }

        final profile = controller.profile.value;

        final String displayName = controller.userName.value.isNotEmpty
            ? controller.userName.value
            : profile?.fullName ?? "مستخدم جديد";

        final String displayEmail = controller.userEmail.value.isNotEmpty
            ? controller.userEmail.value
            : profile?.email ?? "أكملي بيانات حسابك";

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _ProfileHeroHeader(
                profileName: displayName,
                profileEmail: displayEmail,
                imageUrl: profile?.image ?? "",
                hasProfile: profile != null,
                isUploadingImage: controller.isUploadingImage.value,
                onEditImage: profile == null
                    ? () {
                        Get.snackbar(
                          "تنبيه",
                          "احفظي البروفايل أولاً ثم ارفعي الصورة",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: navy,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(16),
                          borderRadius: 16,
                          icon: const Icon(
                            Icons.info_outline_rounded,
                            color: Appcolor.scondary,
                          ),
                        );
                      }
                    : controller.pickImage,
              ),

              Transform.translate(
                offset: const Offset(0, -34),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                  child: Column(
                    children: [
                      _AccountSummaryCard(
                        hasProfile: profile != null,
                        address: controller.addressController.text,
                        studyLevel: controller.studyLevelController.text,
                      ),

                      const SizedBox(height: 16),

                      _FormSectionCard(
                        title: "المعلومات الشخصية",
                        subtitle: "عدّلي معلومات حسابك الأساسية",
                        icon: Icons.person_outline_rounded,
                        child: Column(
                          children: [
                            FieldProfile(
                              controller: controller.addressController,
                              hint: "العنوان",
                              icon: Icons.location_on_rounded,
                            ),
                            const SizedBox(height: 14),
                            FieldProfile(
                              controller: controller.birthDateController,
                              hint: "تاريخ الميلاد",
                              icon: Icons.calendar_month_rounded,
                            ),
                            const SizedBox(height: 14),
                            SelectFieldProfile(
                              controller: controller.genderController,
                              hint: "الجنس",
                              icon: Icons.wc_rounded,
                              onTap: () {
                                showOptionsSheetProfile(
                                  title: "اختاري الجنس",
                                  options: const ["male", "female"],
                                  onSelected: (value) {
                                    controller.genderController.text = value;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      _FormSectionCard(
                        title: "المعلومات الدراسية",
                        subtitle: "حددي مرحلتك الدراسية الحالية",
                        icon: Icons.school_outlined,
                        child: SelectFieldProfile(
                          controller: controller.studyLevelController,
                          hint: "المرحلة الدراسية",
                          icon: Icons.school_rounded,
                          onTap: () {
                            showOptionsSheetProfile(
                              title: "اختاري المرحلة الدراسية",
                              options: const [
                                "إعدادي",
                                "ثانوي",
                                "جامعة",
                                "دراسات عليا",
                                "متخرج",
                              ],
                              onSelected: (value) {
                                controller.studyLevelController.text = value;
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 22),

                      Obx(
                        () => _SaveProfileButton(
                          isSaving: controller.isSaving.value,
                          isNewProfile: profile == null,
                          onPressed: controller.isSaving.value
                              ? null
                              : controller.saveProfile,
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
}

// ============================================================
// HERO HEADER
// ============================================================

class _ProfileHeroHeader extends StatelessWidget {
  final String profileName;
  final String profileEmail;
  final String imageUrl;
  final bool hasProfile;
  final bool isUploadingImage;
  final VoidCallback onEditImage;

  const _ProfileHeroHeader({
    required this.profileName,
    required this.profileEmail,
    required this.imageUrl,
    required this.hasProfile,
    required this.isUploadingImage,
    required this.onEditImage,
  });

  static const Color navy = Color(0xFF172F4F);
  static const Color darkNavy = Color(0xFF10243D);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 332,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [darkNavy, navy, Color(0xFF244C6E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(38),
          bottomRight: Radius.circular(38),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: -55,
              right: -45,
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.045),
                ),
              ),
            ),
            Positioned(
              bottom: 38,
              left: -55,
              child: Container(
                height: 145,
                width: 145,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Appcolor.scondary.withValues(alpha: 0.09),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  //  const SizedBox(height: 8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.13),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "My Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 44),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Appcolor.scondary, Color(0xFFFFE7A3)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolor.scondary.withValues(alpha: 0.35),
                              blurRadius: 20,
                              offset: const Offset(0, 9),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: CircleAvatar(
                            radius: 53,
                            backgroundColor: const Color(0xFFF0F2F6),
                            backgroundImage: imageUrl.isNotEmpty
                                ? NetworkImage(imageUrl)
                                : null,
                            child: imageUrl.isEmpty
                                ? const Icon(
                                    Icons.person_rounded,
                                    size: 55,
                                    color: navy,
                                  )
                                : null,
                          ),
                        ),
                      ),

                      Positioned(
                        right: -3,
                        bottom: 4,
                        child: GestureDetector(
                          onTap: isUploadingImage ? null : onEditImage,
                          child: Container(
                            height: 39,
                            width: 39,
                            decoration: BoxDecoration(
                              color: Appcolor.scondary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Appcolor.scondary.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: isUploadingImage
                                ? const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: navy,
                                    ),
                                  )
                                : const Icon(
                                    Icons.camera_alt_rounded,
                                    color: navy,
                                    size: 19,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    profileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 23,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    profileEmail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.72),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 13),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: hasProfile
                          ? Appcolor.scondary.withValues(alpha: 0.16)
                          : Colors.white.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: hasProfile
                            ? Appcolor.scondary.withValues(alpha: 0.45)
                            : Colors.white.withValues(alpha: 0.17),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          hasProfile
                              ? Icons.verified_rounded
                              : Icons.edit_note_rounded,
                          size: 16,
                          color: hasProfile
                              ? Appcolor.scondary
                              : Colors.white70,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          hasProfile
                              ? "Profile Active"
                              : "Complete your profile",
                          style: TextStyle(
                            color: hasProfile
                                ? Appcolor.scondary
                                : Colors.white70,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SUMMARY CARD
// ============================================================

class _AccountSummaryCard extends StatelessWidget {
  final bool hasProfile;
  final String address;
  final String studyLevel;

  const _AccountSummaryCard({
    required this.hasProfile,
    required this.address,
    required this.studyLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172F4F).withValues(alpha: 0.07),
            blurRadius: 25,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              icon: Icons.account_circle_outlined,
              title: "الحساب",
              value: hasProfile ? "مكتمل" : "جديد",
            ),
          ),
          _divider(),
          Expanded(
            child: _SummaryItem(
              icon: Icons.location_on_outlined,
              title: "العنوان",
              value: address.isEmpty ? "غير محدد" : "مضاف",
            ),
          ),
          _divider(),
          Expanded(
            child: _SummaryItem(
              icon: Icons.school_outlined,
              title: "الدراسة",
              value: studyLevel.isEmpty ? "غير محدد" : studyLevel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(height: 43, width: 1, color: Colors.grey.shade200);
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SummaryItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Appcolor.scondary, size: 22),
        const SizedBox(height: 7),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF172F4F),
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// FORM SECTION
// ============================================================

class _FormSectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  const _FormSectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 18, 17, 19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFF172F4F).withValues(alpha: 0.045),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172F4F).withValues(alpha: 0.055),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Appcolor.scondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Appcolor.scondary, size: 23),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF172F4F),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          child,
        ],
      ),
    );
  }
}

// ============================================================
// SAVE BUTTON
// ============================================================

class _SaveProfileButton extends StatelessWidget {
  final bool isSaving;
  final bool isNewProfile;
  final VoidCallback? onPressed;

  const _SaveProfileButton({
    required this.isSaving,
    required this.isNewProfile,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        boxShadow: isSaving
            ? []
            : [
                BoxShadow(
                  color: Appcolor.scondary.withValues(alpha: 0.32),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Appcolor.primaryColor,
          disabledBackgroundColor: Appcolor.scondary.withValues(alpha: 0.48),
          foregroundColor: Appcolor.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
        ),
        child: isSaving
            ? const SizedBox(
                height: 23,
                width: 23,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Color(0xFF172F4F),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isNewProfile
                        ? Icons.person_add_alt_1_rounded
                        : Icons.check_circle_outline_rounded,
                    size: 22,
                  ),
                  const SizedBox(width: 9),
                  Text(
                    isNewProfile ? "إنشاء البروفايل" : "حفظ التعديلات",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
