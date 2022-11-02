import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../main.dart';
import '../model/AppConfigurationResponse.dart';
import '../model/BlogDetailResponse.dart';
import '../model/CategoryResponse.dart';
import '../model/CommentResponse.dart';
import '../model/CustomDashboardResponse.dart';
import '../model/BookmarkListResponse.dart';
import '../model/DefaultPostResponse.dart';
import '../model/DefaultResponse.dart';
import '../model/ForgotPasswordResponseModel.dart';
import '../model/LikeDislikeResponse.dart';
import '../model/LoginResponse.dart';
import '../model/RegistrationResponse.dart';
import '../screen/DashboardScreen.dart';
import '../utils/AppCommon.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/string_extensions.dart';
import 'NetworkUtils.dart';

Future<RegistrationResponse> signUp(
    {required String firstName,
    required String lastName,
    required String userLogin,
    required String userEmail,
    required String password}) async {
  Map req = {
    'first_name': firstName.validate(),
    'last_name': lastName.validate(),
    'user_login': userLogin.validate(),
    'user_email': userEmail.validate(),
    'user_pass': password.validate(),
  };
  Response response = await buildHttpResponse(
      'mightyblogger/api/v1/auth/registeration',
      request: req,
      method: HttpMethod.POST);

  if (!response.statusCode.isSuccessful()) {
    if (response.body.isJson()) {
      var json = jsonDecode(response.body);

      if (json.containsKey('code') &&
          json['code'].toString().contains('invalid_username')) {
        throw 'invalid_username';
      }
    }
  }

  return await handleResponse(response).then((json) async {
    RegistrationResponse loginResponse = RegistrationResponse.fromJson(json);
    Map<String, dynamic> req = {
      'username': userEmail.validate(),
      'password': password.validate(),
    };
    return await logInApi(req).then((value) async {
      return loginResponse;
    }).catchError((e) {
      throw e.toString();
    });
  }).catchError((e) {
    log(e.toString());
    throw e.toString();
  });
}

Future<LoginResponse> logInApi(request, {bool isSocialLogin = false}) async {
  setValue(isSocial, isSocialLogin);
  Response response = await buildHttpResponse(
      isSocialLogin
          ? 'mightyblogger/api/v1/auth/social-login'
          : 'jwt-auth/v1/token',
      request: request,
      method: HttpMethod.POST);
  if (!response.statusCode.isSuccessful()) {
    if (response.body.isJson()) {
      var json = jsonDecode(response.body);

      if (json.containsKey('code') &&
          json['code'].toString().contains('invalid_username')) {
        throw 'invalid_username';
      }
    }
  }

  return await handleResponse(response).then((value) async {
    LoginResponse loginResponse = LoginResponse.fromJson(value);

    await userStore.setToken(loginResponse.token.validate());
    await userStore.setUserID(loginResponse.userId.validate());
    await userStore.setUserEmail(loginResponse.userEmail.validate());
    await userStore.setFirstName(loginResponse.firstName.validate());
    await userStore.setLastName(loginResponse.lastName.validate());
    await userStore.setUserName(loginResponse.userDisplayName.validate());
    if (request['mb_login_type'] == LoginTypeGoogle) {
      await userStore.setUserImage(request['photoURL']);
    } else {
      await userStore
          .setUserImage(loginResponse.mbloggerProfileImage.validate());
    }
    if (request['password'] != null)
      await userStore.setUserPassword(request['password']);
    await setValue(isRemember, getBoolAsync(isRemember));

    String bookMarkList;
    if (!getStringAsync(BOOKMARK_LIST).isEmptyOrNull) {
      bookMarkList = getStringAsync(BOOKMARK_LIST);
      bookMarkStore.getBookMarkItem(page: 1);
      bookMarkStore.addAllBookMarkItem(jsonDecode(bookMarkList)
          .map<DefaultPostResponse>((e) => DefaultPostResponse.fromJson(e))
          .toList());
    }
    await userStore.setLogin(true);
    return loginResponse;
  });
}

void logout(BuildContext context, {isDemo = false}) async {
  userStore.setLogin(false);

  userStore.setToken('');
  userStore.setUserID(0);
  if (getBoolAsync(isSocial) ||
      !getBoolAsync(isRemember) ||
      getBoolAsync(isOtp)) {
    userStore.setUserEmail("");
    userStore.setUserPassword("");
  }
  userStore.setFirstName('');
  userStore.setLastName('');
  userStore.setUserName('');
  userStore.setUserImage('');
  setValue(isOtp, false);

  bookMarkStore.bookMarkPost.clear();
  bookMarkStore.clearBookMark();
  finish(context);
  if (isDemo == true) {
    DashboardScreen().launch(context);
  }
}

Future<ForgotPasswordResponse> forgotPassword(Map req) async {
  return ForgotPasswordResponse.fromJson(await handleResponse(
      await buildHttpResponse('mightyblogger/api/v1/user/forgot-password',
          request: req, method: HttpMethod.POST)));
}

Future<ForgotPasswordResponse> changePassword(Map req) async {
  return ForgotPasswordResponse.fromJson(await handleResponse(
      await buildHttpResponse('mightyblogger/api/v1/user/change-password',
          request: req, method: HttpMethod.POST)));
}

