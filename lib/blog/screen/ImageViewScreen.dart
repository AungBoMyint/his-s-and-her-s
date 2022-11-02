import 'package:flutter/material.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import 'package:photo_view/photo_view.dart';

import '../utils/Extensions/Commons.dart';

class ImageViewScreen extends StatefulWidget {
  final String? image;

  ImageViewScreen(this.image);

  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          PhotoView(
            imageProvider: Image.network(
              widget.image!,
              loadingBuilder: (context, child, loadingProgress) {
                return commonCacheImageWidget('');
              },
            ).image,
          ),
          IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => finish(context))
              .paddingOnly(top: context.statusBarHeight + 20),
        ],
      ),
    );
  }
}
