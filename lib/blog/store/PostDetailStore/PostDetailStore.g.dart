// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostDetailStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostDetailStore on _PostDetailStore, Store {
  final _$isTextTranslatedAtom =
      Atom(name: '_PostDetailStore.isTextTranslated');

  @override
  bool get isTextTranslated {
    _$isTextTranslatedAtom.reportRead();
    return super.isTextTranslated;
  }

  @override
  set isTextTranslated(bool value) {
    _$isTextTranslatedAtom.reportWrite(value, super.isTextTranslated, () {
      super.isTextTranslated = value;
    });
  }

  final _$postContentAtom = Atom(name: '_PostDetailStore.postContent');

  @override
  String get postContent {
    _$postContentAtom.reportRead();
    return super.postContent;
  }

  @override
  set postContent(String value) {
    _$postContentAtom.reportWrite(value, super.postContent, () {
      super.postContent = value;
    });
  }

  final _$postTitleAtom = Atom(name: '_PostDetailStore.postTitle');

  @override
  String get postTitle {
    _$postTitleAtom.reportRead();
    return super.postTitle;
  }

  @override
  set postTitle(String value) {
    _$postTitleAtom.reportWrite(value, super.postTitle, () {
      super.postTitle = value;
    });
  }

  final _$translatePostTitleAsyncAction =
      AsyncAction('_PostDetailStore.translatePostTitle');

  @override
  Future<void> translatePostTitle(String title, {String? language}) {
    return _$translatePostTitleAsyncAction
        .run(() => super.translatePostTitle(title, language: language));
  }

  final _$translatePostContentAsyncAction =
      AsyncAction('_PostDetailStore.translatePostContent');

  @override
  Future<void> translatePostContent(String post, {String? language}) {
    return _$translatePostContentAsyncAction
        .run(() => super.translatePostContent(post, language: language));
  }

  final _$_PostDetailStoreActionController =
      ActionController(name: '_PostDetailStore');

  @override
  void setBodyTranslated(bool val) {
    final _$actionInfo = _$_PostDetailStoreActionController.startAction(
        name: '_PostDetailStore.setBodyTranslated');
    try {
      return super.setBodyTranslated(val);
    } finally {
      _$_PostDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isTextTranslated: ${isTextTranslated},
postContent: ${postContent},
postTitle: ${postTitle}
    ''';
  }
}
