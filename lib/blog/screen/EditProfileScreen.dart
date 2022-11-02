import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzn/blog/language/language.dart';
import '../../main.dart';
import '../network/RestApi.dart';
import '../utils/AppColor.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstant.dart';
import '../utils/AppImages.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Loader.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/string_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../component/AppWidget.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  File? image;
  String? profileImageUrl;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    appStore.setLoading(true);
    await viewProfile().then((data) async {
      await userStore.setFirstName(data.firstName.validate());
      await userStore.setLastName(data.lastName.validate());

      if (data.mbloggerProfileImage != null) {
        profileImageUrl = userStore.profileImage;
      }
      appStore.setLoading(false);
    }).catchError((e) async {
      log(e);
      apiErrorComponent(e, context);
    });
    firstNameController.text = userStore.fName;
    lastNameController.text = userStore.lName;
    setState(() {});
  }

  Future save() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      btnController.start();
      hideKeyboard(context);
      bool? res = await updateProfile(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          file: image != null ? File(image!.path) : null);
      if (res == true) {
        finish(context, true);
        btnController.success();
      } else {
        btnController.error();
      }
    }
  }

  Future getImg() async {
    image = File((await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 100))!
        .path);
    setState(() {});
    log(image!.path.toString());
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget profileImage() {
    if (image != null) {
      return Image.file(File(image!.path),
              height: 120, width: 120, fit: BoxFit.cover)
          .cornerRadiusWithClipRRect(85);
    } else {
      if (profileImageUrl.validate().isNotEmpty)
        return Image.network(profileImageUrl.validate(),
                height: 120, width: 120, fit: BoxFit.cover)
            .cornerRadiusWithClipRRect(85);
      else
        return Image.asset(ic_profile,
                height: 120, width: 120, fit: BoxFit.cover)
            .cornerRadiusWithClipRRect(85);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(LanguageEn.lblEditProfile,
          showBack: true, textColor: Colors.white),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                16.height,
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: boxDecorationWithRoundedCornersWidget(
                          boxShape: BoxShape.circle,
                          border: Border.all(width: 4, color: primaryColor)),
                      child: profileImage(),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10, bottom: 6),
                      padding: EdgeInsets.all(6),
                      decoration: boxDecorationWithRoundedCornersWidget(
                          boxShape: BoxShape.circle,
                          backgroundColor: context.cardColor,
                          border: Border.all(width: 0.5, color: primaryColor)),
                      child: Icon(Icons.image, size: 18),
                    ).onTap(() {
                      getImg();
                    }).visible(!getBoolAsync(isSocial))
                  ],
                ),
                40.height,
                AppTextField(
                  controller: firstNameController,
                  nextFocus: lastNameFocus,
                  autoFocus: true,
                  readOnly: getBoolAsync(isSocial) ? true : false,
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  decoration:
                      inputDecoration(context, label: LanguageEn.lblFirstName),
                ),
                12.height,
                AppTextField(
                  controller: lastNameController,
                  focus: lastNameFocus,
                  readOnly: getBoolAsync(isSocial) ? true : false,
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value.validate().isEmpty) return errorThisFieldRequired;
                    return null;
                  },
                  decoration:
                      inputDecoration(context, label: LanguageEn.lblLastName),
                  onFieldSubmitted: (c) {
                    save();
                  },
                ),
                24.height,
                RoundedLoadingButton(
                  successIcon: Icons.done,
                  failedIcon: Icons.close,
                  borderRadius: defaultRadius,
                  child: Text(LanguageEn.lblUpdate,
                      style: boldTextStyle(color: Colors.white)),
                  controller: btnController,
                  animateOnTap: false,
                  resetAfterDuration: true,
                  width: context.width(),
                  color: primaryColor,
                  onPressed: () {
                    save();
                  },
                ),
              ],
            ).paddingAll(16),
          ).visible(!appStore.isLoading),
          Loader().center().visible(appStore.isLoading)
        ],
      ),
    );
  }
}
