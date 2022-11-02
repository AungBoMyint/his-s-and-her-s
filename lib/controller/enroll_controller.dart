import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzn/data/constant.dart';
import 'package:kzn/data/models/checkbox_model.dart';
import 'package:kzn/data/models/enroll_data.dart';

import '../data/models/course_price.dart';
import 'main_controller.dart';

class EnrollController extends GetxController {
  MainController controller = Get.find();
  RxList<CoursePrice> coursePriceList = <CoursePrice>[].obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  var paymentAccValue = "09 969 5452 15 (KBZ Pay)".obs;
  var bankSs = "".obs;
  var facebookProfileSs = "".obs;
  var isUploading = false.obs;
  var totalPrice = 0.obs;

  @override
  void onInit() async {
    coursePriceList.value = await controller.database.getCoursePriceList();
    super.onInit();
  }

  void changeCheckboxValue(bool value, int index) {
    coursePriceList[index] = coursePriceList[index].copyWith(
      isSelected: value,
    );
    changeTotalPrice();
  }

  void changeTotalPrice() {
    totalPrice.value = 0;
    final allTrueList =
    coursePriceList.where((element) => element.isSelected == true);
    allTrueList.forEach((element) {
      totalPrice.value += element.coursePrice;
    });
  }

  void changePaymentAccValue(String? inputValue) {
    paymentAccValue.value = inputValue!;
  }

  void setBankSs(String val) {
    bankSs.value = val;
  }

  void setFacebookProfileSs(String val) {
    facebookProfileSs.value = val;
  }

  String? nameInputValidator(String? value) {
    if (!(value == null) && value.isEmpty) {
      return "Please fill your name!";
    } else if (value!.length < 3) {
      return "Name must be greater than 3 characters!";
    } else {
      return null;
    }
  }

  RegExp regExp = RegExp(r"[0-9]");
  String? phoneInputValidator(String? value) {
    if (!(value == null) && value.isEmpty) {
      return "Please enter phone number!";
    } else if (value!.length != 11) {
      return "Phone number must be 11 digits!";
    } else {
      return null;
    }
  }

  Future<bool> uploadEnroll() async {
    Completer<bool> _completer = Completer();
    final List<CoursePrice> courseList =
    coursePriceList.where((model) => model.isSelected == true).toList();
    final List<Map<String, dynamic>> courseMapList = courseList
        .map((e) => <String, dynamic>{
      "name": e.courseName,
      "price": e.coursePrice,
    })
        .toList(); //List Map Stirng keys=> courseName and price
    if (formKey.currentState?.validate() == true &&
        paymentAccValue.isNotEmpty &&
        bankSs.isNotEmpty &&
        facebookProfileSs.isNotEmpty &&
        courseMapList.isNotEmpty) {
      isUploading.value = true;
      final enrollData = EnrollData(
        name: nameController.text,
        phoneNumber: phoneController.text,
        courseList: courseMapList,
        paymentAccName: paymentAccValue.value,
        bankSsImage: bankSs.value,
        facebookProfileSsImage: facebookProfileSs.value,
        totalPrice: totalPrice.value,
      );
      await controller.database
          .uploadEnrollData(
        enrollData,
      )
          .then((value) {
        if (value) {
          Get.snackbar("အတန်းအပ်နှံခြင်း", "အောင်မြင်ပါသည်။");
          _completer.complete(true);
        } else {
          Get.snackbar("အတန်းအပ်နှံခြင်း", "မအောင်မြင်ပါ။");
          _completer.complete(false);
        }
        isUploading.value = false;
      });
    }
    return _completer.future;
  }
}