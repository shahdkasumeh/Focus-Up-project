
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/home/task_screen_controller.dart';
import 'package:test/model/static/Task/task_model.dart';

class TaskCard extends GetView<TaskScreenController> {
  final TaskModel task;

  const TaskCard({
    super.key,
    required this.task,
  });

  static const Color navyColor = Color(0xFF172F4F);
  static const Color yellowColor = Color(0xFFF4C542);
  static const Color borderColor = Color(0xFFE9EDF3);
  static const Color greyTextColor = Color(0xFF8792A5);
  static const Color completedColor = Color(0xFF3DA57A);

  @override
  Widget build(BuildContext context) {
    final bool done = task.isDone;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: done
                ? completedColor.withValues(alpha: 0.18)
                : borderColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CompleteButton(
              isDone: done,
              onTap: () => controller.completeTask(task),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: done
                                ? const Color(0xFF929BAD)
                                : navyColor,
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            decoration: done
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: const Color(0xFF929BAD),
                            decorationThickness: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _StatusBadge(isDone: done),
                    ],
                  ),

                  if (task.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      task.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: done
                            ? greyTextColor.withValues(alpha: 0.7)
                            : const Color(0xFF667286),
                        fontSize: 13,
                        height: 1.55,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),decoration: BoxDecoration(
                      color: done
                          ? completedColor.withValues(alpha: 0.08)
                          : yellowColor.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          done
                              ? Icons.event_available_rounded
                              : Icons.calendar_today_rounded,
                          color: done ? completedColor : navyColor,
                          size: 15,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            task.dueDate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: done ? completedColor : navyColor,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            _TaskMenuButton(
              onEdit: () => controller.startEditTask(task),
              onDelete: () => controller.confirmDeleteTask(task.id),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompleteButton extends StatelessWidget {
  final bool isDone;
  final VoidCallback onTap;

  const _CompleteButton({
    required this.isDone,
    required this.onTap,
  });

  static const Color navyColor = Color(0xFF172F4F);
  static const Color yellowColor = Color(0xFFF4C542);
  static const Color completedColor = Color(0xFF3DA57A);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDone
          ? completedColor
          : yellowColor.withValues(alpha: 0.17),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDone
                  ? completedColor
                  : yellowColor.withValues(alpha: 0.45),
            ),
          ),
          child: Icon(
            isDone
                ? Icons.check_rounded
                : Icons.check_box_outline_blank_rounded,
            color: isDone ? Colors.white : navyColor,
            size: isDone ? 24 : 22,
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isDone;

  const _StatusBadge({
    required this.isDone,
  });

  static const Color navyColor = Color(0xFF172F4F);
  static const Color yellowColor = Color(0xFFF4C542);
  static const Color completedColor = Color(0xFF3DA57A);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isDone
            ? completedColor.withValues(alpha: 0.12)
            : yellowColor.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        isDone ? "مكتملة" : "قيد التنفيذ",
        style: TextStyle(
          color: isDone ? completedColor : navyColor,
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _TaskMenuButton extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TaskMenuButton({
    required this.onEdit,
    required this.onDelete,
  });static const Color navyColor = Color(0xFF172F4F);
  static const Color greyTextColor = Color(0xFF8792A5);
  static const Color deleteColor = Color(0xFFD95050);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: "",
      padding: EdgeInsets.zero,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      icon: const Icon(
        Icons.more_vert_rounded,
        color: greyTextColor,
        size: 23,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: [
              Icon(
                Icons.edit_outlined,
                color: navyColor,
                size: 19,
              ),
              SizedBox(width: 10),
              Text(
                'تعديل المهمة',
                style: TextStyle(
                  color: navyColor,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                color: deleteColor,
                size: 20,
              ),
              SizedBox(width: 10),
              Text(
                'حذف المهمة',
                style: TextStyle(
                  color: deleteColor,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}