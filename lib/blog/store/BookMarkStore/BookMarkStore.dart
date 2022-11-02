import 'dart:convert';

import '../../../main.dart';
import '../../model/DefaultPostResponse.dart';
import '../../network/RestApi.dart';
import '../../utils/AppCommon.dart';
import '../../utils/AppConstant.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/shared_pref.dart';
import '../../utils/Extensions/string_extensions.dart';
import '../../utils/Extensions/Commons.dart';
import 'package:mobx/mobx.dart';

part 'BookMarkStore.g.dart';

class BookMarkStore = BookMarkStoreBase with _$BookMarkStore;

abstract class BookMarkStoreBase with Store {
  @observable
  List<DefaultPostResponse> bookMarkPost =
      ObservableList<DefaultPostResponse>();

  @observable
  bool isLastPage = false;

  @action
  Future<void> addtoBookMark(DefaultPostResponse? data) async {
    if (bookMarkPost.any((element) => element.iD == data!.iD)) {
      Map req = {'post_id': data!.iD};
      log(bookMarkPost.remove(data));
      bookMarkPost.remove(data);
      removeBookMark(req).then((res) {
        toast(res.message.validate());
        getBookMarkItem();
        storeBookMarkData();
      }).catchError((error) {
        data.isBookmark = !data.isBookmark.validate();
        toast(error.toString());
      });
    } else {
      Map req = {'post_id': data!.iD};
      bookMarkPost.add(data);
      addBookMark(req).then((res) {
        appStore.isLoading = false;
        toast(res['message']);
        getBookMarkItem();
        storeBookMarkData();
      }).catchError((error) {
        data.isBookmark = !data.isBookmark.validate();
        appStore.isLoading = false;
        toast(error.toString());
      });
    }
  }

  @action
  Future<void> storeBookMarkData() async {
    if (bookMarkPost.isNotEmpty) {
      log("bookmark list");
      await setValue(BOOKMARK_LIST, jsonEncode(bookMarkPost));
      log(getStringAsync(BOOKMARK_LIST));
    } else {
      await setValue(BOOKMARK_LIST, '');
    }
  }

  bool isItemInBookMark(int id) {
    return bookMarkPost.any((element) => element.iD == id);
  }

  @action
  void addAllBookMarkItem(List<DefaultPostResponse> postList) {
    bookMarkPost.addAll(postList);
  }

  @action
  Future<void> getBookMarkItem({int? page}) async {
    getBookMark(page ?? -1).then((value) {
      appStore.setLoading(false);
      isLastPage = false;
      if (page == 1) {
        bookMarkPost.clear();
      }
      bookMarkPost = value.posts!;
    }).catchError((e) {
      log(e.toString());
      isLastPage = true;
      appStore.setLoading(false);
    });
  }

  @action
  Future<void> clearBookMark() async {
    bookMarkPost.clear();
    storeBookMarkData();
  }
}
