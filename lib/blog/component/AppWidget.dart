import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../main.dart';
import '../model/BlogDetailResponse.dart';
import '../model/DefaultPostResponse.dart';
import '../network/RestApi.dart';
import '../screen/SignInScreen.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/AppColor.dart';
import '../screen/ApiErrorScreen.dart';
import '../screen/CommentScreen.dart';
import '../utils/Extensions/decorations.dart';
import 'AddCommentDialogComponent.dart';

class CustomTheme extends StatelessWidget {
  final Widget? child;

  CustomTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appStore.isDarkMode
          ? ThemeData.dark().copyWith(
              backgroundColor: context.scaffoldBackgroundColor,
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
            )
          : ThemeData.light(),
      child: child!,
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

bookMarkComponent(DefaultPostResponse mPost, BuildContext context) {
  return Observer(builder: (context) {
    return Icon(
      bookMarkStore.isItemInBookMark(mPost.iD.validate())
          ? MaterialIcons.bookmark
          : MaterialIcons.bookmark_outline,
      color: bookMarkStore.isItemInBookMark(mPost.iD.validate())
          ? primaryColor
          : context.iconColor,
    ).onTap(() {
      if (userStore.isLoggedIn) {
        bookMarkStore.addtoBookMark(mPost);
      } else
        SignInScreen().launch(context);
    });
  });
}

Future<void> addToBookMark(BlogDetailResponse detailData) async {
  DefaultPostResponse data = DefaultPostResponse();
  data.iD = detailData.iD;
  data.postType = detailData.postType;
  data.fullImage = detailData.fullImage;
  data.image = detailData.image;
  data.postAuthorName = detailData.postAuthorName;
  data.postTitle = detailData.postTitle;
  data.postDate = detailData.postDate;
  data.postContent = detailData.postContent;
  data.humanTimeDiff = detailData.humanTimeDiff;
  data.noOfComments = detailData.noOfComments;

  bookMarkStore.addtoBookMark(data);
}

Future<void> likeDislike(int id, context, {Function? onCall}) async {
  if (userStore.isLoggedIn) {
    Map req = {'post_id': id};
    likeDislikeApi(req).then((res) {
      appStore.isLoading = false;
      res.isLike = !res.isLike!;
      toast(res.message);
      log(res.message);
      onCall!.call();
    }).catchError((error) {
      appStore.isLoading = false;
      toast(error.toString());
    });
  } else {
    SignInScreen().launch(context);
  }
}

Future<void> commentFuc({context, data, id, onCall()?, onRefresh()?}) async {
  if (userStore.isLoggedIn) {
    if (data.noOfComments != "0")
      CommentScreen(data.iD).launch(context);
    else {
      bool res = await showDialog(
          context: context,
          builder: (BuildContext context) => AddCommentDialogComponent(
                id: id,
                onCall: () {
                  onCall!();
                },
              ));
      if (res == true) onRefresh!();
    }
  } else
    SignInScreen().launch(context);
}

apiErrorComponent(data, context) {
  if (data.toString().contains(
      "Sorry, you cannot list resources. Verify your purchase code")) {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ApiErrorScreen()),
      );
    });
  }
}

BoxDecoration glassBoxDecoration() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.white.withAlpha(100),
        blurRadius: 10.0,
        spreadRadius: 0.0,
      ),
    ],
    color: Colors.white.withAlpha(100),
    borderRadius: radius(),
  );
}
