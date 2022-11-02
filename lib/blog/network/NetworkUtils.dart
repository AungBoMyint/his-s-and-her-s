import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/network_utils.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/shared_pref.dart';

Map<String, String> buildHeaderTokens({bool print = true}) {
  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    HttpHeaders.cacheControlHeader: 'no-cache',
    HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
  };

  if (userStore.isLoggedIn) {
    header.putIfAbsent(
        HttpHeaders.authorizationHeader, () => 'Bearer ${userStore.token}');
  }
  if (print) log(jsonEncode(header));
  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  var mDomainURL;
  if (getStringAsync(baseURL).isEmpty) {
    mDomainURL = mDomainUrl;
  } else {
    mDomainURL = getStringAsync(baseURL);
  }

  if (!endPoint.startsWith('https')) url = Uri.parse('$mDomainURL$endPoint');

  log('URL: ${mDomainURL + endPoint}');

  return url;
}

Future<Response> buildHttpResponse(String endPoint,
    {HttpMethod method = HttpMethod.GET, Map? request}) async {
  if (await isNetworkAvailable()) {
    var headers = buildHeaderTokens();
    Uri url = buildBaseUrl(endPoint);

    Response response;

    if (method == HttpMethod.POST) {
      log('Request: ${jsonEncode(request)}');

      response =
          await http.post(url, body: jsonEncode(request), headers: headers);
    } else if (method == HttpMethod.DELETE) {
      response = await delete(url, headers: headers);
    } else if (method == HttpMethod.PUT) {
      response = await put(url, body: jsonEncode(request), headers: headers);
    } else {
      response = await get(url, headers: headers);
    }

    log('Response ($method): ${response.statusCode} ${response.body.trim()}');
    return response;
  } else {
    throw errorInternetNotAvailable;
  }
}

Future handleResponse(Response response, [bool? avoidTokenError]) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }

  // if (response.statusCode == 401) {
  //   if (userStore.isLoggedIn) {
  //     Map<String, dynamic> req = {
  //       'username': userStore.userEmail,
  //       'password': userStore.userPassword,
  //     };
  //
  //     await authApi.logInApi(req).then((value) {
  //       throw 'Please try again.';
  //     }).catchError((e) {
  //       throw TokenException(e);
  //     });
  //   } else {
  //     throw '';
  //   }
  // }

  if (response.statusCode.isSuccessful()) {
    return jsonDecode(response.body);
  } else {
    try {
      var body = jsonDecode(response.body);
      //  throw errorSomethingWentWrong;
      throw parseHtmlString(body['message']);
    } on Exception catch (e) {
      log(e);
      throw errorSomethingWentWrong;
    }
  }
}

//region Common
enum HttpMethod { GET, POST, DELETE, PUT }

class TokenException implements Exception {
  final String message;

  const TokenException([this.message = ""]);

  String toString() => "Token Exception: $message";
}
//endregion
