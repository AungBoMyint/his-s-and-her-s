import 'package:dio/dio.dart';
// import 'package:kzn/data/fcm_key.dart';

Future<void> sendPush(String title, String message) async {
  //final token = await FirebaseMessaging.instance.getToken();
  final jsonBody = <String, dynamic>{
    "notification": <String, dynamic>{
      "title": title,
      "body": message,
    },
    "data": <String, dynamic>{
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "route": "enrollment_route",
    },
    "condition": "'enrollment' in topics",
  };
  await Dio().post("https://fcm.googleapis.com/fcm/send",
      data: jsonBody,
      options: Options(headers: {
        // "Authorization": "key=$fcmKey",
        "Content-Type": "application/json"
      })
  );
}
