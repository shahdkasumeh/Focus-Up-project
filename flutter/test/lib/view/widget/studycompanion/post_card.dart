import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/model/static/studycompanion/post_model.dart';

class PostCard extends GetView<StudyCompanionController> {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// TOP BAR
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// MENU
              if (post.isOwner)
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 24,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  onSelected: (value) {
                    if (value == 'edit') {
                      controller.startEditPost(post);
                    }

                    if (value == 'delete') {
                      controller.confirmDeletePost(post.id);
                    }
                  },

                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'edit',

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          Text(
                            'تعديل البوست',

                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),

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
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          Text(
                            'حذف البوست',

                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
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
                )
              else
                const SizedBox(width: 40),

              const Spacer(),

              /// USER INFO
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Text(
                    post.userName,

                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Appcolor.black,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    post.createdAt,

                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              /// AVATAR
              CircleAvatar(
                radius: 24,

                backgroundColor: Appcolor.scondary.withValues(alpha: .12),

                child: Text(
                  post.userName.isNotEmpty ? post.userName[0] : '?',

                  style: const TextStyle(
                    color: Appcolor.scondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// TITLE
          Text(
            post.title,

            textAlign: TextAlign.right,

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Appcolor.black,
            ),
          ),

          const SizedBox(height: 10),

          /// CONTENT
          Text(
            post.content,

            textAlign: TextAlign.right,

            style: const TextStyle(
              fontSize: 15,
              height: 1.7,
              color: Color(0xFF555555),
            ),
          ),

          const SizedBox(height: 18),

          /// ACTIONS
          Row(
            children: [
              /// COMMENTS BUTTON
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    controller.openComment(post.id);
                  },

                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    side: BorderSide(color: Colors.grey.shade300),
                  ),

                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: Colors.black87,
                    size: 20,
                  ),

                  label: Text(
                    "(${post.commentsCount})",

                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// LIKE BUTTON
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    controller.toggleLike(post.id);
                  },

                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    side: BorderSide(
                      color: post.isLiked
                          ? Colors.red.withValues(alpha: .25)
                          : Colors.grey.shade300,
                    ),
                  ),

                  icon: Icon(
                    post.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border_rounded,

                    color: post.isLiked ? Colors.red : Colors.black87,

                    size: 21,
                  ),

                  label: Text(
                    "${post.likesCount}",
                    style: TextStyle(
                      color: post.isLiked ? Colors.red : Colors.black87,

                      fontWeight: FontWeight.w700,
                    ),

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
