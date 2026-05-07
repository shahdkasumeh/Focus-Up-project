class PostModel {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String userName;
  final bool isOwner;

  int likesCount;
  bool isLiked;
  int commentsCount;

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
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      userName: json['user']?['full_name']?.toString() ?? '',
      isOwner: json['is_owner'] == true,
      likesCount: int.tryParse(json['likes_count'].toString()) ?? 0,
      isLiked: json['is_liked'] == true,
      commentsCount: int.tryParse(json['comments_count'].toString()) ?? 0,
    );
  }
}