import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Gallery extends StatefulWidget {

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const WebView(
          initialUrl: 'https://hisandhermyanmar-95b62f.ingress-erytho.ewp.live/hiss-and-hers-gallery/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
