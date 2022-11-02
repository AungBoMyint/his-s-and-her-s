// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class Videolink extends StatefulWidget{
//
//   final String url;
//
//   const Videolink({Key key, this.url}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return VideolinkState();
//   }
//
// }
// class VideolinkState extends State<Videolink>{
//   VideoPlayerController _videoPlayerController;
//
//   BetterPlayerController _betterPlayerController;
//
//
//   @override
//   void initState() {
//     super.initState();
//     //_videoPlayerController = VideoPlayerController.network(widget.url)..initialize();
//     _betterPlayerController = BetterPlayerController(
//         BetterPlayerConfiguration(
//           autoPlay: true,
//           looping: true,
//           fullScreenByDefault: false,
//         )
//     );
//     BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         widget.url
//     );
//     _betterPlayerController.setupDataSource(betterPlayerDataSource);
//     print(widget.url);
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _betterPlayerController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   void didUpdateWidget(covariant Videolink oldWidget) {
//     // TODO: implement didUpdateWidget
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.url != widget.url) {
//       resetPlayer();
//     }
//   }
//
//   void resetPlayer() {
//     _videoPlayerController.dispose();
//     _videoPlayerController = VideoPlayerController.network(widget.url)..initialize();
//     _videoPlayerController.play();
//   }
//
//
//   void initPlayer() async {
//     /// initialise player
//   }
//
//   void disposePlayer() {
//     /// dispose player
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: Colors.black),
//           backgroundColor: Colors.white,
//           title: Center(
//             child: Text("His's and Her's Vlog", style: TextStyle(fontSize: 16.0,
//                 color: Colors.black
//             )),
//           ),
//
//         ),
//       body:
//       Container(
//
//         width:  double.infinity,
//         child: Center(
//           child: BetterPlayer(
//
//             controller: _betterPlayerController,
//           )
//           // child: VideoPlayer(_videoPlayerController),
//         ),
//       ),
//     );
//
//   }
// }