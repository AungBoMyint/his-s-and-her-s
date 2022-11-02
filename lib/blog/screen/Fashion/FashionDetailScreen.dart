import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/AppWidget.dart';
import '../../component/Fashion/FashionFeatureComponent.dart';
import '../../component/HtmlWidget.dart';
import '../../model/BlogDetailResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Loader.dart';
import '../../utils/Extensions/text_styles.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import 'package:share_plus/share_plus.dart';
import '../../component/ReadAloudDialog.dart';
import 'package:kzn/main.dart';
import '../../utils/Extensions/Commons.dart';
import '../SignInScreen.dart';
import '../ViewAllScreen.dart';

class FashionDetailScreen extends StatefulWidget {
  final int? postId;

  FashionDetailScreen({this.postId});

  @override
  _FashionDetailScreenState createState() => _FashionDetailScreenState();
}

class _FashionDetailScreenState extends State<FashionDetailScreen> {
  Future<BlogDetailResponse>? mGetDetail;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
    loadInterstitialAds();
    mGetDetail = getBlogDetail(widget.postId!);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    showInterstitialAds();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<BlogDetailResponse>(
        future: mGetDetail,
        builder: (context, snap) {
          if (snap.hasData) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        BackButton(),
                        SizedBox().expand(),
                        IconButton(
                          onPressed: () {
                            if (userStore.isLoggedIn) {
                              addToBookMark(snap.data!);
                              setState(() {});
                            } else {
                              SignInScreen().launch(context);
                            }
                          },
                          icon: Observer(builder: (context) {
                            return bookMarkStore
                                    .isItemInBookMark(widget.postId.validate())
                                ? Icon(Ionicons.bookmark,
                                    color: appStore.isDarkMode
                                        ? Colors.white
                                        : primaryColor)
                                : Icon(Ionicons.bookmark_outline,
                                    color: context.iconColor);
                          }),
                        ),
                        IconButton(
                          onPressed: () {
                            Share.share(
                                'Share ${snap.data!.postTitle} app\n$playStoreBaseURL${snap.data!.shareUrl}');
                          },
                          icon: Icon(Ionicons.share_social_outline,
                              color: context.iconColor),
                        ),
                        ReadAloudDialog(parseHtmlString(snap.data!.postContent))
                            .fit(),
                      ],
                    ).paddingTop(context.statusBarHeight + 4),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          snap.data!.category != null &&
                                  snap.data!.category!.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  decoration: boxDecorationWithShadowWidget(
                                      border: Border.all(width: 0.1),
                                      borderRadius: radius(6),
                                      backgroundColor: primaryColor),
                                  child: Text(
                                      snap.data!.category!.first.name
                                          .validate(),
                                      style: boldTextStyle(
                                          color: Colors.white, size: 14)),
                                )
                              : SizedBox(),
                          Stack(
                            children: [
                              Container(
                                height: 280,
                                width: context.width(),
                                decoration: boxDecorationWithShadowWidget(
                                    backgroundColor: context.cardColor,
                                    blurRadius: 5),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 24, top: 24, bottom: 16),
                                height: 256,
                                width: context.width(),
                                decoration: boxDecorationWithShadowWidget(
                                    backgroundColor: bgColor, blurRadius: 5),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      commonCacheImageWidget(
                                          snap.data!.image.validate(),
                                          fit: BoxFit.cover,
                                          height: 250,
                                          width: context.width() * 0.55),
                                      8.width,
                                      Container(
                                        width: context.width() * 0.4,
                                        child: Text(
                                            parseHtmlString(snap.data!.postTitle
                                                .validate()),
                                            style: GoogleFonts.lora(
                                                fontSize: 24,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                            '- ' +
                                                snap.data!.postAuthorName
                                                    .validate(),
                                            style: boldTextStyle(
                                                color: Colors.white))
                                        .onTap(() {
                                      ViewAllScreen(
                                              name: snap.data!.postAuthorName
                                                  .validate(),
                                              authId: snap.data!.postAuthorId,
                                              text: snap.data!.postAuthorName)
                                          .launch(context);
                                    }),
                                  ).paddingOnly(right: 8),
                                ],
                              )
                            ],
                          ),
                          snap.data!.postContent.validate().isNotEmpty
                              ? HtmlWidget(
                                      postContent:
                                          snap.data!.postContent.validate())
                                  .paddingSymmetric(horizontal: 10)
                              : Text("No Post Content",
                                      style: primaryTextStyle())
                                  .paddingSymmetric(horizontal: 16),
                          16.height,
                          if (snap.data!.relatedNews != null &&
                              snap.data!.relatedNews!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Relatable Post",
                                        style: boldTextStyle(size: 18))
                                    .paddingSymmetric(horizontal: 16),
                                8.height,
                                HorizontalList(
                                    itemCount: snap.data!.relatedNews!.length,
                                    padding: EdgeInsets.only(
                                        bottom: 20, right: 16, left: 16),
                                    itemBuilder: (_, index) {
                                      return FashionFeatureComponent(
                                          snap.data!.relatedNews![index]);
                                    }),
                              ],
                            ),
                        ],
                      ),
                    ).expand(),
                  ],
                ).paddingBottom(40),
                Container(
                  decoration: boxDecorationWithShadowWidget(
                      backgroundColor: context.cardColor),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () async {
                            commentFuc(
                                context: context,
                                data: snap.data!,
                                id: widget.postId,
                                onCall: () {
                                  init();
                                  setState(() {});
                                },
                                onRefresh: () {
                                  setState(() {});
                                });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(FontAwesome.commenting_o,
                                  size: 16, color: textSecondaryColor),
                              4.width,
                              Text(
                                  snap.data!.noOfComments != "0"
                                      ? snap.data!.noOfCommentsText.toString()
                                      : "Add Comments",
                                  style: secondaryTextStyle()),
                            ],
                          ),
                        ),
                        VerticalDivider(thickness: 1),
                        TextButton(
                          onPressed: () {
                            likeDislike(widget.postId.validate(), context,
                                onCall: () {
                              setState(() {
                                mGetDetail = getBlogDetail(widget.postId!);
                              });
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                  snap.data!.isLike != true
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: snap.data!.isLike != true
                                      ? textSecondaryColor
                                      : Colors.red),
                              4.width,
                              Text(
                                  snap.data!.likeCount.toString() +
                                      " " +
                                      "Likes",
                                  style: secondaryTextStyle()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          if (snap.hasError) {
            apiErrorComponent(snap.error, context);
          }
          return snapWidgetHelper(snap, loadingWidget: Loader());
        },
      ),
    );
  }
}
