import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import '../../../main.dart';
import '../../utils/AppCommon.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Colors.dart';
import 'Constants.dart';
import 'decorations.dart';

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

get getContext => navigatorKey.currentState?.overlay?.context;
void finish(BuildContext context, [Object? result]) {
  if (Navigator.canPop(context)) Navigator.pop(context, result);
}

/// Hide soft keyboard
void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

/// Default AppBar
AppBar appBarWidget(
  String title, {
  @Deprecated('Use titleWidget instead') Widget? child,
  Widget? titleWidget,
  List<Widget>? actions,
  Color? color,
  bool center = false,
  Color? textColor,
  int textSize = 20,
  bool showBack = true,
  Color? shadowColor,
  double? elevation,
  Widget? backWidget,
  Brightness? brightness,
  SystemUiOverlayStyle? systemUiOverlayStyle,
  TextStyle? titleTextStyle,
  PreferredSizeWidget? bottom,
  Widget? flexibleSpace,
}) {
  return AppBar(
    centerTitle: center,
    title: titleWidget ??
        Text(
          title,
          style: titleTextStyle ??
              (boldTextStyle(
                  color: textColor ?? textPrimaryColorGlobal, size: textSize)),
        ),
    actions: actions,
    automaticallyImplyLeading: showBack,
    backgroundColor: color ?? appBarBackgroundColorGlobal,
    leading: showBack
        ? (backWidget ?? BackButton(color: textColor ?? textPrimaryColorGlobal))
        : null,
    shadowColor: shadowColor,
    elevation: elevation ?? defaultAppBarElevation,
    systemOverlayStyle: systemUiOverlayStyle,
    bottom: bottom,
    flexibleSpace: flexibleSpace,
  );
}

/// Custom scroll behaviour widget
class SBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

String parseHtmlStringWidget(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

AppBar customAppBarWidget(
  String title, {
  @Deprecated('Use titleWidget instead') Widget? child,
  Widget? titleWidget,
  List<Widget>? actions,
  Color? color,
  bool center = false,
  Color? textColor,
  int textSize = 20,
  bool showBack = true,
  Color? shadowColor,
  double? elevation,
  Widget? backWidget,
  Brightness? brightness,
  SystemUiOverlayStyle? systemUiOverlayStyle,
  TextStyle? titleTextStyle,
  PreferredSizeWidget? bottom,
  Widget? flexibleSpace,
}) {
  return AppBar(
    centerTitle: center,
    title: titleWidget ??
        Text(
          title,
          style: titleTextStyle ??
              (boldTextStyle(
                  color: textColor ?? textPrimaryColorGlobal, size: textSize)),
        ),
    actions: actions,
    automaticallyImplyLeading: showBack,
    backgroundColor: color ?? appBarBackgroundColorGlobal,
    leading: showBack
        ? (backWidget ?? BackButton(color: textColor ?? textPrimaryColorGlobal))
        : null,
    shadowColor: shadowColor,
    elevation: elevation ?? defaultAppBarElevation,
    brightness: brightness,
    systemOverlayStyle: systemUiOverlayStyle,
    bottom: bottom,
    flexibleSpace: flexibleSpace,
  );
}

EdgeInsets dynamicAppButtonPadding(BuildContext context) {
  return EdgeInsets.symmetric(vertical: 14, horizontal: 16);
}

extension BooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool validate({bool value = false}) => this ?? value;
}

extension DoubleExtensions on double? {
  /// Validate given bool is not null and returns given value if null.
  double validate({double value = 0.0}) => this ?? value;
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

Future<void> launchUrl(String url, {bool forceWebView = false}) async {
  log(url);
  await launch(url, forceWebView: forceWebView, enableJavaScript: true)
      .catchError((e) {
    log(e);
    toast('Invalid URL: $url');
  });
}

/// Set orientation to portrait
void setOrientationPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

/// Redirect to given widget without context
Future<T?> push<T>(
  Widget widget, {
  bool isNewTask = false,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
}) async {
  if (isNewTask) {
    return await Navigator.of(getContext).pushAndRemoveUntil(
      buildPageRoute(widget, pageRouteAnimation, duration),
      (route) => false,
    );
  } else {
    return await Navigator.of(getContext).push(
      buildPageRoute(widget, pageRouteAnimation, duration),
    );
  }
}

/// Dispose current screen or close current dialog
void pop([Object? object]) {
  if (Navigator.canPop(getContext)) Navigator.pop(getContext, object);
}
