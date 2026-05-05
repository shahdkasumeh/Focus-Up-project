import 'package:flutter/material.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/model/static/studycompanion/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final StudyCompanionController controller;

  const PostCard({super.key, required this.post, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              if (post.isOwner)
                IconButton(
                  onPressed: () => controller.confirmDeletePost(post.id),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      post.userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post.createdAt,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            post.title,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // 📄 CONTENT
          Text(post.content, textAlign: TextAlign.right),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => controller.openComment(post.id),
                  icon: const Icon(Icons.chat_bubble_outline, size: 18),
                  label: Text(
                    "(${post.commentsCount})",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // LIKE BUTTON
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    controller.toggleLike(post.id);
                  },
                  icon: Icon(
                    post.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border_rounded,
                    color: post.isLiked ? Colors.red : Colors.black87,
                  ),
                  label: Text(
                    "${post.likesCount}",
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
