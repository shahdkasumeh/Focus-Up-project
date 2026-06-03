import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class SaveProfileButton extends StatelessWidget {
  final bool isSaving;
  final bool isNewProfile;
  final VoidCallback? onPressed;

  const SaveProfileButton({
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
