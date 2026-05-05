import 'package:get/instance_manager.dart';
import 'package:test/controller/home/study_companion_controller.dart';

class StudyCompanionScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StudyCompanionController());
  }
}
