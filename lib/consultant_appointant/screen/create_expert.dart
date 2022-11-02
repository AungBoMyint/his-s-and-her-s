import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/expert_controller.dart';
import '../controller/home_controller.dart';

class CreateExpertPage extends StatefulWidget {
  const CreateExpertPage({Key? key}) : super(key: key);

  @override
  State<CreateExpertPage> createState() => _CreateExpertPageState();
}

class _CreateExpertPageState extends State<CreateExpertPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final ExpertController _expertController = Get.find();
  final ExpertController _expertController2 = Get.find();
  final ExpertController _expertController3 = Get.find();
  final HomeController _home = Get.find();

  @override
  void dispose() {
    _home.setEditExpertId('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Obx(
          () => Text(
            _expertController.id.isNotEmpty ? "Edit Property" : "Create Property",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Form(
          key: _globalKey,
          child: ListView(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            children: [
              //   'photolink': photolink,
              TextFormField(
                controller: _expertController.photolink,
                focusNode: _expertController.photolinkFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.nameFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Photo Link",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _expertController2.photolink2,
                focusNode: _expertController2.photolink2FocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.nameFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Photo Link 2",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _expertController3.photolink3,
                focusNode: _expertController3.photolink3FocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.nameFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Photo Link 3",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // 'name': name,
              TextFormField(
                controller: _expertController.name,
                focusNode: _expertController.nameFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.typeFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Property Name",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // 'type': type,
              TextFormField(
                controller: _expertController.type,
                focusNode: _expertController.typeFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.descriptionFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Type",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // 'description': description,
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _expertController.description,
                focusNode: _expertController.descriptionFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.jobFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // 'job': job,
              TextFormField(
                controller: _expertController.job,
                focusNode: _expertController.jobFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.rateFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Area",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // 'rate': rate,
              TextFormField(
                controller: _expertController.rate,
                focusNode: _expertController.rateFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.ratingFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Price / Month",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // 'rating': rating,
              TextFormField(
                controller: _expertController.rating,
                focusNode: _expertController.ratingFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.jobTitleFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Number of BedRoom",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _expertController2.rating2,
                focusNode: _expertController2.rating2FocusNode,
                onFieldSubmitted: (_) =>
                    _expertController2.jobTitleFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Number of BathRoom",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _expertController.propertyAddress,
                focusNode: _expertController.propertyAddressFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.propertyAddressFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Property Address",
                ),
              ),
              SizedBox(
                height: 20,
              ),




              // 'jobTitle': jobTitle,
              TextFormField(
                controller: _expertController.jobTitle,
                focusNode: _expertController.jobTitleFocusNode,
                onFieldSubmitted: (_) =>
                    _expertController.jobDescriptionFocusNode.requestFocus(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Facilities",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // 'jobDescription': jobDescription,
              TextFormField(
                controller: _expertController.jobDescription,
                focusNode: _expertController.jobDescriptionFocusNode,
                onFieldSubmitted: (_) async {
                  await _expertController.create();
                  _globalKey.currentState?.reset();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Others",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    await _expertController.create();
                    _expertController.photolink.clear();
                    _globalKey.currentState?.reset();
                  },
                  child: Obx(
                    () => _expertController.isLoading.value
                        ? CircularProgressIndicator()
                        : Obx(
                            () => Text(
                              _expertController.id.isNotEmpty
                                  ? "Update"
                                  : "Create",
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
