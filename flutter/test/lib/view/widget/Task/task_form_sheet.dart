import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/home/task_screen_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class TaskFormSheet extends GetView<TaskScreenController> {
  const TaskFormSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
        top: 18,
        bottom: MediaQuery.of(context).viewInsets.bottom + 18,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              controller.editingTaskId.value == 0
                  ? "إضافة مهمة"
                  : "تعديل المهمة",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            field(controller: controller.titleController, hint: "عنوان المهمة"),
            const SizedBox(height: 12),
            field(
              controller: controller.descriptionController,
              hint: "وصف المهمة",
              maxLines: 3,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: controller.dateController,
              readOnly: true,

              textAlign: TextAlign.right,
              onTap: () => controller.pickDate(context),
              decoration: InputDecoration(
                hintText: "تاريخ المهمة",
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.08),
                suffixIcon: const Icon(Icons.calendar_month),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Appcolor.primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: controller.isSaving.value
                    ? null
                    : controller.createOrUpdateTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: controller.isSaving.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        controller.editingTaskId.value == 0
                            ? "إضافة"
                            : "حفظ التعديل",
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget field({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.5)),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.08),
          contentPadding: const EdgeInsets.all(18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Appcolor.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
