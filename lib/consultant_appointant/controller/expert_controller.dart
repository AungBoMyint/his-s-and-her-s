import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/constant.dart';
import '../model/expert.dart';
import 'home_controller.dart';
import '../service/database.dart';

class ExpertController extends GetxController {
  final HomeController _home = Get.find<HomeController>();

  final RxString id = ''.obs;

  final TextEditingController photolink;
  final TextEditingController photolink2;
  final TextEditingController photolink3;
  final TextEditingController name;
  final TextEditingController type;
  final TextEditingController description;
  final TextEditingController job;
  final TextEditingController rate;
  final TextEditingController rating;
  final TextEditingController rating2;
  final TextEditingController jobTitle;
  final TextEditingController jobDescription;
  final TextEditingController propertyAddress;

  final FocusNode photolinkFocusNode;
  final FocusNode photolink2FocusNode;
  final FocusNode photolink3FocusNode;
  final FocusNode nameFocusNode;
  final FocusNode typeFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode jobFocusNode;
  final FocusNode rateFocusNode;
  final FocusNode ratingFocusNode;
  final FocusNode rating2FocusNode;
  final FocusNode jobTitleFocusNode;
  final FocusNode jobDescriptionFocusNode;
  final FocusNode propertyAddressFocusNode;

  ExpertController(
    this.photolink,
    this.photolink2,
    this.photolink3,
    this.name,
    this.type,
    this.description,
    this.job,
    this.rate,
    this.rating,
    this.rating2,
    this.jobTitle,
    this.jobDescription,
    this.propertyAddress,


    this.photolinkFocusNode,
    this.photolink2FocusNode,
    this.photolink3FocusNode,
    this.nameFocusNode,
    this.typeFocusNode,
    this.descriptionFocusNode,
    this.jobFocusNode,
    this.rateFocusNode,
    this.ratingFocusNode,
    this.rating2FocusNode,
    this.jobTitleFocusNode,
    this.jobDescriptionFocusNode,
    this.propertyAddressFocusNode,
  );

  @override
  void onInit() {
    super.onInit();
    if (_home.expertId.isNotEmpty) {
      final ExpertModel _expert = _home.getExpert(_home.expertId.value);
      id.value = _expert.id!;
      photolink.text = _expert.photolink;
      photolink2.text = _expert.photolink2;
      photolink3.text = _expert.photolink3;
      name.text = _expert.name;
      type.text = _expert.type;
      description.text = _expert.description;
      job.text = _expert.job;
      rate.text = _expert.rate;
      rating.text = _expert.rating;
      rating2.text = _expert.rating2;
      jobTitle.text = _expert.jobTitle;
      jobDescription.text = _expert.jobDescription;
      propertyAddress.text = _expert.propertyAddress;

    }
  }

  final Database _database = Database();
  final RxBool isLoading = false.obs;

  Future<void> create() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final Map<String, dynamic> data = ExpertModel(
        photolink: photolink.text,
        photolink2: photolink2.text,
        photolink3: photolink3.text,
        name: name.text,
        type: type.text,
        description: description.text,
        job: job.text,
        rate: rate.text,
        rating: rating.text,
        rating2: rating2.text,
        jobTitle: jobTitle.text,
        jobDescription: jobDescription.text,
        propertyAddress: propertyAddress.text,
      ).toJson();
      if (id.isNotEmpty) {
        await _database.update(
          expertCollection,
          path: id.value,
          data: data,
        );
        Get.back();
        Get.snackbar('Success', 'Update!');
      } else {
        await _database.write(
          expertCollection,
          data: data,
        );
        Get.snackbar('Success', 'Created!');
      }
    } catch (e) {
      print("expertcontroller error $e");
      Get.snackbar('Error', '$e');
    }

    isLoading.value = false;
  }
}
