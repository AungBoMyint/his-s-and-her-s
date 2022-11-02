import 'package:flutter/material.dart';
import '../network/RestApi.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddCommentDialogComponent extends StatefulWidget {
  final int? id;
  final String? text;
  final Function? onCall;

  AddCommentDialogComponent({this.id, this.text, this.onCall});

  @override
  _AddCommentDialogComponentState createState() =>
      _AddCommentDialogComponentState();
}

class _AddCommentDialogComponentState extends State<AddCommentDialogComponent> {
  TextEditingController addCommentCont = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> submit() async {
    if (addCommentCont.text.isEmpty) return toast("Please Write Comment...");

    var request = {
      'comment_content': addCommentCont.text,
      'comment_post_ID': widget.id,
    };
    btnController.start();
    await addComment(request).then((value) {
      toast(value.message);
      btnController.success();
      finish(context, true);
      widget.onCall!.call();
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
      btnController.error();
    }).whenComplete(() => btnController.stop());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: radius(defaultRadius)),
      elevation: 0.0,
      backgroundColor: context.cardColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: boxDecorationWithRoundedCornersWidget(
            borderRadius: radius(10), backgroundColor: context.cardColor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add Comments", style: boldTextStyle(size: 16)),
                  IconButton(
                    onPressed: () {
                      finish(context, true);
                    },
                    icon: Icon(Icons.close, color: context.iconColor, size: 18),
                  )
                ],
              ).paddingOnly(left: 16),
              16.height,
              AppTextField(
                controller: addCommentCont,
                autoFocus: true,
                textFieldType: TextFieldType.OTHER,
                keyboardType: TextInputType.text,
                decoration: inputDecoration(context, label: "Add Comments"),
              ).paddingOnly(left: 16, right: 16),
              20.height,
              RoundedLoadingButton(
                successIcon: Icons.done,
                failedIcon: Icons.close,
                borderRadius: defaultRadius,
                child:
                    Text("Submit", style: boldTextStyle(color: Colors.white)),
                controller: btnController,
                animateOnTap: false,
                resetAfterDuration: true,
                width: context.width(),
                color: context.primaryColor,
                onPressed: () {
                  hideKeyboard(context);
                  submit();
                },
              ).paddingAll(16),
            ],
          ),
        ),
      ),
    );
  }
}
