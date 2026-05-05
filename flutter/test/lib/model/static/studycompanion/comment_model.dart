class CommentModel {
  final int id;
  final int postId;
  final String content;
  final int usersid;
  final bool isOwner;
  final String userName;
  CommentModel({
    required this.id,
    required this.postId,
    required this.content,
    required this.usersid, required this.isOwner, required this.userName,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['post_id'],
      content: json['content'],
      usersid: json['usersid'],
      isOwner: json['is_owner'],
      userName: json['user_name'],
    );
  }
}
