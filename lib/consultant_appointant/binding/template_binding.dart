import 'package:get/instance_manager.dart';
import '../controller/home_controller.dart';
import '../controller/template_controller.dart';

class TemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      TemplateController(),
    );
    Get.put(
      HomeController(),
    );
  }
}
