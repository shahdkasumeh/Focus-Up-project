import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/studycompanion/comment_input.dart';

class CommentBottomSheet extends StatelessWidget {
  final int postId;
  final StudyCompanionController controller;

  const CommentBottomSheet({
    super.key,
    required this.postId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom;
    final screenHeight = media.size.height;

    final sheetHeight = keyboard > 0
        ? screenHeight * 0.55
        : screenHeight * 0.72;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboard),
      child: SafeArea(
        top: false,
        bottom: false ,
        child: Container(
          height: sheetHeight,
          decoration: const BoxDecoration(
            color: Color(0xFFF8F8FB),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),

              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'التعليقات',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Appcolor.black,
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Obx(() {
                  if (controller.commentsLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Appcolor.scondary,
                      ),
                    );
                  }

                  final comments = controller.commentsMap[postId] ?? [];

                  if (comments.isEmpty) {
                    return const Center(
                      child: Text(
                        'لا توجد تعليقات بعد',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  comment.createdAt,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                if (comment.isOwner)
                                  PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.grey,
                                    ),
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        controller.startEditComment(comment);
                                      }

                                      if (value == 'delete') {
                                        controller.deleteComment(
                                          postId,
                                          comment.id,
                                        );
                                      }
                                    },
                                    itemBuilder: (context) => const [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Text('تعديل التعليق'),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text(
                                          'حذف التعليق',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),

                                const Spacer(),

                                Flexible(
                                  child: Text(
                                    comment.userName,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Appcolor.scondary,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Appcolor.scondary
                                      .withValues(alpha: 0.12),
                                  child: const Icon(
                                    Icons.person,
                                    size: 18,
                                    color: Appcolor.scondary,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Text(
                              comment.content,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),

              CommentInput(postId: postId),
            ],
          ),
        ),
      ),
    );
  }
}
