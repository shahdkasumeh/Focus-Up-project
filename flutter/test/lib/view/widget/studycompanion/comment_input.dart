import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class CommentInput extends GetView<StudyCompanionController> {
  final int postId;

  const CommentInput({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 14,
        right: 14,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// SEND
          Obx(
            () => InkWell(
              onTap: controller.isCommenting.value
                  ? null
                  : () {
                      controller.addOrUpdateComment(postId);
                    },

              borderRadius: BorderRadius.circular(16),

              child: Container(
                width: 52,
                height: 52,

                decoration: BoxDecoration(
                  color: Appcolor.scondary,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: controller.isCommenting.value
                    ? const Padding(
                        padding: EdgeInsets.all(14),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send_rounded, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// INPUT
          Expanded(
            child: Obx(
              () => TextField(
                controller: controller.commentController,

                textAlign: TextAlign.right,
                minLines: 1,
                maxLines: 4,

                decoration: InputDecoration(
                  hintText: controller.editingCommentId.value == 0
                      ? 'اكتبي تعليق...'
                      : 'عدّلي التعليق...',

                  filled: true,
                  fillColor: const Color(0xFFF5F5F7),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}