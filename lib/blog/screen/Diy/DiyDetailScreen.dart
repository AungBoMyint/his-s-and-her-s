import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../main.dart';
import '../../model/BlogDetailResponse.dart';
import '../../network/RestApi.dart';
import '../../screen/SignInScreen.dart';
import '../../utils/AppColor.dart';
import '../../utils/AppCommon.dart';
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
import '../../component/Diy/DiyFeaturedComponent.dart';
import '../../component/HtmlWidget.dart';
import '../../component/ReadAloudDialog.dart';
import '../../utils/Extensions/Commons.dart';
import '../ViewAllScreen.dart';

class DiyDetailScreen extends StatefulWidget {
  static String tag = '/FitnessDetailScreen';
  final int? postId;

  DiyDetailScreen({this.postId});

  @override
  DiyDetailScreenState createState() => DiyDetailScreenState();
}

class DiyDetailScreenState extends State<DiyDetailScreen> {
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
    log("Diy");
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
                        IconButton(onPressed: () {
                          if (userStore.isLoggedIn) {
                            addToBookMark(snap.data!);
                            setState(() {});
                          } else {
                            SignInScreen().launch(context);
                          }
                        }, icon: Observer(builder: (context) {
                          return bookMarkStore
                                  .isItemInBookMark(widget.postId.validate())
                              ? Icon(Ionicons.bookmark)
                              : Icon(Ionicons.bookmark_outline);
                        })),
                        IconButton(
                          onPressed: () {
                            likeDislike(widget.postId.validate(), context,
                                onCall: () {
                              setState(() {
                                mGetDetail = getBlogDetail(widget.postId!);
                              });
                            });
                          },
                          icon: Icon(
                              snap.data!.isLike != true
                                  ? Icons.favorite_border
                                  : Icons.favorite,
                              color: context.iconColor),
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
                    )
                  ],
                ).paddingTop(context.statusBarHeight + 4),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: boxDecorationWithShadowWidget(
                            backgroundColor: context.cardColor, blurRadius: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Category
                                snap.data!.category != null &&
                                        snap.data!.category!.isNotEmpty
                                    ? Container(
                                        margin: EdgeInsets.only(top: 16),
                                        padding:
                                            EdgeInsets.fromLTRB(8, 4, 8, 4),
                                        decoration:
                                            boxDecorationWithShadowWidget(
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
                                12.height,
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
                                          style: secondaryTextStyle()),
                                  ],
                                ),
                                12.height,
                                Text(
                                    parseHtmlString(
                                        snap.data!.postTitle.validate()),
                                    style: boldTextStyle(size: 20)),
                                12.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesome.user_o,
                                            size: 14,
                                            color: textSecondaryColorGlobal),
                                        4.width,
                                        if (snap.data!.postAuthorName
                                            .validate()
                                            .isNotEmpty)
                                          Text(
                                              snap.data!.postAuthorName
                                                  .validate()
                                                  .capitalizeFirstLetter(),
                                              style: secondaryTextStyle()),
                                      ],
                                    ).visible(snap.data!.postAuthorName
                                        .validate()
                                        .isNotEmpty),
                                    SizedBox().expand(),
                                    Row(
                                      children: [
                                        Icon(FontAwesome.commenting_o,
                                            size: 18,
                                            color: textSecondaryColorGlobal),
                                        6.width,
                                        Text(snap.data!.noOfComments.validate(),
                                            style: secondaryTextStyle()),
                                      ],
                                    ).onTap(() async {
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
                                    }),
                                  ],
                                ),
                                12.height,
                              ],
                            ).paddingOnly(right: 8, left: 16).expand(),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: context.width() * 0.5,
                                  height: 290,
                                  padding: EdgeInsets.all(4),
                                  decoration: boxDecorationWithShadowWidget(
                                      border: Border.all(width: 2)),
                                  child: commonCacheImageWidget(
                                      snap.data!.image!,
                                      fit: BoxFit.cover),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      24.height,

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
                                  ViewAllScreen(
                                          name: 'by_tag',
                                          text: data.name.splitAfter("#"),
                                          tagId: data.termId)
                                      .launch(context);
                                  setState(() {});
                                }),
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: boxDecorationWithShadowWidget(
                                        backgroundColor: primaryColor,
                                        borderRadius: radius(8)),
                                    child: Text(data.name.validate() + " ",
                                        style: secondaryTextStyle(
                                            color: Colors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                              );
                            },
                          ),
                        ).paddingOnly(left: 16, bottom: 16, top: 16).visible(
                            snap.data!.tags != null &&
                                snap.data!.tags!.isNotEmpty),
                      8.height.visible(
                          snap.data!.tags == null && snap.data!.tags!.isEmpty),

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
                            Text("Relatable Post",
                                    style: boldTextStyle(size: 18))
                                .paddingSymmetric(horizontal: 16),
                            8.height,
                            HorizontalList(
                                itemCount: snap.data!.relatedNews!.length,
                                padding: EdgeInsets.only(
                                    bottom: 20, right: 16, left: 16),
                                itemBuilder: (_, index) {
                                  return DiyFeaturedComponent(
                                      snap.data!.relatedNews![index],
                                      isSlider: true);
                                }),
                          ],
                        ),
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
