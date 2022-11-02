import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../service/AuthService.dart';
import '../network/RestApi.dart';
import '../screen/DashboardScreen.dart';
import '../screen/SignUpScreen.dart';
import '../utils/AppColor.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/AppButton.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/Extensions/Colors.dart';
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
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPDialog extends StatefulWidget {
  static String tag = '/OTPDialog';
  final String? verificationId;
  final String? phoneNumber;
  final bool? isCodeSent;
  final PhoneAuthCredential? credential;

  OTPDialog(
      {this.verificationId,
      this.isCodeSent,
      this.phoneNumber,
      this.credential});

  @override
  OTPDialogState createState() => OTPDialogState();
}

class OTPDialogState extends State<OTPDialog> {
  TextEditingController numberController = TextEditingController();
  String? countryCode = '';
  String otpCode = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> submit() async {
    appStore.setLoading(true);
    setState(() {});

    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId!, smsCode: otpCode.validate());

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((result) async {
      Map req = {
        'username': widget.phoneNumber!.replaceAll('+', ''),
        'password': widget.phoneNumber!.replaceAll('+', ''),
      };

      await logInApi(req).then((value) async {
        await setValue(isOtp, true);
        // await setValue(LOGIN_TYPE, LoginTypeOTP);
        DashboardScreen().launch(context, isNewTask: true);
      }).catchError((e) {
        appStore.setLoading(false);
        setState(() {});

        if (e.toString().contains('invalid_username')) {
          finish(context);
          finish(context);
          SignUpScreen(phoneNumber: widget.phoneNumber!.replaceAll('+', ''))
              .launch(context);
        } else {
          toast(e.toString());
        }
      });
    }).catchError((e) {
      log(e);
      toast(e.toString());

      appStore.setLoading(false);
      setState(() {});
    });
  }

  Future<void> sendOTP() async {
    if (numberController.text.trim().isEmpty) {
      return toast(errorThisFieldRequired);
    }
    appStore.setLoading(true);
    setState(() {});

    String number = '+$countryCode${numberController.text.trim()}';
    if (!number.startsWith('+')) {
      number = '+$countryCode${numberController.text.trim()}';
    }

    await loginWithOTP(context, number).then((value) {
      //
    }).catchError((e) {
      toast(e.toString());
    });

    appStore.setLoading(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: radius(defaultRadius)),
      child: Container(
        width: context.width(),
        child: !widget.isCodeSent.validate()
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sign In Using Your \nMobile Number ",
                              style: boldTextStyle(size: 18))
                          .paddingOnly(left: 16, top: 16),
                      IconButton(
                          onPressed: () {
                            finish(context);
                          },
                          icon: Icon(Icons.close_sharp))
                    ],
                  ),
                  30.height,
                  Container(
                    height: 100,
                    child: Row(
                      children: [
                        CountryCodePicker(
                          initialSelection: 'IN',
                          showCountryOnly: false,
                          showFlag: false,
                          boxDecoration: BoxDecoration(
                              borderRadius: radius(defaultRadius),
                              color: context.scaffoldBackgroundColor),
                          showFlagDialog: true,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          textStyle: primaryTextStyle(),
                          onInit: (c) {
                            countryCode = c!.dialCode;
                          },
                          onChanged: (c) {
                            countryCode = c.dialCode;
                          },
                        ),
                        AppTextField(
                          controller: numberController,
                          textFieldType: TextFieldType.PHONE,
                          decoration:
                              inputDecoration(context, label: "Mobile Number"),
                          autoFocus: true,
                          onFieldSubmitted: (s) {
                            sendOTP();
                          },
                        ).expand(),
                      ],
                    ),
                  ).paddingOnly(left: 16, right: 16),
                  16.height,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AppButtonWidget(
                        onTap: () {
                          sendOTP();
                        },
                        text: "Send OTP",
                        color: appStore.isDarkMode
                            ? scaffoldDarkColor
                            : primaryColor,
                        textStyle: boldTextStyle(color: Colors.white),
                        width: context.width(),
                      ),
                      Positioned(
                        //right: 16,
                        child: Loader().visible(appStore.isLoading),
                      ),
                    ],
                  ).paddingOnly(left: 16, right: 16, bottom: 16)
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter receive OTP", style: boldTextStyle()),
                  30.height,
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 35,
                    style: primaryTextStyle(),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.box,
                    onChanged: (s) {
                      otpCode = s;
                    },
                    onCompleted: (pin) {
                      otpCode = pin;
                      submit();
                    },
                  ),
                  30.height,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AppButtonWidget(
                        onTap: () {
                          submit();
                        },
                        text: "Confirm",
                        color: appStore.isDarkMode
                            ? scaffoldDarkColor
                            : primaryColor,
                        textStyle: boldTextStyle(color: Colors.white),
                        width: context.width(),
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: radius(defaultRadius)),
                      ),
                      Positioned(
                        //right: 16,
                        child: Loader().visible(appStore.isLoading),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
