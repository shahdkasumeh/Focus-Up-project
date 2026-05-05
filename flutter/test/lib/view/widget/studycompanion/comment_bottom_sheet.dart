import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';

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
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const Text(
              "التعليقات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: Obx(() {
                if (controller.commentsLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final comments = controller.commentsMap[postId] ?? [];

                if (comments.isEmpty) {
                  return const Center(child: Text("لا يوجد تعليقات بعد"));
                }

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        comment.userName,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        comment.content,
                        textAlign: TextAlign.right,
                      ),
                      leading: comment.isOwner
                          ? PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == "edit") {
                                  controller.startEditComment(comment);
                                } else if (value == "delete") {
                                  controller.deleteComment(postId, comment.id);
                                }
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                  value: "edit",
                                  child: Text("تعديل"),
                                ),
                                PopupMenuItem(
                                  value: "delete",
                                  child: Text("حذف"),
                                ),
                              ],
                            )
                          : null,
                    );
                  },
                );
              }),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.commentController,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      hintText: "اكتبي تعليق...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Obx(
                  () => IconButton(
                    onPressed: () => controller.addOrUpdateComment(postId),
                    icon: Icon(
                      controller.editingCommentId.value == 0
                          ? Icons.send
                          : Icons.check,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
