import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/Task/task_data.dart';
import 'package:test/model/static/Task/task_model.dart';
import 'package:test/view/widget/Task/task_form_sheet.dart';

class TaskScreenController extends GetxController {
  final TaskData taskData = TaskData(Crud());

  RxBool isLoading = false.obs;
  RxBool isSaving = false.obs;

  RxList<TaskModel> tasks = <TaskModel>[].obs;

  RxString selectedDate = ''.obs;
  RxInt editingTaskId = 0.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final now = DateTime.now();

    selectedDate.value =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    dateController.text = selectedDate.value;

    getTasksByDate();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.onClose();
  }

  int get doneCount => tasks.where((e) => e.isDone).length;

  double get progress {
    if (tasks.isEmpty) return 0;
    return doneCount / tasks.length;
  }

  Future<void> getTasksByDate() async {
    try {
      isLoading.value = true;

      final response = await taskData.getTasksByDate(selectedDate.value);

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) {
          final data = success["data"];

          if (data != null && data is List) {
            tasks.assignAll(data.map((e) => TaskModel.fromJson(e)).toList());
          } else {
            tasks.clear();
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrUpdateTask() async {
    if (editingTaskId.value == 0) {
      await createTask();
    } else {
      await updateTask();
    }
  }

  Future<void> createTask() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final dueDate = dateController.text.trim();

    if (title.isEmpty || description.isEmpty || dueDate.isEmpty) {
      Get.snackbar("تنبيه", "املئي كل الحقول");
      return;
    }

    try {
      isSaving.value = true;

      final response = await taskData.createTask(
        title: title,
        description: description,
        dueDate: dueDate,
      );

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) {
          final data = success["data"];

          if (data != null && data is Map<String, dynamic>) {
            tasks.insert(0, TaskModel.fromJson(data));
          }

          clearForm();
          Get.back();
          Get.snackbar("تم", "تمت إضافة المهمة");
        },
      );
    } finally {
      isSaving.value = false;
    }
  }

  void startEditTask(TaskModel task) {
    editingTaskId.value = task.id;
    titleController.text = task.title;
    descriptionController.text = task.description;
    dateController.text = task.dueDate;

    openTaskSheet();
  }

  Future<void> updateTask() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final dueDate = dateController.text.trim();

    try {
      isSaving.value = true;

      final response = await taskData.updateTask(
        taskId: editingTaskId.value,
        title: title,
        description: description,
        dueDate: dueDate,
      );

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) {
          final data = success["data"];

          if (data != null && data is Map<String, dynamic>) {
            final updatedTask = TaskModel.fromJson(data);
            final index = tasks.indexWhere((e) => e.id == updatedTask.id);
            if (index != -1) {
              tasks[index] = updatedTask;
              tasks.refresh();
            }
          }

          clearForm();
          Get.back();
          Get.snackbar("تم", "تم تعديل المهمة");
        },
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> completeTask(TaskModel task) async {
    if (task.isDone) return;

    final response = await taskData.completeTask(task.id);

    response.fold(
      (failure) {
        Get.snackbar("خطأ", failure.message);
      },
      (success) {
        final data = success["data"];

        if (data != null && data is Map<String, dynamic>) {
          final updatedTask = TaskModel.fromJson(data);
          final index = tasks.indexWhere((e) => e.id == updatedTask.id);

          if (index != -1) {
            tasks[index] = updatedTask;
            tasks.refresh();
          }
        }
      },
    );
  }

  Future<void> deleteTask(int taskId) async {
    final response = await taskData.deleteTask(taskId);

    response.fold(
      (failure) {
        Get.snackbar("خطأ", failure.message);
      },
      (success) {
        tasks.removeWhere((e) => e.id == taskId);
        Get.snackbar("تم", "تم حذف المهمة");
      },
    );
  }

  void confirmDeleteTask(int taskId) {
    Get.defaultDialog(
      title: "حذف المهمة",
      middleText: "هل أنتِ متأكدة من حذف هذه المهمة؟",
      textConfirm: "حذف",
      textCancel: "إلغاء",
      confirmTextColor: Colors.white,
      buttonColor: Colors.grey,
      onConfirm: () {
        Get.back();
        deleteTask(taskId);
      },
    );
  }

  Future<void> pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: DateTime.tryParse(selectedDate.value) ?? DateTime.now(),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Appcolor.scondary, // اللون الثانوي
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      selectedDate.value =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      dateController.text = selectedDate.value;

      await getTasksByDate();
    }
  }

  void clearForm() {
    editingTaskId.value = 0;
    titleController.clear();
    descriptionController.clear();
    dateController.text = selectedDate.value;
  }

  void openTaskSheet() {
    Get.bottomSheet(
      const TaskFormSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
