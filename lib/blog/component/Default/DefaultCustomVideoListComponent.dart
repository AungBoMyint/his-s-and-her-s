import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../main.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/SignInScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';

class DefaultCustomVideoListComponent extends StatefulWidget {
  static String tag = '/DefaultCustomVideoListComponent';
  final DefaultPostResponse mPost;
  final Function? onCall;

  DefaultCustomVideoListComponent(this.mPost, {this.onCall});

  @override
  DefaultCustomVideoListComponentState createState() =>
      DefaultCustomVideoListComponentState();
}

class DefaultCustomVideoListComponentState
    extends State<DefaultCustomVideoListComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width();
    double mHeight = 180;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            commonCacheImageWidget(widget.mPost.image.validate(),
                    width: width, height: mHeight, fit: BoxFit.cover)
                .cornerRadiusWithClipRRect(16),
            Container(
              width: width,
              height: mHeight,
              decoration: boxDecorationWithRoundedCornersWidget(
                borderRadius: radius(16),
                backgroundColor: Colors.black45,
              ),
            ),
            Icon(Icons.play_circle_outline, color: Colors.white, size: 50)
                .center(),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: boxDecorationWithRoundedCornersWidget(
                    backgroundColor: context.cardColor,
                    borderRadius: radiusWidget(10)),
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(8),
                child: Icon(
                  bookMarkStore.isItemInBookMark(widget.mPost.iD.validate())
                      ? Ionicons.bookmark
                      : Ionicons.bookmark_outline,
                  color:
                      bookMarkStore.isItemInBookMark(widget.mPost.iD.validate())
                          ? primaryColor
                          : context.iconColor,
                ).onTap(() {
                  if (userStore.isLoggedIn) {
                    bookMarkStore.addtoBookMark(widget.mPost);
                    setState(() {});
                  } else
                    SignInScreen().launch(context);
                }),
              ),
            ),
          ],
        ),
        Text(parseHtmlString(widget.mPost.postTitle.validate()),
                maxLines: 2, style: boldTextStyle(color: Colors.white))
            .paddingAll(16),
      ],
    ).paddingBottom(10);
  }
}
