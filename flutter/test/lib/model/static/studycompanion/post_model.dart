class PostModel {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String userName;
  final bool isOwner;

  int likesCount;   // ✅ بدون final وبدون ?
  bool isLiked;     // ✅ بدون final وبدون ?
  int commentsCount; // ✅ بدون final وبدون ?
  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.userName,
    required this.isOwner,
    required this.likesCount,
    required this.isLiked,
    required this.commentsCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(

      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'] ?? '',
      userName: json['user']?['full_name'] ?? '',
      isOwner: json['is_owner'] ?? false,
      likesCount: json['likes_count'] ?? 0,
      isLiked: json['is_liked'] ?? false,
      commentsCount: json['comments_count'] ?? 0,
    );
  }
}