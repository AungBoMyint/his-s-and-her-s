import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../component/AppWidget.dart';
import '../../component/HtmlWidget.dart';
import '../../model/BlogDetailResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/Extensions/Colors.dart';
import '../../utils/Extensions/HorizontalList.dart';
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
import '../../component/Food/FoodFeatureComponent.dart';
import '../../component/ReadAloudDialog.dart';
import 'package:kzn/main.dart';
import '../../utils/Extensions/Commons.dart';
import '../SignInScreen.dart';
import '../ViewAllScreen.dart';

class FoodDetailScreen extends StatefulWidget {
  final int? postId;

  FoodDetailScreen({this.postId});

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  ScrollController scrollController = ScrollController();
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
                    Stack(
                      children: [
                        commonCacheImageWidget(snap.data!.image.validate(),
                                fit: BoxFit.cover,
                                height: context.height() * 0.6,
                                width: context.width())
                            .cornerRadiusWithClipRRect(defaultRadius),
                        8.height,
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: boxDecorationWithShadowWidget(
                                  boxShape: BoxShape.circle,
                                  backgroundColor:
                                      primaryColor.withOpacity(0.6)),
                              child:
                                  Icon(Icons.arrow_back, color: Colors.white),
                            ).onTap(
                              () {
                                finish(context);
                              },
                            ).paddingSymmetric(horizontal: 16),
                            SizedBox().expand(),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: boxDecorationWithShadowWidget(
                                  boxShape: BoxShape.circle,
                                  backgroundColor:
                                      primaryColor.withOpacity(0.6)),
                              child: Icon(
                                  snap.data!.isLike != true
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: snap.data!.isLike != true
                                      ? Colors.white
                                      : Colors.white),
                            ).onTap(
                              () {
                                likeDislike(widget.postId.validate(), context,
                                    onCall: () {
                                  setState(() {
                                    mGetDetail = getBlogDetail(widget.postId!);
                                  });
                                });
                              },
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: boxDecorationWithShadowWidget(
                                  boxShape: BoxShape.circle,
                                  backgroundColor:
                                      primaryColor.withOpacity(0.6)),
                              child: Observer(builder: (context) {
                                return bookMarkStore.isItemInBookMark(
                                        widget.postId.validate())
                                    ? Icon(Ionicons.bookmark,
                                        color: Colors.white)
                                    : Icon(Ionicons.bookmark_outline,
                                        color: Colors.white);
                              }).onTap(() {
                                if (userStore.isLoggedIn) {
                                  addToBookMark(snap.data!);
                                  setState(() {});
                                } else {
                                  SignInScreen().launch(context);
                                }
                              }).paddingSymmetric(horizontal: 16),
                            ),
                            Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: boxDecorationWithShadowWidget(
                                        boxShape: BoxShape.circle,
                                        backgroundColor:
                                            primaryColor.withOpacity(0.6)),
                                    child: ReadAloudDialog(
                                            parseHtmlString(
                                                snap.data!.postContent),
                                            isShape: true)
                                        .fit())
                                .paddingRight(16),
                          ],
                        ).paddingTop(context.statusBarHeight + 4),
                        DraggableScrollableSheet(
                          minChildSize: 0.5,
                          maxChildSize: 1,
                          builder: (_, scrollController) {
                            return SingleChildScrollView(
                              controller: scrollController,
                              child: Container(
                                decoration: boxDecorationWithShadowWidget(
                                    backgroundColor: context.cardColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    20.height,
                                    snap.data!.category != null &&
                                            snap.data!.category!.isNotEmpty
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            padding:
                                                EdgeInsets.fromLTRB(8, 4, 8, 4),
                                            decoration:
                                                boxDecorationWithShadowWidget(
                                                    border:
                                                        Border.all(width: 0.1),
                                                    borderRadius: radius(6),
                                                    backgroundColor:
                                                        primaryColor),
                                            child: Text(
                                                snap.data!.category!.first.name
                                                    .validate(),
                                                style: boldTextStyle(
                                                    color: Colors.white,
                                                    size: 14)),
                                          )
                                        : SizedBox(),
                                    8.height,
                                    Row(
                                      children: [
                                        Icon(
                                                MaterialCommunityIcons
                                                    .timer_outline,
                                                size: 16,
                                                color: textSecondaryColor)
                                            .visible(snap.data!.postDate
                                                .validate()
                                                .isNotEmpty),
                                        4.width.visible(snap.data!.postDate
                                            .validate()
                                            .isNotEmpty),
                                        if (snap.data!.postDate
                                            .validate()
                                            .isNotEmpty)
                                          Text(
                                                  dateConverter(snap
                                                      .data!.postDate
                                                      .validate()),
                                                  style: secondaryTextStyle())
                                              .expand(),
                                      ],
                                    ).paddingSymmetric(horizontal: 16),
                                    8.height,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                                parseHtmlString(snap
                                                    .data!.postTitle
                                                    .validate()),
                                                style: boldTextStyle(size: 20))
                                            .expand(),
                                        Container(
                                                padding: EdgeInsets.all(8),
                                                decoration:
                                                    boxDecorationWithShadowWidget(
                                                        boxShape:
                                                            BoxShape.circle,
                                                        backgroundColor:
                                                            primaryColor
                                                                .withOpacity(
                                                                    0.2)),
                                                child: Icon(
                                                    Ionicons
                                                        .share_social_outline,
                                                    color: context.iconColor))
                                            .onTap(
                                          () {
                                            Share.share(
                                                'Share ${snap.data!.postTitle} app\n$playStoreBaseURL${snap.data!.shareUrl}');
                                          },
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: 16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Author by: ",
                                                style: secondaryTextStyle()),
                                            Text(
                                                    snap.data!.postAuthorName
                                                        .validate()
                                                        .capitalizeFirstLetter(),
                                                    style: boldTextStyle())
                                                .expand(),
                                          ],
                                        ).onTap(() {
                                          ViewAllScreen(
                                                  name: snap
                                                      .data!.postAuthorName
                                                      .validate(),
                                                  authId:
                                                      snap.data!.postAuthorId,
                                                  text:
                                                      snap.data!.postAuthorName)
                                              .launch(context);
                                        }).expand(),
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
                                                      color:
                                                          textSecondaryColor),
                                                  4.width,
                                                  Text(
                                                      snap.data!.noOfComments !=
                                                              "0"
                                                          ? snap.data!
                                                              .noOfCommentsText
                                                              .toString()
                                                          : "Add Comments",
                                                      style:
                                                          secondaryTextStyle()),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.favorite_border,
                                                    size: 16,
                                                    color: textSecondaryColor),
                                                4.width,
                                                Text(
                                                    snap.data!.likeCount
                                                            .toString() +
                                                        " " +
                                                        "Likes",
                                                    style:
                                                        secondaryTextStyle()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: 16),
                                    if (snap.data!.tags != null &&
                                        snap.data!.tags!.isNotEmpty)
                                      Wrap(
                                        runSpacing: 12,
                                        children: List.generate(
                                          snap.data!.tags!.length,
                                          (i) {
                                            Tags data = snap.data!.tags![i];
                                            return Text(data.name.validate(),
                                                    style: secondaryTextStyle())
                                                .onTap(() {
                                              ViewAllScreen(
                                                      name: 'by_tag',
                                                      text: data.name
                                                          .splitAfter("#"),
                                                      tagId: data.termId)
                                                  .launch(context);
                                            });
                                          },
                                        ),
                                      ).paddingSymmetric(horizontal: 16),
                                    HtmlWidget(
                                            postContent: snap.data!.postContent
                                                .validate()
                                                .trim())
                                        .paddingSymmetric(
                                            horizontal: 12, vertical: 8),
                                    16.height,
                                    if (snap.data!.relatedNews != null &&
                                        snap.data!.relatedNews!.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Relatable Post",
                                                  style:
                                                      boldTextStyle(size: 18))
                                              .paddingSymmetric(horizontal: 16),
                                          8.height,
                                          HorizontalList(
                                              itemCount: snap
                                                  .data!.relatedNews!.length,
                                              padding: EdgeInsets.only(
                                                  bottom: 20,
                                                  right: 16,
                                                  left: 16),
                                              itemBuilder: (_, index) {
                                                return FoodFeatureComponent(
                                                  snap.data!
                                                      .relatedNews![index],
                                                  isSlider: true,
                                                );
                                              }),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ).expand(),
                  ],
                ),
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
