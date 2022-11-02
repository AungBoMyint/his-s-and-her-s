import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kzn/blog/language/language.dart';
import '../component/DialogComponent.dart';
import '../utils/AppColor.dart';
import '../utils/AppConstant.dart';
import '../utils/DefaultCardConfig.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Loader.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import 'package:kzn/main.dart';
import '../component/NoDataWidget.dart';
import '../utils/DefaultCardTypeConfig.dart';

class BookMarkScreen extends StatefulWidget {
  static String tag = '/SavedScreen';

  @override
  BookMarkScreenState createState() => BookMarkScreenState();
}

class BookMarkScreenState extends State<BookMarkScreen> {
  ScrollController scrollController = ScrollController();
  int page = 1;
  int numPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !appStore.isLoading) {
        page++;
        bookMarkStore.getBookMarkItem(page: page);
      }
    });
  }

  init() async {
    //   appStore.setLoading(true);
    // bookMarkStore.getBookMarkItem(page: 1);
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget slideLeftBackground() {
    return Container(
      decoration: boxDecorationWithRoundedCornersWidget(
          backgroundColor: primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(defaultRadius),
              bottomLeft: Radius.circular(defaultRadius))),
      margin: EdgeInsets.only(bottom: 16),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            20.width,
            Icon(Icons.delete, color: Colors.white),
            Text(" " + LanguageEn.btnRemove,
                style: primaryTextStyle(size: 18, color: Colors.white),
                textAlign: TextAlign.right),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(LanguageEn.lblBookMark,
          elevation: 0, showBack: false, textColor: Colors.white),
      body: Observer(builder: (context) {
        return Stack(
          children: [
            if (userStore.isLoggedIn)
              getHomeWidget() == listCardType
                  ? AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bookMarkStore.bookMarkPost.length,
                        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                        itemBuilder: (_, index) {
                          return Dismissible(
                            key: Key(bookMarkStore.bookMarkPost[index].iD
                                .toString()),
                            secondaryBackground: SizedBox(),
                            background: slideLeftBackground(),
                            direction: DismissDirection.startToEnd,
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                return showDialogBox(
                                    context, LanguageEn.dltBookMarkTxt,
                                    onCancelCall: () {
                                  finish(context);
                                }, onCall: () {
                                  bookMarkStore.addtoBookMark(
                                      bookMarkStore.bookMarkPost[index]);
                                  finish(context);
                                });
                              } else {
                                return null;
                              }
                            },
                            child: AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 1,
                              child: SlideAnimation(
                                horizontalOffset: 50.0,
                                verticalOffset: 20.0,
                                child: FadeInAnimation(
                                  child: defaultCardConfig(context,
                                      bookMarkStore.bookMarkPost[index]),
                                ),
                              ),
                            ),
                          );
                        },
                      ).visible(!appStore.isLoading),
                    )
                  : AnimationLimiter(
                      child: Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children: List.generate(
                          bookMarkStore.bookMarkPost.length,
                          (index) {
                            return AnimationConfiguration.staggeredGrid(
                              duration: const Duration(milliseconds: 750),
                              columnCount: 1,
                              position: index,
                              child: FlipAnimation(
                                curve: Curves.linear,
                                child: FadeInAnimation(
                                  child: defaultCardConfig(context,
                                      bookMarkStore.bookMarkPost[index]),
                                ),
                              ),
                            );
                          },
                        ),
                      ).paddingOnly(left: 16, top: 16, bottom: 16),
                    ),
            NoDataWidget(LanguageEn.emptyBookMarkTxt).center().visible(
                !appStore.isLoading && bookMarkStore.bookMarkPost.isEmpty),
            Loader().center().visible(appStore.isLoading)
          ],
        );
      }),
    );
  }
}
