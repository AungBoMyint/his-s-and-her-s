import 'package:flutter/material.dart';
import '../component/VideoFileWidget.dart';
import '../component/YouTubeEmbedWidget.dart';
import '../utils/AppConstant.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/string_extensions.dart';

class VideoPlayDialog extends StatefulWidget {
  static String tag = '/VideoPlayDialog';
  final String videoType;
  final String videoURL;

  VideoPlayDialog(this.videoType, this.videoURL);

  @override
  VideoPlayDialogState createState() => VideoPlayDialogState();
}

class VideoPlayDialogState extends State<VideoPlayDialog> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: appBarWidget("",
          showBack: true, textColor: Colors.white, elevation: 0),
      body: widget.videoType == VideoTypeYouTube
          ? YouTubeEmbedWidget(widget.videoURL.convertYouTubeUrlToId()).center()
          : widget.videoType.validate() == VideoTypeIFrame
              ? YouTubeEmbedWidget(widget.videoURL.validate(), fullIFrame: true)
                  .center()
              : widget.videoType.validate() == VideoTypeCustom
                  ? VideoFileWidget(widget.videoURL.validate()).center()
                  : Container(child: Text('Invalid video').center()),
    );
  }
}
