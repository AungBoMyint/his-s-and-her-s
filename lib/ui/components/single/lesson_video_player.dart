import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:kzn/data/models/lesson.dart';
import 'package:kzn/providers/course_provider.dart';
import 'package:provider/provider.dart';

class LessonVideoPlayer extends StatefulWidget {
  @override
  _LessonVideoPlayerState createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends State<LessonVideoPlayer> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          fullScreenByDefault: false,
        )
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _betterPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 225,
      child: _videoPlayerFuture(),
    );
  }

  Widget _videoPlayerFuture(){
    return FutureBuilder(
        future: Provider
            .of<CourseProvider>(context, listen: true)
            .lesson,
        builder: (BuildContext context, AsyncSnapshot<Lesson> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null){
              return Container(
                child: Center(child: Text('no lesson')),);
            }
            else{
             // print("video url is ${snapshot.data.videoUrl}");
              BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
                  BetterPlayerDataSourceType.network,
                  snapshot.data!.videoUrl
              );
              _betterPlayerController.setupDataSource(betterPlayerDataSource);
              return  _videoPlayer();
            }
          }
          else if (snapshot.hasError) {
            //_refreshController.refreshCompleted();
            return Container(
              child: Center(
                child: Text('error ${snapshot.error.toString()}')),);
          }
          else {
            //_refreshController.refreshCompleted();
            return Container(
              child: Center(child: Text('loading lesson...')),);
          }
        }
    );
  }

  Widget _videoPlayer(){
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }
}
