// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

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
    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.72,
        minChildSize: 0.45,
        maxChildSize: 0.92,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF8F8FB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),

                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'التعليقات',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Appcolor.black,
                  ),
                ),

                const SizedBox(height: 16),

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
                      controller: scrollController,
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
                                color: Colors.black.withOpacity(.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              /// TOP
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// LEFT
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

                                      if (comment.isOwner) ...[
                                        const SizedBox(width: 6),

                                        PopupMenuButton<String>(
                                          icon: const Icon(
                                            Icons.more_horiz,
                                            color: Colors.grey,
                                          ),

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),

                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              controller.startEditComment(
                                                comment,
                                              );
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

                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text('تعديل التعليق'),

                                                  SizedBox(width: 10),

                                                  Icon(
                                                    Icons.edit_outlined,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            PopupMenuItem(
                                              value: 'delete',

                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'حذف التعليق',

                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),

                                                  SizedBox(width: 10),

                                                  Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.red,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),

                                  /// USER
                                  Row(
                                    children: [
                                      Text(
                                        comment.userName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Appcolor.scondary,
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      CircleAvatar(
                                        radius: 16,

                                        backgroundColor: Appcolor.scondary
                                            .withOpacity(.12),

                                        child: Text(
                                          comment.userName.isNotEmpty
                                              ? comment.userName[0]
                                              : '?',

                                          style: const TextStyle(
                                            color: Appcolor.scondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              /// CONTENT
                              Text(
                                comment.content,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),

                _commentInput(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _commentInput(BuildContext context) {
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
