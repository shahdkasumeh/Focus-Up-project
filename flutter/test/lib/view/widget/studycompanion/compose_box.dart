import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/studycompanion/build_text_field.dart';

class ComposeBox extends GetView<StudyCompanionController> {
  const ComposeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9EDF3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: Appcolor.yellowColor.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.edit_note_rounded,
                  color: Appcolor.navyColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اكتب منشور",
                      style: TextStyle(
                        color: Appcolor.navyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "شارك فكرة أو سؤال دراسي",
                      style: TextStyle(
                        color: Appcolor.inactiveColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          BuildTextField(
            controller: controller.titleController,
            hintText: "عنوان المنشور",
            prefixIcon: Icons.title_rounded,
          ),

          const SizedBox(height: 11),

          BuildTextField(
            controller: controller.contentController,
            hintText: "شارك ما تدرسه أو اطرح سؤالاً على زملائك...",
            prefixIcon: Icons.chat_bubble_outline_rounded,
            maxLines: 3,
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.navyColor,
                  disabledBackgroundColor: Appcolor.navyColor.withValues(
                    alpha: 0.65,
                  ),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: controller.isCreating.value
                    ? null
                    : controller.createOrUpdatePost,
                child: controller.isCreating.value
                    ? const SizedBox(
                        width: 23,
                        height: 23,
                        child: CircularProgressIndicator(
                          color: Appcolor.yellowColor,
                          strokeWidth: 2.3,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            controller.editingPostId.value != 0
                                ? Icons.edit_rounded
                                : Icons.send_rounded,

                            color: Appcolor.yellowColor,
                            size: 19,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "نشر المنشور",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
