// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on UserStoreBase, Store {
  final _$isLoggedInAtom = Atom(name: 'UserStoreBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$userIdAtom = Atom(name: 'UserStoreBase.userId');

  @override
  int get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$emailAtom = Atom(name: 'UserStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: 'UserStoreBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$fNameAtom = Atom(name: 'UserStoreBase.fName');

  @override
  String get fName {
    _$fNameAtom.reportRead();
    return super.fName;
  }

  @override
  set fName(String value) {
    _$fNameAtom.reportWrite(value, super.fName, () {
      super.fName = value;
    });
  }

  final _$lNameAtom = Atom(name: 'UserStoreBase.lName');

  @override
  String get lName {
    _$lNameAtom.reportRead();
    return super.lName;
  }

  @override
  set lName(String value) {
    _$lNameAtom.reportWrite(value, super.lName, () {
      super.lName = value;
    });
  }

  final _$profileImageAtom = Atom(name: 'UserStoreBase.profileImage');

  @override
  String get profileImage {
    _$profileImageAtom.reportRead();
    return super.profileImage;
  }

  @override
  set profileImage(String value) {
    _$profileImageAtom.reportWrite(value, super.profileImage, () {
      super.profileImage = value;
    });
  }

  final _$usernameAtom = Atom(name: 'UserStoreBase.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$tokenAtom = Atom(name: 'UserStoreBase.token');

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$mIsUserExistInReviewAtom =
      Atom(name: 'UserStoreBase.mIsUserExistInReview');

  @override
  bool get mIsUserExistInReview {
    _$mIsUserExistInReviewAtom.reportRead();
    return super.mIsUserExistInReview;
  }

  @override
  set mIsUserExistInReview(bool value) {
    _$mIsUserExistInReviewAtom.reportWrite(value, super.mIsUserExistInReview,
        () {
      super.mIsUserExistInReview = value;
    });
  }

  final _$setUserImageAsyncAction = AsyncAction('UserStoreBase.setUserImage');

  @override
  Future<void> setUserImage(String val, {bool isInitialization = false}) {
    return _$setUserImageAsyncAction
        .run(() => super.setUserImage(val, isInitialization: isInitialization));
  }

  final _$setUserIDAsyncAction = AsyncAction('UserStoreBase.setUserID');

  @override
  Future<void> setUserID(int val, {bool isInitialization = false}) {
    return _$setUserIDAsyncAction
        .run(() => super.setUserID(val, isInitialization: isInitialization));
  }

  final _$setLoginAsyncAction = AsyncAction('UserStoreBase.setLogin');

  @override
  Future<void> setLogin(bool val, {bool isInitializing = false}) {
    return _$setLoginAsyncAction
        .run(() => super.setLogin(val, isInitializing: isInitializing));
  }

  final _$setFirstNameAsyncAction = AsyncAction('UserStoreBase.setFirstName');

  @override
  Future<void> setFirstName(String val, {bool isInitialization = false}) {
    return _$setFirstNameAsyncAction
        .run(() => super.setFirstName(val, isInitialization: isInitialization));
  }

  final _$setLastNameAsyncAction = AsyncAction('UserStoreBase.setLastName');

  @override
  Future<void> setLastName(String val, {bool isInitialization = false}) {
    return _$setLastNameAsyncAction
        .run(() => super.setLastName(val, isInitialization: isInitialization));
  }

  final _$setUserEmailAsyncAction = AsyncAction('UserStoreBase.setUserEmail');

  @override
  Future<void> setUserEmail(String val, {bool isInitialization = false}) {
    return _$setUserEmailAsyncAction
        .run(() => super.setUserEmail(val, isInitialization: isInitialization));
  }

  final _$setUserNameAsyncAction = AsyncAction('UserStoreBase.setUserName');

  @override
  Future<void> setUserName(String val, {bool isInitialization = false}) {
    return _$setUserNameAsyncAction
        .run(() => super.setUserName(val, isInitialization: isInitialization));
  }

  final _$setUserPasswordAsyncAction =
      AsyncAction('UserStoreBase.setUserPassword');

  @override
  Future<void> setUserPassword(String val, {bool isInitialization = false}) {
    return _$setUserPasswordAsyncAction.run(
        () => super.setUserPassword(val, isInitialization: isInitialization));
  }

  final _$setTokenAsyncAction = AsyncAction('UserStoreBase.setToken');

  @override
  Future<void> setToken(String val, {bool isInitialization = false}) {
    return _$setTokenAsyncAction
        .run(() => super.setToken(val, isInitialization: isInitialization));
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
userId: ${userId},
email: ${email},
password: ${password},
fName: ${fName},
lName: ${lName},
profileImage: ${profileImage},
username: ${username},
token: ${token},
mIsUserExistInReview: ${mIsUserExistInReview}
    ''';
  }
}
