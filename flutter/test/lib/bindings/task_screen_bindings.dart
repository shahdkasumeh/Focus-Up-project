import 'package:get/get.dart';
import 'package:test/controller/home/task_screen_controller.dart';

class TaskScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskScreenController());
  }
}
