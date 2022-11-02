import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../main.dart';
import '../../component/AppWidget.dart';
import '../../component/HtmlWidget.dart';
import '../../model/BlogDetailResponse.dart';
import '../../network/RestApi.dart';
import '../../screen/ViewAllScreen.dart';
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
import '../../component/ReadAloudDialog.dart';
import '../SignInScreen.dart';
import '../../component/Default/DefaultFeaturedComponent.dart';

class DefaultDetailScreen extends StatefulWidget {
  static String tag = '/DefaultDetailScreen';
  final int? postId;

  DefaultDetailScreen({this.postId});

  @override
  DefaultDetailScreenState createState() => DefaultDetailScreenState();
}

class DefaultDetailScreenState extends State<DefaultDetailScreen> {
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
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        BackButton(),
                        SizedBox().expand(),
                        if (!snap.data!.shareUrl.isEmptyOrNull)
                          IconButton(
                            onPressed: () {
                              Share.share(
                                  'Share ${snap.data!.postTitle} app\n$playStoreBaseURL${snap.data!.shareUrl}');
                            },
                            icon: Icon(AntDesign.sharealt,
                                color: context.iconColor),
                          ),
                        ReadAloudDialog(parseHtmlString(snap.data!.postContent))
                            .fit()
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
                                      backgroundColor: appStore.isDarkMode
                                          ? context.cardColor
                                          : primaryColor),
                                  child: Text(
                                      snap.data!.category!.first.name
                                          .validate(),
                                      style: boldTextStyle(
                                          color: Colors.white, size: 14)),
                                )
                              : SizedBox(),
                          commonCacheImageWidget(snap.data!.image.validate(),
                                  fit: BoxFit.cover,
                                  height: context.height() * 0.25,
                                  width: context.width())
                              .cornerRadiusWithClipRRect(defaultRadius)
                              .paddingSymmetric(horizontal: 16, vertical: 6),
                          10.height,
                          Row(
                            children: [
                              Icon(MaterialCommunityIcons.timer_outline,
                                      size: 16, color: textSecondaryColor)
                                  .visible(snap.data!.readableDate
                                      .validate()
                                      .isNotEmpty),
                              4.width.visible(snap.data!.readableDate
                                  .validate()
                                  .isNotEmpty),
                              if (snap.data!.readableDate.validate().isNotEmpty)
                                Text(snap.data!.readableDate.validate(),
                                        style: secondaryTextStyle())
                                    .expand(),
                            ],
                          ).paddingSymmetric(horizontal: 16),
                          8.height,

                          if (snap.data!.tags != null &&
                              snap.data!.tags!.isNotEmpty)
                            HorizontalList(
                                itemCount: snap.data!.tags!.length,
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                itemBuilder: (_, i) {
                                  Tags data = snap.data!.tags![i];
                                  return Container(
                                    padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                                    decoration: boxDecorationDefaultWidget(
                                      borderRadius: radius(6),
                                      border: Border.all(
                                          width: 0.2,
                                          color: textPrimaryColorGlobal),
                                    ),
                                    child: Text(data.name.validate(),
                                            style: secondaryTextStyle(
                                                color: textPrimaryColorGlobal))
                                        .onTap(() {
                                      ViewAllScreen(
                                              name: 'by_tag',
                                              text: data.name.splitAfter("#"),
                                              tagId: data.termId)
                                          .launch(context);
                                    }),
                                  );
                                }),

                          Text(parseHtmlString(snap.data!.postTitle.validate()),
                                  style: boldTextStyle(size: 20))
                              .paddingSymmetric(horizontal: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () {
                                  ViewAllScreen(
                                          name: snap.data!.postAuthorName
                                              .validate(),
                                          authId: snap.data!.postAuthorId,
                                          text: snap.data!.postAuthorName)
                                      .launch(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(FontAwesome.user_o,
                                        size: 16, color: textSecondaryColor),
                                    4.width,
                                    Text(
                                            snap.data!.postAuthorName
                                                .validate()
                                                .capitalizeFirstLetter(),
                                            style: secondaryTextStyle(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1)
                                        .expand(),
                                  ],
                                ),
                              ).expand(),
                              Row(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(FontAwesome.commenting_o,
                                            size: 16,
                                            color: textSecondaryColor),
                                        4.width,
                                        Text(
                                            snap.data!.noOfComments != "0"
                                                ? snap.data!.noOfCommentsText
                                                    .toString()
                                                : "Add Comments",
                                            style: secondaryTextStyle()),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
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
                                            color: textSecondaryColor,
                                            size: 16),
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
                            ],
                          ).paddingSymmetric(horizontal: 8),

                          HtmlWidget(
                                  postContent:
                                      snap.data!.postContent.validate().trim())
                              .paddingSymmetric(horizontal: 10),

                          // Relatable Post
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
                                      return DefaultFeaturedComponent(
                                          snap.data!.relatedNews![index]);
                                    }),
                              ],
                            ),
                        ],
                      ),
                    ).expand(),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 16),
                  padding: EdgeInsets.all(12),
                  decoration: boxDecorationWithShadowWidget(
                      backgroundColor: context.cardColor,
                      blurRadius: 10,
                      boxShape: BoxShape.circle),
                  child: Observer(builder: (context) {
                    return bookMarkStore
                            .isItemInBookMark(widget.postId.validate())
                        ? Icon(Ionicons.bookmark, color: primaryColor)
                        : Icon(Ionicons.bookmark_outline,
                            color: context.iconColor);
                  }),
                ).onTap(() {
                  if (userStore.isLoggedIn) {
                    addToBookMark(snap.data!);
                    setState(() {});
                  } else {
                    SignInScreen().launch(context);
                  }
                })
              ],
            );
          }
          if (snap.hasError) {
            apiErrorComponent(snap.error, context);
          }
          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}
