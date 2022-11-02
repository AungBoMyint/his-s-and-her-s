import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzn/bottom_nav/bottombar.dart';
import 'package:kzn/providers/blog_provider.dart';
import 'package:kzn/providers/course_provider.dart';
import 'package:kzn/providers/subscription_provider.dart';
import 'package:kzn/providers/user_provider.dart';
import 'package:kzn/ui/routes/about_route.dart';
import 'package:kzn/ui/routes/course_route.dart';
import 'package:kzn/ui/routes/login_route.dart';
import 'package:kzn/ui/routes/main_route.dart';
import 'package:kzn/ui/routes/privacy-policy.dart';
import 'package:kzn/ui/routes/subscription_check_route.dart';
import 'package:kzn/ui/routes/subscription_route.dart';
import 'package:kzn/ui/routes/tnc_route.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'blog/model/DefaultPostResponse.dart';
import 'blog/screen/SplashScreen.dart';
import 'blog/store/BookMarkStore/BookMarkStore.dart';
import 'blog/store/DashboardStore/DashboardStore.dart';
import 'blog/store/PostDetailStore/PostDetailStore.dart';
import 'blog/store/UserStore/UserStore.dart';
import 'blog/store/app_store.dart';
import 'blog/utils/AppCommon.dart';
import 'blog/utils/AppConstant.dart';
import 'blog/utils/Extensions/Constants.dart';
import 'blog/utils/Extensions/device_extensions.dart';
import 'blog/utils/Extensions/shared_pref.dart';
import 'controller/main_controller.dart';
import 'ui/routes/enroll_form_route.dart';
import 'package:translator/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AppStore appStore = AppStore();
UserStore userStore = UserStore();
PostDetailStore postDetailStore = PostDetailStore();
DashboardStore dashboardStore = DashboardStore();
BookMarkStore bookMarkStore = BookMarkStore();
Timer? rewardTimer;
int passwordLengthGlobal = 6;
final navigatorKey = GlobalKey<NavigatorState>();
final GoogleTranslator translator = GoogleTranslator();
late SharedPreferences sharedPreferences;

Future<void> initialize({
  double? defaultDialogBorderRadius,
  String? defaultLanguage,
}) async {
  sharedPreferences = await SharedPreferences.getInstance();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } on FirebaseException catch (e) {
    log("***FirebaseError: $e");
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  sharedPreferences = await SharedPreferences.getInstance();

  await setValue(baseURL, mDomainUrl);

  if (isMobile) {
    await OneSignal.shared.setAppId(mOneSignalAppId);
    OneSignal.shared.consentGranted(true);
    OneSignal.shared.promptUserForPushNotificationPermission();
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });
    final status = await OneSignal.shared.getDeviceState();
    print(status!.userId);
  }

  if (getBoolAsync(IS_FREE_TRIAL_START)) {
    appStore.setSurveyStatus();
    await setValue(IS_SURVEY, true);
    startTimer();
  }

/*   await initialize(aLocaleLanguageList: languageList());
 */
  defaultSetting();
  // appStore.setLanguage(getStringAsync(sharedPref.selectedLanguage, defaultValue: defaultValues.defaultLanguage));
  appStore.setLanguage(DEFAULT_LANGUAGE);

  setLogInValue();
  if (!isWeb) {
    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == appThemeMode.themeModeLight) {
      appStore.setDarkMode(false);
    } else if (themeModeIndex == appThemeMode.themeModeDark) {
      appStore.setDarkMode(true);
    }
  }
  String bookMarkList = getStringAsync(BOOKMARK_LIST);
  if (bookMarkList.isNotEmpty) {
    bookMarkStore.addAllBookMarkItem(jsonDecode(bookMarkList)
        .map<DefaultPostResponse>((e) => DefaultPostResponse.fromJson(e))
        .toList());
  }
/*   fontSize = fontSizes.firstWhere((element) => element.fontSize == getIntAsync(fontSizePref, defaultValue: 16));
 */
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => CourseProvider()),
    ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
    ChangeNotifierProvider(create: (_) => BlogProvider()),
    // ChangeNotifierProvider(create: (_) => VlogProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MainController()); //Make Globle,
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fashion Illustration by His's and Her's",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        /* initialRoute: MainRoute.routeName, */
        routes: {
          MainRoute.routeName: (context) => BottomBar(),
          LoginRoute.routeName: (context) => LoginRoute(),
          SubscriptionRoute.routeName: (context) => SubscriptionRoute(),
          CourseRoute.routeName: (context) => CourseRoute(),
          AboutRoute.routeName: (context) => AboutRoute(),
          TnCRoute.routeName: (context) => TnCRoute(),
          EnrollFormRoute.routeName: (context) => EnrollFormRoute(),
          PrivacyPolicyRoute.routeName: (context) => PrivacyPolicyRoute(),
          SubscriptionCheckRoute.routeName: (context) =>
              SubscriptionCheckRoute()
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
