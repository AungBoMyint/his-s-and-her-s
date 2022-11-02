import '../../utils/AppConstant.dart';
import '../../utils/Extensions/shared_pref.dart';
import 'package:mobx/mobx.dart';

part 'UserStore.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  int userId = 0;

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String fName = '';

  @observable
  String lName = '';

  @observable
  String profileImage = '';

  @observable
  String username = '';

  @observable
  String token = '';

  @observable
  bool mIsUserExistInReview = false;

  @action
  Future<void> setUserImage(String val, {bool isInitialization = false}) async {
    profileImage = val;
    if (!isInitialization) await setValue(userPhotoUrl, val);
  }

  @action
  Future<void> setUserID(int val, {bool isInitialization = false}) async {
    userId = val;
    if (!isInitialization) await setValue(uId, val);
  }

  @action
  Future<void> setLogin(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(isLogIn, val);
  }

  @action
  Future<void> setFirstName(String val, {bool isInitialization = false}) async {
    fName = val;
    if (!isInitialization) await setValue(firstName, val);
  }

  @action
  Future<void> setLastName(String val, {bool isInitialization = false}) async {
    lName = val;
    if (!isInitialization) await setValue(lastName, val);
  }

  @action
  Future<void> setUserEmail(String val, {bool isInitialization = false}) async {
    email = val;
    if (!isInitialization) await setValue(userEmail, val);
  }

  @action
  Future<void> setUserName(String val, {bool isInitialization = false}) async {
    username = val;
    if (!isInitialization) await setValue(userName, val);
  }

  @action
  Future<void> setUserPassword(String val,
      {bool isInitialization = false}) async {
    password = val;
    if (!isInitialization) await setValue(userPassword, val);
  }

  @action
  Future<void> setToken(String val, {bool isInitialization = false}) async {
    token = val;
    if (!isInitialization) await setValue(apiToken, val);
  }
}
