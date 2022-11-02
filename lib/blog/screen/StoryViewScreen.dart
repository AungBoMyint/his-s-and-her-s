import 'package:flutter/material.dart';
import '../model/DefaultPostResponse.dart';
import 'package:story_view/controller/story_controller.dart';
import '../utils/Extensions/string_extensions.dart';
import 'package:story_view/widgets/story_view.dart';

import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Widget_extensions.dart';

class StoryViewScreen extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  StoryViewScreen({this.list});

  @override
  _StoryViewScreenState createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  final StoryController controller = StoryController();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: widget.list!.isNotEmpty
            ? GestureDetector(
                onTapDown: (v) {
                  controller.pause();
                },
                onTapUp: (v) {
                  controller.play();
                },
                child: StoryView(
                  controller: controller,
                  inline: true,
                  repeat: false,
                  onComplete: () {
                    finish(context);
                  },
                  onStoryShow: (v) {
                    log(v);
                  },
                  storyItems: widget.list!.map((e) {
                    return StoryItem.inlineImage(
                      url: e.image.validate(),
                      imageFit: BoxFit.fitWidth,
                      controller: controller,
                      duration: Duration(seconds: 5),
                      roundedBottom: false,
                      roundedTop: false,
                      caption: Text(parseHtmlString(e.postTitle),
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.black54,
                              fontSize: 17),
                          textAlign: TextAlign.center),
                    );
                  }).toList(),
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
