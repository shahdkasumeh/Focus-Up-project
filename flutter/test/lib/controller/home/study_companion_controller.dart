// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/study_companion_data.dart';
import 'package:test/model/static/studycompanion/comment_model.dart';
import 'package:test/model/static/studycompanion/post_model.dart';
import 'package:test/view/widget/studycompanion/comment_bottom_sheet.dart';

class StudyCompanionController extends GetxController {
  final StudyCompanionData studyCompanionData = StudyCompanionData(Crud());

  var isLoading = false.obs;
  var isCreating = false.obs;
  var commentsLoading = false.obs;
  var isCommenting = false.obs;

  var posts = <PostModel>[].obs;
  var commentsMap = <int, List<CommentModel>>{}.obs;
  var openComments = <int>{}.obs;

  var editingCommentId = 0.obs;
  var editingPostId = 0.obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    commentController.dispose();
    super.onClose();
  }

  Future<void> getPosts() async {
    try {
      isLoading.value = true;

      final response = await studyCompanionData.getPosts();

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) {
          final data = success["data"];

          if (data != null && data is List) {
            posts.assignAll(
              data
                  .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
            );

            for (final post in posts) {
              commentsMap[post.id] = commentsMap[post.id] ?? [];
            }
          } else {
            posts.clear();
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrUpdatePost() async {
    if (editingPostId.value == 0) {
      await createPost();
    } else {
      await updatePost();
    }
  }

  Future<void> createPost() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar("تنبيه", "اكتبي العنوان والمحتوى");
      return;
    }

    try {
      isCreating.value = true;

      final response = await studyCompanionData.createPost(
        title: title,
        content: content,
      );

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) {
          final data = success["data"];

          if (data != null && data is Map<String, dynamic>) {
            final newPost = PostModel.fromJson(data);

            posts.insert(0, newPost);
            commentsMap[newPost.id] = [];
          }

          titleController.clear();
          contentController.clear();
          editingPostId.value = 0;

          Get.snackbar("تم", "تم نشر البوست");
        },
      );
    } finally {
      isCreating.value = false;
    }
  }

  void startEditPost(PostModel post) {
    if (!post.isOwner) {
      Get.snackbar("غير مسموح", "لا يمكنك تعديل بوست ليس لك");
      return;
    }

    editingPostId.value = post.id;
    titleController.text = post.title;
    contentController.text = post.content;
  }

  void cancelEditPost() {
    editingPostId.value = 0;
    titleController.clear();
    contentController.clear();
  }

  Future<void> updatePost() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar("تنبيه", "اكتبي العنوان والمحتوى");
      return;
    }

    try {
      isCreating.value = true;

      final response = await studyCompanionData.updatePost(
        postId: editingPostId.value,
        title: title,
        content: content,
      );
      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) async {
          final data = success["data"];

          if (data != null && data is Map<String, dynamic>) {
            final updatedPost = PostModel.fromJson(data);
            final index = posts.indexWhere((p) => p.id == updatedPost.id);

            if (index != -1) {
              posts[index] = updatedPost;
              posts.refresh();
            }
          } else {
            await getPosts();
          }

          titleController.clear();
          contentController.clear();
          editingPostId.value = 0;

          Get.snackbar("تم", "تم تعديل البوست");
        },
      );
    } finally {
      isCreating.value = false;
    }
  }

  Future<void> deletePost(int postId) async {
    final response = await studyCompanionData.deletePost(postId);

    response.fold(
      (failure) {
        Get.snackbar("خطأ", failure.message);
      },
      (success) {
        posts.removeWhere((p) => p.id == postId);
        commentsMap.remove(postId);

        if (editingPostId.value == postId) {
          cancelEditPost();
        }

        Get.snackbar("تم", "تم حذف البوست");
      },
    );
  }

  void confirmDeletePost(int postId) {
    final post = posts.firstWhereOrNull((p) => p.id == postId);

    if (post == null) return;

    if (!post.isOwner) {
      Get.snackbar(
        "غير مسموح",
        "لا يمكنك حذف إعلان ليس لك",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.defaultDialog(
      title: "حذف البوست",
      middleText: "هل أنتِ متأكدة من حذف هذا البوست؟",
      textConfirm: "حذف",
      textCancel: "إلغاء",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        deletePost(postId);
      },
    );
  }

  void openComment(int postId) {
    commentController.clear();
    editingCommentId.value = 0;

    getComments(postId);

    Get.bottomSheet(
      CommentBottomSheet(postId: postId, controller: this),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> getComments(int postId) async {
    try {
      commentsLoading.value = true;

      final response = await studyCompanionData.getSinglePost(postId);

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) {
          final data = success["data"];

          if (data != null && data is Map<String, dynamic>) {
            final comments = data["comments"];

            if (comments != null && comments is List) {
              commentsMap[postId] = comments
                  .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
                  .toList();

              commentsMap.refresh();
            }

            final index = posts.indexWhere((p) => p.id == postId);

            if (index != -1) {
              posts[index] = PostModel.fromJson(data);
              posts.refresh();
            }
          }
        },
      );
    } finally {
      commentsLoading.value = false;
    }
  }

  Future<void> addOrUpdateComment(int postId) async {
    final text = commentController.text.trim();

    if (text.isEmpty) return;

    if (editingCommentId.value == 0) {
      await addComment(postId, text);
    } else {
      await updateComment(postId, editingCommentId.value, text);
    }

    commentController.clear();
    editingCommentId.value = 0;
  }

  Future<void> addComment(int postId, String content) async {
    try {
      isCommenting.value = true;

      final response = await studyCompanionData.addComment(
        postId: postId,
        content: content,
      );

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) async {
          final data = success["data"];
          if (data != null && data is Map<String, dynamic>) {
            final newComment = CommentModel.fromJson(data);
            final oldList = commentsMap[postId] ?? [];

            commentsMap[postId] = [newComment, ...oldList];

            commentsMap.refresh();

            final postIndex = posts.indexWhere((p) => p.id == postId);

            if (postIndex != -1) {
              posts[postIndex].commentsCount++;
              posts.refresh();
            }
          }

          await getComments(postId);
        },
      );
    } finally {
      isCommenting.value = false;
    }
  }

  void startEditComment(CommentModel comment) {
    editingCommentId.value = comment.id;
    commentController.text = comment.content;
  }

  Future<void> updateComment(int postId, int commentId, String content) async {
    final text = content.trim();

    if (text.isEmpty) return;

    try {
      isCommenting.value = true;

      final response = await studyCompanionData.updateComment(
        postId: postId,
        commentId: commentId,
        content: text,
      );

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) async {
          final data = success["data"];

          if (data != null && data is Map<String, dynamic>) {
            final updatedComment = CommentModel.fromJson(data);

            final list = commentsMap[postId] ?? [];
            final index = list.indexWhere((e) => e.id == commentId);

            if (index != -1) {
              list[index] = updatedComment;
              commentsMap[postId] = list;
              commentsMap.refresh();
            }
          } else {
            await getComments(postId);
          }

          editingCommentId.value = 0;
          commentController.clear();

          Get.snackbar("تم", "تم تعديل التعليق");
        },
      );
    } finally {
      isCommenting.value = false;
    }
  }

  Future<void> deleteComment(int postId, int commentId) async {
    final response = await studyCompanionData.deleteComment(
      postId: postId,
      commentId: commentId,
    );

    response.fold(
      (failure) {
        Get.snackbar("خطأ", failure.message);
      },
      (success) {
        commentsMap[postId]?.removeWhere((e) => e.id == commentId);
        commentsMap.refresh();

        final postIndex = posts.indexWhere((p) => p.id == postId);

        if (postIndex != -1 && posts[postIndex].commentsCount > 0) {
          posts[postIndex].commentsCount--;
          posts.refresh();
        }

        if (editingCommentId.value == commentId) {
          editingCommentId.value = 0;
          commentController.clear();
        }

        Get.snackbar("تم", "تم حذف التعليق");
      },
    );
  }

  void toggleLike(int postId) {
    final index = posts.indexWhere((p) => p.id == postId);

    if (index == -1) return;

    final post = posts[index];

    if (post.isLiked) {
      post.isLiked = false;
      post.likesCount--;
    } else {
      post.isLiked = true;
      post.likesCount++;
    }

    posts[index] = post;
    posts.refresh();
  }

  void toggleComments(int postId) {
    if (openComments.contains(postId)) {
      openComments.remove(postId);
    } else {
      openComments.add(postId);
      getComments(postId);
    }

    openComments.refresh();
  }

  void showComments(int postId) {
    toggleComments(postId);
  }
}
