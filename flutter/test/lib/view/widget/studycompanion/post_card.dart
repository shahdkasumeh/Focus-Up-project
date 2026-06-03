import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/model/static/studycompanion/post_model.dart';
import 'package:test/view/widget/studycompanion/action_button.dart';
import 'package:test/view/widget/studycompanion/build_post_header.dart';

class PostCard extends GetView<StudyCompanionController> {
  final PostModel post;

  const PostCard({super.key, required this.post});

  static const Color navyColor = Color(0xFF172F4F);
  static const Color yellowColor = Color(0xFFF4C542);
  static const Color backgroundColor = Color(0xFFF7F8FB);
  static const Color borderColor = Color(0xFFE9EDF3);
  static const Color greyTextColor = Color(0xFF8792A5);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
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
          BuildPostHeader(
            post: post,
            onEdit: () => controller.startEditPost(post),
            onDelete: () => controller.confirmDeletePost(post.id),
          ),

          const SizedBox(height: 15),

          Text(
            post.title,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: navyColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            post.content,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.7,
              color: Color(0xFF586477),
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 16),

          const Divider(height: 1, color: borderColor),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ActionButton(
                  icon: post.isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  text: "${post.likesCount}",
                  isLiked: post.isLiked,
                  onTap: () => controller.toggleLike(post.id),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ActionButton(
                  icon: Icons.chat_bubble_outline_rounded,
                  text: "${post.commentsCount}",
                  onTap: () => controller.openComment(post.id),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
