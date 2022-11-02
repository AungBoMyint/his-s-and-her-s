const appName = "His's and Her's Fashion"; //Your AppName

//Add your BaseURL
const baseUrl =
    'https://hisandher.info'; //NOTE: Do not end base url with Slash (/)
const mDomainUrl = '$baseUrl/wp-json/';

//Urls
const termsCondition = "https://www.google.com/";
const privacyPolicy = "https://www.google.com/";

//OneSignalId
const mOneSignalAppId = "38988bd2-0d63-4b24-be31-4e157bbcd1c5";

//AdmobId
const adMobBannerId = "ca-app-pub-3940256099942544/6300978111";
const adMobInterstitialId = "ca-app-pub-3940256099942544/1033173712";
const adMobBannerIdIos = "ca-app-pub-3940256099942544/2934735716";
const adMobInterstitialIdIos = "ca-app-pub-3940256099942544/4411468910";

// Facebook
const fbBannerId = "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047";
const fbBannerIdIos = "";
const fbInterstitialId =
    "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617";
const fbInterstitialIdIos = "";

const surveyAndroid = "c33e3f0e-b8de-4196-a9d3-56c5bccb4f92";
const surveyIOS = "2778aa54-402a-4de7-b6e6-577d6aca40b3";

String isGoogleAds = "admob";
String isFacebookAds = "facebook";

class DefaultValues {
  final String defaultLanguage = "en";
}

DefaultValues defaultValues = DefaultValues();

const LoginTypeApp = 'app';
const LoginTypeGoogle = 'google';
const LoginTypeOTP = 'otp';
const LoginTypeApple = 'apple';

bool isAppleLoginEnable = true;

class AppThemeMode {
  final int themeModeLight = 1;
  final int themeModeDark = 2;
  final int themeModeSystem = 0;
}

AppThemeMode appThemeMode = AppThemeMode();

final String isFirstTime = "isFirstTime";
final String userPassword = "userPassword";
final String userPhotoUrl = "userPhotoUrl";
final String uId = "userId";
final String isLogIn = "isLoggedIn";
final String firstName = "firstName";
final String lastName = "lastName";
final String userEmail = "userEmail";
final String userName = "userName";
final String apiToken = "apiToken";
final String isRemember = "isRemember";
final String isSocial = "isSocial";
final String isOtp = "isOtp";
final String searchList = 'searchList';
final String chooseTopicList = 'chooseTopicList';
final String baseURL = 'baseUrl';
const notificationOn = 'notificationOn';
const fontSizePref = "FontSizePref";

/* Video Type */
const VideoTypeCustom = 'custom_url';
const VideoTypeYouTube = 'youtube';
const VideoTypeIFrame = 'iframe';

const postVideoType = 'bloggervideo';
const postType = 'post';
const postCategoryType = 'category';

const gridCardType = 'grid';
const listCardType = 'list';

const postsPerPage = 6;

const BOOKMARK_LIST = 'bookMarkList';

// Dashboard Type configuration
const DEFAULT = "blog";
const FASHION = "fashion";
const FOOD = "food";
const TRAVEL = "travel";
const MUSIC = "music";
const LIFESTYLE = "lifestyle";
const FITNESS = "fitness";
const DIY = "diy";
const SPORTS = "sports";
const FINANCE = "finance";
const PERSONAL = "personal";
const NEWS = "news";

const FREE_TRIAL_DURATION = 'FREE_TRIAL_DURATION';
const FREE_TRIAL_TOTAL_DURATION = 'FREE_TRIAL_TOTAL_DURATION';
const IS_FREE_TRIAL_START = 'IS_FREE_TRIAL_START';
const IS_HOUR_START = 'IS_FREE_TRIAL_START';
const IS_SURVEY = 'IS_SURVEY';

const DETAIL_PAGE_VARIANT = 'DetailPageVariant';
const PAGE_VARIANT = 'PAGE_VARIANT';

const bool enableMultipleDemo = true;
