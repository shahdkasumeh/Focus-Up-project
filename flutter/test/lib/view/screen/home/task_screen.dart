import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/task_screen_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/Task/header_task.dart';
import 'package:test/view/widget/Task/task_card.dart';

class TaskScreen extends GetView<TaskScreenController> {
  const TaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: Column(
        children: [
          HeaderTask(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Appcolor.scondary),
                );
              }
              if (controller.tasks.isEmpty) {
                return const Center(
                  child: Text(
                    "لا توجد مهام لهذا اليوم",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                color: Appcolor.scondary,
                onRefresh: controller.getTasksByDate,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 100),
                  children: [
                    const Text(
                      "مهام اليوم",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Appcolor.black,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...controller.tasks.map((task) => TaskCard(task: task)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Appcolor.primary,
        onPressed: () {
          controller.clearForm();
          controller.openTaskSheet();
        },
        label: const Text(
          "+ مهمة جديدة",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
