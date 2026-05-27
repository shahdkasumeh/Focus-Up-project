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
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(
              () => InkWell(
                onTap: controller.isCommenting.value
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        controller.addOrUpdateComment(postId);
                      },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Appcolor.scondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: controller.isCommenting.value
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Obx(
                () => ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 46,
                    maxHeight: 110,
                  ),
                  child: TextField(
                    controller: controller.commentController,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    minLines: 1,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: controller.editingCommentId.value == 0
                          ? 'اكتبي تعليق...'
                          : 'عدّلي التعليق...',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F7),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
