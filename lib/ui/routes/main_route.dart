import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kzn/data/constant.dart';
import 'package:kzn/data/models/course.dart';
import 'package:kzn/providers/blog_provider.dart';
import 'package:kzn/providers/course_provider.dart';
import 'package:kzn/ui/components/combine/app_drawer.dart';
import 'package:kzn/ui/components/combine/course_list.dart';
import 'package:kzn/ui/components/combine/intro_slider.dart';
import 'package:kzn/utils/open_facebook.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../consultant_appointant/controller/home_controller.dart';
import '../../consultant_appointant/screen/view/home.dart';

class MainRoute extends StatefulWidget {
  static const routeName = '/main_route';

  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<CourseProvider>(context, listen: false)
        .getCourseListForOneTime();





    //Provider.of<UserProvider>(context,listen: false).login(username: "admin", password: "admin");
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text("His's and Her's Learning",
                style: TextStyle(fontSize: 16, color: Colors.black,
                  letterSpacing: 1,
                  wordSpacing: 2,
                )),
            actions: [

              SizedBox(
                width: 90,
                child: ElevatedButton(
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    elevation: MaterialStateProperty.resolveWith<double>(
                      // As you said you dont need elevation. I'm returning 0 in both case
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return 0;
                        }
                        return 0; // Defer to the widget's default.
                      },
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await launch('https://m.me/hisandhermyanmar');
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.facebookMessenger,
                    color: Colors.blue,
                    size: 23,
                  ),
                ),
              ),
            ]),

        body: Column(
          children: [
            IntroSlider(
              photos: introSliderImages,
            ),
            Expanded(child: _courseListFutureBuilder()),
          ],
        ),

        drawer: AppDrawer(),
        // floatingActionButton: AppFab(),
      ),
    );
  }

  // 1 Course List Future Builder
  Widget _courseListFutureBuilder() {
    return FutureBuilder(
        future: Provider.of<CourseProvider>(context, listen: true).courseList,
        builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return HomeView();
            } else {
              return CourseList(courses: snapshot.data!);
            }
          } else if (snapshot.hasError) {
            //_refreshController.refreshCompleted();
            return Container(
              child: Center(child: Text('error ${snapshot.error.toString()}')),
            );
          } else {
            //_refreshController.refreshCompleted();
            return Container(
              child: Center(child: Text("His's and Her's Fashion & Design School")),
            );
          }
        });
  }
}
