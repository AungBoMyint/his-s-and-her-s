import 'package:flutter/material.dart';
import 'package:kzn/blog/language/language.dart';
import '../../main.dart';
import '../component/AddCommentDialogComponent.dart';
import '../component/DialogComponent.dart';
import '../component/NoDataWidget.dart';
import '../model/CommentResponse.dart';
import '../network/RestApi.dart';
import '../utils/AppColor.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../component/AppWidget.dart';
import 'SignInScreen.dart';

class CommentScreen extends StatefulWidget {
  final int postId;

  CommentScreen(this.postId);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController addCommentCont = TextEditingController();
  bool isUserExist = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future deleteComment(int id) async {
    Map req = {"id": id, "force_delete": false};
    removeComment(req).then((res) {
      appStore.isLoading = false;
      toast(res.message.validate());
      userStore.mIsUserExistInReview = false;
      setState(() {});
    }).catchError((error) {
      appStore.isLoading = false;
      toast(error.toString());
      apiErrorComponent(error, context);
    });
  }

  Widget slideLeftBackground() {
    return Container(
      decoration: boxDecorationWithRoundedCornersWidget(
          backgroundColor: primaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(defaultRadius),
              bottomRight: Radius.circular(defaultRadius))),
      margin: EdgeInsets.only(bottom: 16),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.delete, color: Colors.white),
            Text(" " + LanguageEn.btnDelete,
                style: primaryTextStyle(size: 18, color: Colors.white),
                textAlign: TextAlign.right),
            20.width,
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(LanguageEn.lblComments,
          showBack: true, textColor: Colors.white),
      body: FutureBuilder<List<CommentResponse>>(
        future: getCommentList(widget.postId),
        builder: (_, snap) {
          if (snap.hasData) {
            snap.data!.forEach((element) {
              print("Author" + element.author.toString());
              print("userId" + userStore.userId.toString());
              if (element.author == userStore.userId) {
                userStore.mIsUserExistInReview = true;
              }
            });

            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                if (snap.data!.isNotEmpty)
                  ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: snap.data!.length,
                      itemBuilder: (c, i) {
                        CommentResponse data = snap.data![i];
                        return AbsorbPointer(
                          absorbing:
                              data.author == userStore.userId ? false : true,
                          child: Dismissible(
                            secondaryBackground: slideLeftBackground(),
                            background: SizedBox(),
                            direction: DismissDirection.endToStart,
                            key: Key(snap.data![i].id.toString()),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                await showDialogBox(
                                    context, LanguageEn.msgDltComment,
                                    onCall: () {
                                  finish(context);
                                  addCommentCont.clear();
                                  appStore.setLoading(true);
                                  deleteComment(data.id.validate());
                                  setState(() {});
                                }, onCancelCall: () {
                                  finish(context);
                                  setState(() {});
                                });
                              } else {}
                              return null;
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: context.cardColor,
                                        backgroundImage: NetworkImage(data
                                            .authorAvatarUrls!.s96
                                            .validate()),
                                        maxRadius: 25),
                                    8.width,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data.authorName.validate(),
                                            style: boldTextStyle()),
                                        Text(
                                            dateConverter(data.date.validate()),
                                            style: secondaryTextStyle()),
                                      ],
                                    ).expand()
                                  ],
                                ),
                                4.height,
                                Text(
                                        parseHtmlString(
                                            data.content!.rendered.validate()),
                                        style: primaryTextStyle())
                                    .paddingLeft(6),
                              ],
                            ),
                          ),
                        );
                      })
                else
                  NoDataWidget("No Comments"),
                Container(
                        margin: EdgeInsets.only(bottom: 20, right: 16),
                        padding: EdgeInsets.all(12),
                        decoration: boxDecorationWithShadowWidget(
                            backgroundColor: primaryColor,
                            blurRadius: 15,
                            boxShape: BoxShape.circle),
                        child: Icon(Icons.add, color: Colors.white, size: 30))
                    .onTap(() {
                  if (userStore.isLoggedIn) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddCommentDialogComponent(
                            id: widget.postId.validate(),
                            onCall: () {
                              setState(() {});
                            },
                          );
                        });
                  } else
                    SignInScreen().launch(context);
                })
              ],
            );
          }
          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}
