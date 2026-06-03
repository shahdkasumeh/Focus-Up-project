import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/studycompanion/comment_input.dart';

class CommentBottomSheet extends StatelessWidget {
  final int postId;
  final StudyCompanionController controller;

  const CommentBottomSheet({
    super.key,
    required this.postId,
    required this.controller,
  });

  static const Color goldColor = Color(0xFFF4C542);
  static const Color sheetBackground = Color(0xFFF8F9FC);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final keyboardHeight = media.viewInsets.bottom;
    final screenHeight = media.size.height;

    // ارتفاع الـ Bottom Sheet ثابت وما بيتغير مع ظهور الكيبورد
    final sheetHeight = screenHeight * 0.76;

    // مساحة مخصصة لحقل إدخال التعليق
    final inputSpace = keyboardHeight > 0 ? 72.0 : 92.0;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: sheetHeight,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: sheetBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: Obx(() {
                        if (controller.commentsLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Appcolor.scondary,
                            ),
                          );
                        }

                        final comments = controller.commentsMap[postId] ?? [];

                        if (comments.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: keyboardHeight + inputSpace,
                            ),
                            child: _buildEmptyComments(),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.fromLTRB(
                            16,
                            12,
                            16,
                            keyboardHeight + inputSpace + 12,
                          ),
                          physics: const BouncingScrollPhysics(),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                10,
                                12,
                                12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: comment.isOwner
                                    ? Border.all(
                                        color: Appcolor.scondary.withValues(
                                          alpha: 0.10,
                                        ),
                                      )
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(
                                      alpha: 0.035,
                                    ),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Appcolor.scondary.withValues(
                                            alpha: 0.10,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: goldColor.withValues(
                                              alpha: 0.35,
                                            ),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.person_rounded,
                                          size: 20,
                                          color: Appcolor.scondary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      // الاسم صار يطلع كامل وينزل على سطر جديد
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 7,
                                          ),
                                          child: Text(
                                            comment.userName,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            maxLines: null,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              height: 1.35,
                                              fontWeight: FontWeight.w800,
                                              color: Appcolor.scondary,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 6),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            comment.createdAt,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade500,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (comment.isOwner)
                                            SizedBox(
                                              width: 36,
                                              height: 34,
                                              child: PopupMenuButton<String>(
                                                padding: EdgeInsets.zero,
                                                icon: Icon(
                                                  Icons.more_horiz_rounded,
                                                  color: Colors.grey.shade500,
                                                  size: 21,
                                                ),
                                                color: Colors.white,
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                    controller.startEditComment(
                                                      comment,
                                                    );
                                                  } else if (value ==
                                                      'delete') {
                                                    controller.deleteComment(
                                                      postId,
                                                      comment.id,
                                                    );
                                                  }
                                                },
                                                itemBuilder: (context) => const [
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.edit_outlined,
                                                          size: 19,
                                                          color:
                                                              Appcolor.scondary,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text('تعديل التعليق'),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .delete_outline_rounded,
                                                          size: 19,
                                                          color: Colors.red,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'حذف التعليق',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 7),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      end: 44,
                                      start: 4,
                                    ),
                                    child: Text(
                                      comment.content,
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.4,
                                        color: Color(0xFF343740),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),

                // حقل التعليق مستقل، لذلك ما بيسبب Bottom Overflow
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  left: 0,
                  right: 0,
                  bottom: keyboardHeight,
                  child: CommentInput(postId: postId),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 9),
          Container(
            width: 43,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD6D9E0),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 11),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4F7),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE8EAF0)),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Appcolor.scondary,
                      size: 20,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'التعليقات',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Appcolor.scondary,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 34),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEFEFF4)),
        ],
      ),
    );
  }

  Widget _buildEmptyComments() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Appcolor.scondary.withValues(alpha: 0.07),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mode_comment_outlined,
              size: 29,
              color: Appcolor.scondary,
            ),
          ),
          const SizedBox(height: 13),
          const Text(
            'لا توجد تعليقات بعد',
            style: TextStyle(
              color: Appcolor.scondary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'اكتبي أول تعليق',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
