import 'package:flutter/material.dart';
import 'package:kzn/blog/language/language.dart';
import '../../main.dart';
import '../network/RestApi.dart';
import '../utils/AppColor.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/string_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../component/AppWidget.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  TextEditingController oldPassCont = TextEditingController();
  TextEditingController newPassCont = TextEditingController();
  TextEditingController confNewPassCont = TextEditingController();

  FocusNode newPassFocus = FocusNode();
  FocusNode confPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Future<void> forgotPass() async {
    hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      Map req = {
        'old_password': oldPassCont.text.trim(),
        'new_password': newPassCont.text.trim(),
      };
      btnController.start();
      await changePassword(req).then((value) {
        setValue(userPassword, newPassCont.text);
        toast(value.message.validate());
        btnController.success();
        finish(context);
      }).catchError((error) {
        log(error);
        btnController.error();
        apiErrorComponent(error, context);
      }).whenComplete(() => btnController.stop());
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(LanguageEn.lblChangePassword,
          textColor: Colors.white, showBack: true),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTextField(
              controller: oldPassCont,
              textFieldType: TextFieldType.PASSWORD,
              decoration:
                  inputDecoration(context, label: LanguageEn.lblOldPassword),
              nextFocus: newPassFocus,
              textStyle: primaryTextStyle(),
              autoFillHints: [AutofillHints.password],
              validator: (String? s) {
                if (s!.isEmpty) return errorThisFieldRequired;
                if (s != getStringAsync(userPassword))
                  return LanguageEn.msgPasswordIncorrect;

                return null;
              },
            ),
            16.height,
            AppTextField(
              controller: newPassCont,
              textFieldType: TextFieldType.PASSWORD,
              decoration:
                  inputDecoration(context, label: LanguageEn.lblNewPassword),
              focus: newPassFocus,
              nextFocus: confPassFocus,
              textStyle: primaryTextStyle(),
              autoFillHints: [AutofillHints.newPassword],
            ),
            16.height,
            AppTextField(
              controller: confNewPassCont,
              textFieldType: TextFieldType.PASSWORD,
              decoration: inputDecoration(context,
                  label: LanguageEn.lblConfirmPassword),
              focus: confPassFocus,
              validator: (String? value) {
                if (value!.isEmpty) return errorThisFieldRequired;
                if (value.length < passwordLengthGlobal)
                  return LanguageEn.passLengthMsg;
                if (value.trim() != newPassCont.text.trim())
                  return LanguageEn.oldPassNotMatchMsg;
                if (value.trim() == oldPassCont.text.trim())
                  return LanguageEn.passNotMatch;

                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (s) {
                forgotPass();
              },
              textStyle: primaryTextStyle(),
              autoFillHints: [AutofillHints.newPassword],
            ),
            24.height,
            RoundedLoadingButton(
              successIcon: Icons.done,
              failedIcon: Icons.close,
              borderRadius: defaultRadius,
              child: Text(LanguageEn.btnUpdatePassword,
                  style: boldTextStyle(color: Colors.white)),
              controller: btnController,
              animateOnTap: false,
              resetAfterDuration: true,
              width: context.width(),
              color: primaryColor,
              onPressed: () {
                forgotPass();
              },
            ),
            16.height,
          ],
        ).paddingAll(16),
      ),
    );
  }
}
