
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:test/core/class/constant/appcolor.dart';

class ProfileHeroHeader extends StatelessWidget {
  final String profileName;
  final String profileEmail;
  final String imageUrl;
  final bool hasProfile;
  final bool isUploadingImage;
  final VoidCallback onEditImage;

  const ProfileHeroHeader({
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