import 'package:flutter/material.dart';
import '../language/language.dart';
import '../network/RestApi.dart';
import '../utils/AppColor.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../component/AppWidget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      btnController.start();
      Map req = {'email': emailCon.text.trim()};
      await forgotPassword(req).then((value) {
        btnController.success();
        toast(value.message);
        finish(context);
      }).catchError((error) {
        toast(error.toString());
        btnController.error();
        apiErrorComponent(error, context);
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(LanguageEn.btnResetPassword,
          textColor: Colors.white, showBack: true),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LanguageEn.msgForgotPass, style: primaryTextStyle()),
              16.height,
              AppTextField(
                controller: emailCon,
                textFieldType: TextFieldType.EMAIL,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    inputDecoration(context, label: LanguageEn.lblEmail),
                errorInvalidEmail: LanguageEn.msgInvalidEnterEmail,
                errorThisFieldRequired: errorThisFieldRequired,
              ),
              24.height,
              RoundedLoadingButton(
                successIcon: Icons.done,
                failedIcon: Icons.close,
                borderRadius: defaultRadius,
                child: Text(LanguageEn.btnResetPassword,
                    style: boldTextStyle(color: Colors.white)),
                controller: btnController,
                animateOnTap: false,
                resetDuration: 3.seconds,
                resetAfterDuration: true,
                width: context.width(),
                color: primaryColor,
                onPressed: () {
                  hideKeyboard(context);
                  resetPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
