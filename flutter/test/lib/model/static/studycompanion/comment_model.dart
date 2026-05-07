import 'package:test/core/class/constant/storagehandler.dart';

class CommentModel {
  final int id;
  final int postId;
  final String content;
  final int usersid;
  final bool isOwner;
  final String userName;
  final String createdAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.content,
    required this.usersid,
    required this.isOwner,
    required this.userName,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    /// 🟣 المستخدم الحالي
    final int currentUserId = StorageHandler().userId;

    /// 🟣 صاحب التعليق
    final int commentUserId =
        int.tryParse(json['user']?['id']?.toString() ?? '0') ?? 0;

    return CommentModel(
      id: int.tryParse(json['id'].toString()) ?? 0,

      postId: int.tryParse(json['post_id']?.toString() ?? '0') ?? 0,

      content: json['content']?.toString() ?? '',

      usersid: commentUserId,

      /// ✅ هل التعليق إلي؟
      isOwner: currentUserId == commentUserId,

      userName:
          json['user']?['fullname']?.toString() ??
          json['user']?['full_name']?.toString() ??
          json['user_name']?.toString() ??
          '',

      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}
