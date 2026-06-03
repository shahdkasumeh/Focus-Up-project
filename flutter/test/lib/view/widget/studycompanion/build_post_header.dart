import 'package:flutter/material.dart';
import 'package:test/model/static/studycompanion/post_model.dart';

class BuildPostHeader extends StatelessWidget {
  final PostModel post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BuildPostHeader({
    required this.post,
    required this.onEdit,
    required this.onDelete,
  });

  static const Color navyColor = Color(0xFF172F4F);
  static const Color yellowColor = Color(0xFFF4C542);
  static const Color greyTextColor = Color(0xFF8792A5);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 23,
          backgroundColor: yellowColor.withValues(alpha: 0.24),
          child: Text(
            post.userName.isNotEmpty ? post.userName[0].toUpperCase() : '?',
            style: const TextStyle(
              color: navyColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: navyColor,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    color: greyTextColor,
                    size: 13,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      post.createdAt,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: greyTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        if (post.isOwner)
          PopupMenuButton<String>(
            tooltip: "",
            padding: EdgeInsets.zero,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: greyTextColor,
              size: 25,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit_outlined, color: navyColor, size: 19),
                    SizedBox(width: 10),
                    Text(
                      'تعديل المنشور',
                      style: TextStyle(
                        color: navyColor,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
             const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xFFD95050),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'حذف المنشور',
                      style: TextStyle(
                        color: Color(0xFFD95050),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        else
          const SizedBox(width: 39),
      ],
    );
  }
}