Future<bool?> updateProfile(
    {String? firstName,
    String? lastName,
    File? file,
    String? toastMessage,
    bool showToast = true}) async {
  var multiPartRequest = MultipartRequest('POST',
      Uri.parse('$mDomainUrl${'mightyblogger/api/v1/user/update-profile'}'));

  multiPartRequest.fields['first_name'] = firstName ?? userStore.fName;
  multiPartRequest.fields['last_name'] = lastName ?? userStore.lName;
  if (file != null)
    multiPartRequest.files
        .add(await MultipartFile.fromPath('profile_image', file.path));
  multiPartRequest.headers.addAll(buildHeaderTokens());
  Response response = await Response.fromStream(await multiPartRequest.send());
  log(response.body);

  if (response.statusCode.isSuccessful()) {
    Map<String, dynamic> res = jsonDecode(response.body);
    LoginResponse data = LoginResponse.fromJson(res);
    log("data.toString(");
    await userStore.setFirstName(data.firstName.validate());
    await userStore.setLastName(data.lastName.validate());

    if (data.mbloggerProfileImage != null) {
      await userStore.setUserImage(data.mbloggerProfileImage.validate());
    }
    if (showToast) toast(toastMessage ?? 'Profile updated successfully');

    return true;
  } else {
    toast(errorSomethingWentWrong);
    return false;
  }
}

Future<LoginResponse> viewProfile() async {
  return LoginResponse.fromJson(await (handleResponse(
      await buildHttpResponse('mightyblogger/api/v1/user/view-profile'))));
}

// Start Dashboard region
Future<AppConfigurationResponse> getAppConfiguration() async {
  var it = await handleResponse(await buildHttpResponse(
      'mightyblogger/api/v1/blogger/get-configuration',
      method: HttpMethod.GET));
  return AppConfigurationResponse.fromJson(it);
}

Future<DefaultResponse> getDefaultDashboard() async {
  List<int> data = [];
  List<String>? mRight = getStringListAsync(chooseTopicList);
  mRight?.forEach((element) {
    data.add(element.toInt());
  });
  var mRequest = {"category": data};
  var it = await handleResponse(await buildHttpResponse(
      'mightyblogger/api/v1/blogger/get-dashboard',
      request: mRequest,
      method: HttpMethod.POST));
  return DefaultResponse.fromJson(it);
}

Future<List<CustomDashboardResponse>> getCustomDashboard() async {
  Iterable it = (await (handleResponse(await buildHttpResponse(
      'mightyblogger/api/v1/blogger/get-custom-dashboard'))));
  return it.map((e) => CustomDashboardResponse.fromJson(e)).toList();
}

// End region

Future<BookmarkListResponse> getBookMark(int page) async {
  var it = await (handleResponse(await buildHttpResponse(
      "mightyblogger/api/v1/bookmark/get-list?posts_per_page=-1&paged=$page")));
  return BookmarkListResponse.fromJson(it);
}

Future addBookMark(Map request) async {
  return handleResponse(await buildHttpResponse(
      'mightyblogger/api/v1/bookmark/add',
      request: request,
      method: HttpMethod.POST));
}

Future<ForgotPasswordResponse> removeBookMark(Map request) async {
  return ForgotPasswordResponse.fromJson(await (handleResponse(
      await buildHttpResponse('mightyblogger/api/v1/bookmark/delete',
          request: request, method: HttpMethod.POST))));
}

Future<BlogDetailResponse> getBlogDetail(int id) async {
  return BlogDetailResponse.fromJson(await (handleResponse(
      await buildHttpResponse(
          'mightyblogger/api/v1/post/get-post-details?post_id=$id',
          method: HttpMethod.GET))));
}

Future<LikeDislikeResponse> likeDislikeApi(Map request) async {
  return LikeDislikeResponse.fromJson(await handleResponse(
      await buildHttpResponse('mightyblogger/api/v1/blogger/add-like-unlike',
          request: request, method: HttpMethod.POST)));
}

Future<ForgotPasswordResponse> addComment(Map request) async {
  return ForgotPasswordResponse.fromJson(await (handleResponse(
      await buildHttpResponse('mightyblogger/api/v1/blogger/post-comment',
          request: request, method: HttpMethod.POST))));
}

Future<List<CommentResponse>> getCommentList(int? id) async {
  Iterable res = await (handleResponse(
      await buildHttpResponse('wp/v2/comments?post=$id')));
  return res.map((e) => CommentResponse.fromJson(e)).toList();
}

Future<ForgotPasswordResponse> removeComment(Map request) async {
  return ForgotPasswordResponse.fromJson(await handleResponse(
      await buildHttpResponse("mightyblogger/api/v1/blogger/delete-comment",
          request: request, method: HttpMethod.POST)));
}

Future<List<CategoryResponse>> getCategory(parent) async {
  Iterable it = await (handleResponse(await buildHttpResponse(
      'mightyblogger/api/v1/post/get-category?parent=${parent ?? 0}')));
  return it.map((e) => CategoryResponse.fromJson(e)).toList();
}

Future<BookmarkListResponse> blogFilterApi(int page,
    {String? filter,
    var cat,
    int? authId,
    String? searchText,
    int? tagId}) async {
  if (searchText.isEmptyOrNull)
    return BookmarkListResponse.fromJson(
      await (handleResponse(
        await buildHttpResponse(
          'mightyblogger/api/v1/post/get-blog-by-filter?filter=$filter&posts_per_page=$postsPerPage&category=$cat&$tagId&paged=$page&author_ids=$authId',
          method: HttpMethod.GET,
        ),
      )),
    );
  else
    return BookmarkListResponse.fromJson(
      await (handleResponse(
        await buildHttpResponse(
          'mightyblogger/api/v1/post/get-blog-by-filter?text=$searchText&posts_per_page=$postsPerPage',
          method: HttpMethod.GET,
        ),
      )),
    );
}

Future<CustomDashboardResponse> customViewAllApi(int? id) async {
  return CustomDashboardResponse.fromJson(await (handleResponse(
      await buildHttpResponse(
          "mightyblogger/api/v1/blogger/get-custom-dashboard-view-all?slider_id=$id",
          method: HttpMethod.GET))));
}
