import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class TemplateController extends GetxController {
  final RxInt index = 0.obs;

  void onChange(int i) {
    index.value = i;
  }
}
