// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:kzn/providers/vlog_provider.dart';
// import 'package:provider/provider.dart';
//
// class Vlogs extends HookWidget {
//   const Vlogs({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //final provider = Provider.of<VlogProvider>(context);
//     //First we only need to fetch remote data once like init state
//     Future<dynamic> fetch() =>
//         Provider.of<VlogProvider>(context, listen: false).listURL;
//     Provider.of<VlogProvider>(context, listen: false)
//         .initBetterPlayerController();
//     Provider.of<VlogProvider>(context, listen: false).setDataSource(
//         "https://kzn.fra1.cdn.digitaloceanspaces.com/His_&_Her/Video/Simple%20Runway%20Sketch%20Design.mp4",
//         false);
//     //And we need only init better player once
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         title: Center(
//           child: Text("His's and Her's Vlog",
//               style: TextStyle(fontSize: 16.0, color: Colors.black)),
//         ),
//       ),
//       body: FutureBuilder(
//         future: fetch(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final dataList = snapshot.data;
//             return SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   children: [
//                     //First Initial Video
//                     Consumer<VlogProvider>(
//                       builder: (_, provider, widget) {
//                         return Container(
//                           width: double.infinity,
//                           child: Center(
//                               child: BetterPlayer(
//                             controller: provider.betterPlayerController,
//                           )),
//                         );
//                       },
//                     ),
//                     //ListView from remote
//
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.5,
//                       width: MediaQuery.of(context).size.width,
//                       child: ListView.separated(
//                         primary: false,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                               onTap: () {
//                                 //DO SOMETHING
//                                 Provider.of<VlogProvider>(context,
//                                         listen: false)
//                                     .setDataSource(
//                                   dataList[index]["url"],
//                                   true,
//                                 );
//                               },
//                               child: Card(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       bottom: 20, top: 10, left: 10, right: 20),
//                                   child: Text(dataList[index]["name"]),
//                                 ),
//                               ));
//                         },
//                         separatorBuilder: (context, index) {
//                           return SizedBox(
//                             height: 10,
//                           );
//                         },
//                         itemCount: dataList.length,
//                       ),
//                     )
//                   ],
//                 ));
//           } else {
//             return Center(
//                 child: SizedBox(
//               height: 50,
//               width: 50,
//               child: CircularProgressIndicator(),
//             ));
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Vlog extends StatefulWidget {
  @override
  _VlogState createState() => _VlogState();
}

class _VlogState extends State<Vlog> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        key: webViewKey,
        onEnterFullscreen: (controller) {
          AutoOrientation.landscapeAutoMode();
        },
        initialUrlRequest:
            URLRequest(url: Uri.parse("https://hisandhermyanmar-95b62f.ingress-erytho.ewp.live/hiss-and-hers-knowledge-vlogs/")),
        initialOptions: options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        // onLoadStart: (controller, url) {
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },

        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
      ),
    );
  }
}
