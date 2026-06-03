import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/task_screen_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/Task/empty_tasks_widget.dart';
import 'package:test/view/widget/Task/header_task.dart';
import 'package:test/view/widget/Task/task_card.dart';

class TaskScreen extends GetView<TaskScreenController> {
  const TaskScreen({super.key});

  static const Color navyColor = Color(0xFF172F4F);
  static const Color yellowColor = Color(0xFFF4C542);
  static const Color backgroundColor = Color(0xFFF5F7FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            const HeaderTask(),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: navyColor),
                  );
                }
                return RefreshIndicator(
                  color: navyColor,
                  onRefresh: controller.getTasksByDate,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: const EdgeInsets.fromLTRB(14, 18, 14, 95),
                    children: [
                      Row(
                        children: [
                          const Text(
                            "مهام اليوم",
                            style: TextStyle(
                              color: navyColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Divider(
                              color: Color(0xFFE0E5ED),
                              thickness: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: yellowColor.withValues(alpha: 0.22),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${controller.tasks.length}",
                              style: const TextStyle(
                                color: navyColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      if (controller.tasks.isEmpty)
                        const EmptyTasksWidget()
                      else
                        ...controller.tasks.map(
                          (task) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: TaskCard(task: task),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: navyColor,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        onPressed: () {
          controller.clearForm();
          controller.openTaskSheet();
        },
        icon: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: yellowColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.add_rounded,
            color: Appcolor.navyColor,
            size: 20,
          ),
        ),
        label: const Text(
          "مهمة جديدة",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

