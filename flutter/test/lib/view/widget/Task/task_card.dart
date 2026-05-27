import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/home/task_screen_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/model/static/Task/task_model.dart';

class TaskCard extends GetView<TaskScreenController> {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bool done = task.isDone;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border(
          right: BorderSide(
            color: done ? Colors.green : Colors.orange,
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'edit') {
                controller.startEditTask(task);
              }

              if (value == 'delete') {
                controller.confirmDeleteTask(task.id);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('تعديل المهمة')),
              PopupMenuItem(value: 'delete', child: Text('حذف المهمة')),
            ],
          ),

          const Spacer(),

          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  task.title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: done ? Colors.grey : Appcolor.black,
                    decoration: done ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  task.description,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  task.dueDate,
                  style: const TextStyle(
                    color: Appcolor.scondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          GestureDetector(
            onTap: () => controller.completeTask(task),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: done ? Colors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: done ? Colors.green : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: done
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
