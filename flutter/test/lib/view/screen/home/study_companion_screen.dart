import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/view/widget/studycompanion/compose_box.dart';
import 'package:test/view/widget/studycompanion/post_card.dart';

class StudyCompanionScreen extends GetView<StudyCompanionController> {
  const StudyCompanionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "رفيق الدراسة",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF172F4F),
        leading: const BackButton(color: Colors.white),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(14),
          children: [
            // 🟢 Compose Box
            const ComposeBox(),

            const SizedBox(height: 14),

            // 📌 POSTS LIST
            if (controller.posts.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    "لا توجد منشورات بعد",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ...controller.posts.map(
                (post) => PostCard(post: post, controller: controller),
              ),
          ],
        );
      }),
    );
  }
}
