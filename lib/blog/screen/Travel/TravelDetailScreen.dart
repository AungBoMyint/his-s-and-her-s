import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../component/AppWidget.dart';
import '../../component/Travel/TravelFeaturedComponent.dart';
import 'package:kzn/main.dart';
import '../../language/language.dart';
import '../../model/BlogDetailResponse.dart';
import '../../network/RestApi.dart';
import '../../screen/SignInScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/Commons.dart';
import '../../utils/Extensions/Constants.dart';
import '../../utils/Extensions/HorizontalList.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/decorations.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import 'package:share_plus/share_plus.dart';

import '../../component/AppWidget.dart';
import '../../component/HtmlWidget.dart';
import '../../component/ReadAloudDialog.dart';

class TravelDetailScreen extends StatefulWidget {
  static String tag = '/TravelDetailScreen';
  final int? postId;

  TravelDetailScreen({this.postId});

  @override
  TravelDetailScreenState createState() => TravelDetailScreenState();
}

class TravelDetailScreenState extends State<TravelDetailScreen> {
  bool? isLike;
  Future<BlogDetailResponse>? mGetDetail;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
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
            return Column(
              children: [
                //AppBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        finish(context);
                      },
                      child: Container(
                        decoration: boxDecorationWithShadowWidget(
                            backgroundColor: context.cardColor,
                            blurRadius: 10,
                            boxShape: BoxShape.circle),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (userStore.isLoggedIn) {
                              addToBookMark(snap.data!);
                              setState(() {});
                            } else {
                              SignInScreen().launch(context);
                            }
                          },
                          child: Container(
                            decoration: boxDecorationWithShadowWidget(
                                backgroundColor: context.cardColor,
                                blurRadius: 10,
                                boxShape: BoxShape.circle),
                            padding: EdgeInsets.all(10),
                            child: Observer(builder: (context) {
                              return bookMarkStore.isItemInBookMark(
                                      widget.postId.validate())
                                  ? Icon(MaterialIcons.bookmark_border,
                                      color: primaryColor, size: 24)
                                  : Icon(Ionicons.bookmark_outline,
                                      color: context.iconColor, size: 24);
                            }),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Share.share(
                                'Share ${snap.data!.postTitle} app\n$playStoreBaseURL${snap.data!.shareUrl}');
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            decoration: boxDecorationWithShadowWidget(
                                backgroundColor: context.cardColor,
                                blurRadius: 10,
                                boxShape: BoxShape.circle),
                            padding: EdgeInsets.all(10),
                            child: Icon(Ionicons.share_social_outline,
                                color: context.iconColor),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 16),
                            padding: EdgeInsets.all(10),
                            decoration: boxDecorationWithShadowWidget(
                                backgroundColor: context.cardColor,
                                blurRadius: 10,
                                boxShape: BoxShape.circle),
                            child: ReadAloudDialog(
                              parseHtmlString(snap.data!.postContent),
                              isShape: true,
                              color: context.iconColor,
                            ).fit()),
                      ],
                    )
                  ],
                ).paddingOnly(
                    right: 16,
                    left: 16,
                    bottom: 16,
                    top: context.statusBarHeight + 8),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Load image
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          commonCacheImageWidget(snap.data!.image.validate(),
                                  fit: BoxFit.cover,
                                  height: context.height() * 0.41,
                                  width: context.width())
                              .cornerRadiusWithClipRRect(30)
                              .paddingOnly(left: 16, right: 16, bottom: 16),
                          Container(
                            alignment: Alignment.bottomRight,
                            width: context.width(),
                            margin: EdgeInsets.all(24),
                            decoration: boxDecorationDefaultWidget(
                                borderRadius: radius(30), color: primaryColor),
                            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(MaterialCommunityIcons.timer_outline,
                                            size: 14, color: whiteColor)
                                        .visible(snap.data!.postDate
                                            .validate()
                                            .isNotEmpty),
                                    4.width.visible(snap.data!.postDate
                                        .validate()
                                        .isNotEmpty),
                                    if (snap.data!.postDate
                                        .validate()
                                        .isNotEmpty)
                                      Text(snap.data!.humanTimeDiff.validate(),
                                          style: secondaryTextStyle(
                                              color: whiteColor)),
                                  ],
                                ).expand(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(FontAwesome.commenting_o,
                                              size: 16, color: whiteColor),
                                          6.width,
                                          Text(
                                              snap.data!.noOfComments != "0"
                                                  ? snap.data!.noOfComments
                                                      .toString()
                                                  : "0",
                                              style: secondaryTextStyle(
                                                  color: whiteColor)),
                                        ],
                                      ).paddingAll(4),
                                    ),
                                    10.width,
                                    GestureDetector(
                                      onTap: () async {
                                        likeDislike(
                                            widget.postId.validate(), context,
                                            onCall: () {
                                          setState(() {
                                            mGetDetail =
                                                getBlogDetail(widget.postId!);
                                          });
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                              snap.data!.isLike != true
                                                  ? Icons.favorite_border
                                                  : Icons.favorite,
                                              size: 16,
                                              color: whiteColor),
                                          6.width,
                                          Text(snap.data!.likeCount.toString(),
                                              style: secondaryTextStyle(
                                                  color: whiteColor)),
                                        ],
                                      ).paddingAll(4),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      //category
                      snap.data!.category != null &&
                              snap.data!.category!.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                              decoration: boxDecorationWithShadowWidget(
                                  border: Border.all(width: 0.1),
                                  borderRadius: radius(30),
                                  backgroundColor: appStore.isDarkMode
                                      ? context.cardColor
                                      : primaryColor),
                              child: Text(
                                  snap.data!.category!.first.name.validate(),
                                  style: boldTextStyle(
                                      color: Colors.white, size: 14)),
                            )
                          : SizedBox(),

                      // Tag
                      if (snap.data!.tags != null &&
                          snap.data!.tags!.isNotEmpty)
                        Wrap(
                          runSpacing: 4,
                          children: List.generate(
                            snap.data!.tags!.length,
                            (index) {
                              Tags data = snap.data!.tags![index];
                              return GestureDetector(
                                onTap: (() {
                                  setState(() {});
                                }),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: boxDecorationDefaultWidget(
                                      borderRadius: radius(30),
                                      color: primaryColor),
                                  child: Text(data.name.validate(),
                                      style: secondaryTextStyle(
                                          color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              );
                            },
                          ),
                        ).paddingOnly(left: 16, top: 8).visible(
                            snap.data!.tags != null &&
                                snap.data!.tags!.isNotEmpty),

                      // Title
                      Text(parseHtmlString(snap.data!.postTitle.validate()),
                              style: boldTextStyle(size: 20))
                          .paddingSymmetric(horizontal: 16, vertical: 8),

                      //Description
                      HtmlWidget(postContent: snap.data!.postContent.validate())
                          .paddingOnly(left: 16, right: 16),

                      //related post
                      if (snap.data!.relatedNews != null &&
                          snap.data!.relatedNews!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            Text(LanguageEn.lblRelatablePost,
                                    style: boldTextStyle(size: 18))
                                .paddingSymmetric(horizontal: 16),
                            HorizontalList(
                                itemCount: snap.data!.relatedNews!.length,
                                padding: EdgeInsets.only(
                                    bottom: 20, right: 16, left: 16, top: 8),
                                itemBuilder: (_, index) {
                                  return TravelFeaturedComponent(
                                    snap.data!.relatedNews![index],
                                    isSlider: true,
                                  );
                                }),
                          ],
                        ),
                    ],
                  ),
                ).expand(),
              ],
            );
          }
          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}
