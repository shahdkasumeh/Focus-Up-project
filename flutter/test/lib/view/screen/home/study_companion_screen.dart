import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/studycompanion/compose_box.dart';
import 'package:test/view/widget/studycompanion/empty_posts_widget.dart';
import 'package:test/view/widget/studycompanion/post_card.dart';
import 'package:test/view/widget/studycompanion/posts_summary_card.dart';

class StudyCompanionScreen extends GetView<StudyCompanionController> {
  const StudyCompanionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolor.navyColor),
            );
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 165,
                backgroundColor: Appcolor.navyColor,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                centerTitle: true,
                title: const Text(
                  "رفيق الدراسة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF172F4F), Color(0xFF21486B)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 62, 18, 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    "مساحتك الدراسية",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "شارك أفكارك وساعد رفقاتك بالدراسة",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color: Appcolor.yellowColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(
                                Icons.school_rounded,
                                color: Appcolor.navyColor,
                                size: 29,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
                  child: PostsSummaryCard(postsCount: controller.posts.length),
                ),
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: ComposeBox(),
                ),
              ),

              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 22, 16, 12),
                  child: Row(
                    children: [
                      Text(
                        "آخر المنشورات",
                        style: TextStyle(
                          color: Appcolor.navyColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Divider(color: Color(0xFFE0E5ED), thickness: 1),
                      ),
                    ],
                  ),
                ),
              ),

              if (controller.posts.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyPostsWidget(),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 18),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final post = controller.posts[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: PostCard(post: post),
                      );
                    }, childCount: controller.posts.length),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
