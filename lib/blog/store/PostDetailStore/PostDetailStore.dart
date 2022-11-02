import 'package:mobx/mobx.dart';

import '../../../main.dart';
part 'PostDetailStore.g.dart';

class PostDetailStore = _PostDetailStore with _$PostDetailStore;

abstract class _PostDetailStore with Store {
  @observable
  bool isTextTranslated = false;

  @observable
  String postContent = '';

  @observable
  String postTitle = '';

  @action
  void setBodyTranslated(bool val) {
    isTextTranslated = val;
  }

  @action
  Future<void> translatePostTitle(String title, {String? language}) async {
    if (title.isEmpty) {
      postTitle = '';
    } else {
      // postTitle = 'loading';
      await translator.translate(title, to: language ?? 'en').then((value) {
        postTitle = value.text;
        print(postTitle);
      }).catchError((e) {
        postTitle = title;
        // toast(postTitle);
      });
    }
  }

  @action
  Future<void> translatePostContent(String post, {String? language}) async {
    if (post.isEmpty) {
      postContent = '';
    } else {
      // postContent = 'loading';
      await translator.translate(post, to: language ?? 'en').then((value) {
        postContent = value.text;
        print(postTitle);
      }).catchError((e) {
        // toast(errorSomethingWentWrong);
        postContent = post;
      });
    }
  }
}
