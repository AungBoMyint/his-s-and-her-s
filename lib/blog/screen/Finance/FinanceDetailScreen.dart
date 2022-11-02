import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../model/BlogDetailResponse.dart';
import 'package:kzn/main.dart';
import '../../network/RestApi.dart';
import '../../screen/SignInScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppImages.dart';
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
import '../../component/Finance/FinanceFeatureComponent.dart';
import '../../component/HtmlWidget.dart';
import '../../component/ReadAloudDialog.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/Commons.dart';
import '../ViewAllScreen.dart';

class FinanceDetailScreen extends StatefulWidget {
  static String tag = '/FitnessDetailScreen';
  final int? postId;

  FinanceDetailScreen({this.postId});

  @override
  FinanceDetailScreenState createState() => FinanceDetailScreenState();
}

class FinanceDetailScreenState extends State<FinanceDetailScreen> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(),
                    Row(
                      children: [
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
                    )
                  ],
                ).paddingTop(context.statusBarHeight + 4),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category
                      snap.data!.category != null &&
                              snap.data!.category!.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                              margin: EdgeInsets.only(left: 16, top: 4),
                              decoration: boxDecorationWithShadowWidget(
                                  border: Border.all(width: 0.1),
                                  borderRadius: radius(0),
                                  backgroundColor: appStore.isDarkMode
                                      ? context.cardColor
                                      : primaryColor),
                              child: Text(
                                  snap.data!.category!.first.name.validate(),
                                  style: boldTextStyle(
                                      color: Colors.white, size: 14)),
                            )
                          : SizedBox(),
                      8.height,
                      // Load image
                      Container(
                        decoration: boxDecorationWithShadowWidget(
                            backgroundColor: context.cardColor, blurRadius: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Load image
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                !snap.data!.image!.isEmptyOrNull
                                    ? commonCacheImageWidget(
                                            snap.data!.image.validate(),
                                            fit: BoxFit.fill,
                                            height: context.height() * 0.35,
                                            width: context.width())
                                        .paddingOnly(bottom: 16)
                                    : Image.asset(ic_placeHolder,
                                            fit: BoxFit.fill,
                                            height: context.height() * 0.35,
                                            width: context.width())
                                        .paddingOnly(bottom: 16),
                                Positioned(
                                    top: -5,
                                    right: 20,
                                    child: Observer(builder: (context) {
                                      return bookMarkStore.isItemInBookMark(
                                              widget.postId.validate())
                                          ? Icon(Ionicons.bookmark,
                                              color: primaryColor, size: 40)
                                          : Icon(Ionicons.bookmark_outline,
                                              color: context.iconColor,
                                              size: 40);
                                    }).onTap(() {
                                      if (userStore.isLoggedIn) {
                                        addToBookMark(snap.data!);
                                        setState(() {});
                                      } else {
                                        SignInScreen().launch(context);
                                      }
                                    })),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
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
                                      child: Container(
                                        decoration:
                                            boxDecorationWithRoundedCornersWidget(
                                                borderRadius: radius(0),
                                                backgroundColor: primaryColor),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 4, 10, 4),
                                        child: Row(
                                          children: [
                                            Icon(
                                                snap.data!.isLike != true
                                                    ? Icons.favorite_border
                                                    : Icons.favorite,
                                                size: 16,
                                                color: whiteColor),
                                            8.width,
                                            Text(
                                                snap.data!.likeCount.toString(),
                                                style: secondaryTextStyle(
                                                    color: whiteColor)),
                                          ],
                                        ).paddingAll(4),
                                      ),
                                    ),
                                    16.width,
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
                                      child: Container(
                                        decoration:
                                            boxDecorationWithRoundedCornersWidget(
                                                borderRadius: radius(0),
                                                backgroundColor: primaryColor),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 4, 10, 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(FontAwesome.commenting_o,
                                                size: 16, color: whiteColor),
                                            8.width,
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
                                    ),
                                  ],
                                ).paddingRight(20)
                              ],
                            ),
                            8.height,
                            Text(
                                    parseHtmlString(
                                        snap.data!.postTitle!.validate()),
                                    style: boldTextStyle(size: 20))
                                .paddingSymmetric(horizontal: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(FontAwesome.user_o,
                                            size: 14,
                                            color: textPrimaryColorGlobal)
                                        .visible(snap.data!.postAuthorName
                                            .validate()
                                            .isNotEmpty),
                                    4.width.visible(snap.data!.postAuthorName
                                        .validate()
                                        .isNotEmpty),
                                    if (snap.data!.postAuthorName
                                        .validate()
                                        .isNotEmpty)
                                      Text(snap.data!.postAuthorName.validate(),
                                          style: secondaryTextStyle(
                                              color: textPrimaryColorGlobal)),
                                  ],
                                ),
                                16.width,
                                Row(
                                  children: [
                                    Icon(MaterialCommunityIcons.timer_outline,
                                            size: 14)
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
                                              color: textPrimaryColorGlobal)),
                                  ],
                                ),
                              ],
                            ).paddingAll(16),
                          ],
                        ),
                      ),

                      // Tag
                      Wrap(
                        runSpacing: 4,
                        children: List.generate(
                          snap.data!.tags!.length,
                          (index) {
                            Tags data = snap.data!.tags![index];
                            return GestureDetector(
                              onTap: (() {
                                ViewAllScreen(
                                        name: 'by_tag',
                                        text: data.name.splitAfter("#"),
                                        tagId: data.termId)
                                    .launch(context);
                                setState(() {});
                              }),
                              child: Text(data.name.validate() + " ",
                                  style: secondaryTextStyle(color: Colors.blue),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            );
                          },
                        ),
                      ).paddingOnly(left: 16, bottom: 16, top: 16),

                      //Description
                      HtmlWidget(
                              postContent: snap.data!.postContent!.validate())
                          .paddingOnly(left: 16, right: 16),

                      //related post
                      if (snap.data!.relatedNews!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            Text("Relatable Post",
                                    style: boldTextStyle(size: 18))
                                .paddingSymmetric(horizontal: 16),
                            8.height,
                            HorizontalList(
                                itemCount: snap.data!.relatedNews!.length,
                                padding: EdgeInsets.only(
                                    bottom: 20, right: 16, left: 16),
                                itemBuilder: (_, index) {
                                  return FinanceFeatureComponent(
                                      snap.data!.relatedNews![index],
                                      isSlider: true);
                                }),
                          ],
                        ).visible(snap.data!.relatedNews!.isNotEmpty &&
                            snap.data!.relatedNews != null),
                    ],
                  ),
                ).expand(),
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
