// import 'dart:convert';
//
// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
//
// class VlogProvider extends ChangeNotifier {
//   BetterPlayerController betterPlayerController;
//
//   VlogProvider() {
//     setInitialInitialPlayer();
//   }
//
//   void initBetterPlayerController() {
//     setInitialInitialPlayer();
//   }
//
//   String vlogVideoUrl =
//       "https://kzn.fra1.cdn.digitaloceanspaces.com/His_&_Her/Video/Simple%20Runway%20Sketch%20Design.mp4";
//
//   Future<dynamic> listURL;
//
//   Future<void> fetchVlogList() async {
//     print("fetchVlogList");
//
//     var body = {"type": "get"};
//     final response = await http
//         .post(Uri.parse("http://52.4.33.124/vlog/vlog.php"), body: body);
//     print("vlog response");
//     print(response);
//     listURL = Future.delayed(Duration.zero, () {
//       //String jsonStr ='[{"url":"https://kzn.fra1.cdn.digitaloceanspaces.com/His_&_Her/Video/Simple%20Runway%20Sketch%20Design.mp4","name":"Dynamic Video 1"}]';
//       //return jsonDecode(jsonStr);
//       return jsonDecode(response.body);
//       //List<dynamic>  data = [{"url":"https://kzn.fra1.cdn.digitaloceanspaces.com/His_&_Her/Video/Simple%20Runway%20Sketch%20Design.mp4","name":"Simple Runway Sketch Design"}];
//       //return data;
//     });
//     //notifyListeners();
//   }
//
//   void setDataSource(String url, bool notify) {
//     betterPlayerController.setupDataSource(
//       BetterPlayerDataSource(BetterPlayerDataSourceType.network, url),
//     );
//     notify ? notifyListeners() : null;
//   }
//
//   void setInitialInitialPlayer() {
//     betterPlayerController = BetterPlayerController(BetterPlayerConfiguration(
//       autoPlay: true,
//       looping: true,
//       fullScreenByDefault: false,
//     ));
//   }
// }
