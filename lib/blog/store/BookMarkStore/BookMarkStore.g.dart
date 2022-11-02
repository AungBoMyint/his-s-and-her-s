// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookMarkStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BookMarkStore on BookMarkStoreBase, Store {
  final _$bookMarkPostAtom = Atom(name: 'BookMarkStoreBase.bookMarkPost');

  @override
  List<DefaultPostResponse> get bookMarkPost {
    _$bookMarkPostAtom.reportRead();
    return super.bookMarkPost;
  }

  @override
  set bookMarkPost(List<DefaultPostResponse> value) {
    _$bookMarkPostAtom.reportWrite(value, super.bookMarkPost, () {
      super.bookMarkPost = value;
    });
  }

  final _$isLastPageAtom = Atom(name: 'BookMarkStoreBase.isLastPage');

  @override
  bool get isLastPage {
    _$isLastPageAtom.reportRead();
    return super.isLastPage;
  }

  @override
  set isLastPage(bool value) {
    _$isLastPageAtom.reportWrite(value, super.isLastPage, () {
      super.isLastPage = value;
    });
  }

  final _$addtoBookMarkAsyncAction =
      AsyncAction('BookMarkStoreBase.addtoBookMark');

  @override
  Future<void> addtoBookMark(DefaultPostResponse? data) {
    return _$addtoBookMarkAsyncAction.run(() => super.addtoBookMark(data));
  }

  final _$storeBookMarkDataAsyncAction =
      AsyncAction('BookMarkStoreBase.storeBookMarkData');

  @override
  Future<void> storeBookMarkData() {
    return _$storeBookMarkDataAsyncAction.run(() => super.storeBookMarkData());
  }

  final _$getBookMarkItemAsyncAction =
      AsyncAction('BookMarkStoreBase.getBookMarkItem');

  @override
  Future<void> getBookMarkItem({int? page}) {
    return _$getBookMarkItemAsyncAction
        .run(() => super.getBookMarkItem(page: page));
  }

  final _$clearBookMarkAsyncAction =
      AsyncAction('BookMarkStoreBase.clearBookMark');

  @override
  Future<void> clearBookMark() {
    return _$clearBookMarkAsyncAction.run(() => super.clearBookMark());
  }

  final _$BookMarkStoreBaseActionController =
      ActionController(name: 'BookMarkStoreBase');

  @override
  void addAllBookMarkItem(List<DefaultPostResponse> postList) {
    final _$actionInfo = _$BookMarkStoreBaseActionController.startAction(
        name: 'BookMarkStoreBase.addAllBookMarkItem');
    try {
      return super.addAllBookMarkItem(postList);
    } finally {
      _$BookMarkStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bookMarkPost: ${bookMarkPost},
isLastPage: ${isLastPage}
    ''';
  }
}
