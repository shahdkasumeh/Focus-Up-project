import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/task_screen_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/Task/date_field.dart';
import 'package:test/view/widget/Task/task_text_field.dart';

class TaskFormSheet extends GetView<TaskScreenController> {
  const TaskFormSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 22),
            child: Obx(() {
              final bool isEditing = controller.editingTaskId.value != 0;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE1E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Container(
                        width: 49,
                        height: 49,
                        decoration: BoxDecoration(
                          color: Appcolor.yellowColor.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          isEditing
                              ? Icons.edit_calendar_rounded
                              : Icons.add_task_rounded,
                          color: Appcolor.navyColor,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isEditing ? "تعديل المهمة" : "إضافة مهمة جديدة",
                              style: const TextStyle(
                                color: Appcolor.navyColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isEditing
                                  ? "عدّلي تفاصيل المهمة واحفظي التغييرات"
                                  : "أضيفي مهمة جديدة لتنظيم يومك",
                              style: const TextStyle(
                                color: Color(0xFF8792A5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),
                  TaskTextField(
                    controller: controller.titleController,
                    hintText: "عنوان المهمة",
                    icon: Icons.title_rounded,
                  ),

                  const SizedBox(height: 12),

                  TaskTextField(
                    controller: controller.descriptionController,
                    hintText: "وصف المهمة",
                    icon: Icons.notes_rounded,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 12),

                  DateField(
                    controller: controller.dateController,
                    onTap: () => controller.pickDate(context),
                  ),

                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    height: 53,
                    child: ElevatedButton(
                      onPressed: controller.isSaving.value
                          ? null
                          : controller.createOrUpdateTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.navyColor,
                        disabledBackgroundColor: Appcolor.navyColor.withValues(
                          alpha: 0.65,
                        ),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: controller.isSaving.value
                          ? const SizedBox(
                              width: 23,
                              height: 23,
                              child: CircularProgressIndicator(
                                color: Appcolor.yellowColor,
                                strokeWidth: 2.3,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isEditing
                                      ? Icons.save_outlined
                                      : Icons.add_task_rounded,
                                  color: Appcolor.yellowColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isEditing ? "حفظ التعديل" : "إضافة المهمة",
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

