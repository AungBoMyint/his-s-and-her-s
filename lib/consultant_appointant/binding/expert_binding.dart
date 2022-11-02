import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import '../controller/expert_controller.dart';


class ExpertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ExpertController(
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
        FocusNode(),
      ),
    );
  }
}
