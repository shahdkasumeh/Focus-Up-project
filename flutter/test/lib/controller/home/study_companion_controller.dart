import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/model/static/studycompanion/comment_model.dart';
import 'package:test/model/static/studycompanion/post_model.dart';
import 'package:test/view/widget/studycompanion/comment_bottom_sheet.dart';

class StudyCompanionController extends GetxController {
  var isLoading = false.obs;

  var posts = <PostModel>[].obs;
  var commentsMap = <int, List<CommentModel>>{}.obs;
  var openComments = <int>{}.obs;
  var commentsLoading = false.obs;
  var editingCommentId = 0.obs;

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

  void openComment(int postId) {
    commentController.clear();
    editingCommentId.value = 0;

    getComments(postId);

    Get.bottomSheet(
      CommentBottomSheet(postId: postId, controller: this),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

  Future<void> getComments(int postId) async {
    commentsLoading.value = true;

    //   try {
    //     final response = await studyCompanionData.getComments(postId);

    //     commentsMap[postId] = List<CommentModel>.from(
    //       response['data'].map((e) => CommentModel.fromJson(e)),
    //     );

    //     commentsMap.refresh();
    //   } catch (e) {
    //     Get.snackbar("خطأ", "فشل تحميل التعليقات");
    //   }

    //   commentsLoading.value = false;
    // }
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
    //   try {
    //     final response = await studyCompanionData.addComment(
    //       postId: postId,
    //       content: content,
    //     );

    //     final newComment = CommentModel.fromJson(response['data']);

    //     commentsMap[postId] = [newComment, ...commentsMap[postId] ?? []];

    //     commentsMap.refresh();
    //   } catch (e) {
    //     Get.snackbar("خطأ", "فشل إضافة التعليق");
    //   }
    // }
  }

  void startEditComment(CommentModel comment) {
    editingCommentId.value = comment.id;
    commentController.text = comment.content;
  }

  Future<void> updateComment(int postId, int commentId, String content) async {
    //   try {
    //     final response = await studyCompanionData.updateComment(
    //       commentId: commentId,
    //       content: content,
    //     );

    //     final updatedComment = CommentModel.fromJson(response['data']);

    //     final list = commentsMap[postId] ?? [];
    //     final index = list.indexWhere((e) => e.id == commentId);

    //     if (index != -1) {
    //       list[index] = updatedComment;
    //       commentsMap[postId] = list;
    //       commentsMap.refresh();
    //     }
    //   } catch (e) {
    //     Get.snackbar("خطأ", "فشل تعديل التعليق");
    //   }
    // }
  }

  Future<void> deleteComment(int postId, int commentId) async {
    //   try {
    //     await studyCompanionData.deleteComment(commentId);

    //     commentsMap[postId]?.removeWhere((e) => e.id == commentId);
    //     commentsMap.refresh();
    //   } catch (e) {
    //     Get.snackbar("خطأ", "فشل حذف التعليق");
    //   }
    // }
  }

  // 🔵 GET POSTS
  Future<void> getPosts() async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    posts.value = [
      PostModel(
        id: 1,
        title: "مساعدة",
        content: "مين فاهم normalization؟ 😭",
        createdAt: "منذ 5 دقائق",
        userName: "راما",
        isOwner: true,
        likesCount: 3,
        isLiked: false,
        commentsCount: 0,
      ),
      PostModel(
        id: 2,
        title: "سؤال",
        content: "شو أفضل طريقة لدراسة الشبكات؟",
        createdAt: "منذ 10 دقائق",
        userName: "لانا",
        isOwner: false,
        likesCount: 5,
        isLiked: true,
        commentsCount: 3,
      ),
    ];

    isLoading.value = false;
  }

  // 🟢 CREATE POST (جاهز للباك لاحقًا)
  Future<void> createPost() async {
    final text = contentController.text.trim();
    if (text.isEmpty) return;

    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 400));

    posts.insert(
      0,
      PostModel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: "إعلان",
        content: text,
        createdAt: "الآن",
        userName: "Me",
        isOwner: true,
        likesCount: 0,
        isLiked: false,
        commentsCount: 1,
      ),
    );

    contentController.clear();
    isLoading.value = false;
  }

  // ❤️ TOGGLE LIKE
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
  }

  // 🗑 DELETE
  void deletePost(int postId) {
    posts.removeWhere((p) => p.id == postId);
  }

  // ⚠️ CONFIRM DELETE
  void confirmDeletePost(int postId) {
    final post = posts.firstWhere(
      (p) => p.id == postId,
      orElse: () => PostModel(
        id: -1,
        title: '',
        content: '',
        createdAt: '',
        userName: '',
        isOwner: false,
        likesCount: 0,
        isLiked: false,
        commentsCount: 1,
      ),
    );

    if (post.id == -1) return;

    if (!post.isOwner) {
      Get.snackbar(
        "غير مسموح",
        "لا يمكنك حذف إعلان ليس لك",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.defaultDialog(
      title: "حذف الإعلان",
      middleText: "هل أنتِ متأكدة من حذف هذا الإعلان؟",
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

  void toggleComments(int postId) {
    if (openComments.contains(postId)) {
      openComments.remove(postId);
    } else {
      openComments.add(postId);
    }
  }

  void showComments(int postId) {
    toggleComments(postId);
    if (!commentsMap.containsKey(postId)) {
      // 👇 إذا التعليقات غير موجودة، نضيف تعليقات تجريبية
      commentsMap[postId] = [
        CommentModel(
          id: 1,
          postId: postId,
          content: "أنا كمان مش فاهمة normalization 😅",
          usersid: 2,
          isOwner: false,
          userName: "لانا",
        ),
        CommentModel(
          id: 2,
          postId: postId,
          content: "جربت تشرحها لأحد؟ دايمًا بيساعدني",
          usersid: 3,
          isOwner: false,
          userName: "سارة",
        ),
      ];
    }
  }
}
