import 'package:flutter/material.dart';
import 'package:kzn/data/models/course.dart';
import 'package:kzn/providers/course_provider.dart';
import 'package:kzn/providers/subscription_provider.dart';
import 'package:kzn/providers/user_provider.dart';
import 'package:kzn/ui/routes/course_route.dart';
import 'package:kzn/ui/routes/subscription_route.dart';
import 'package:provider/provider.dart';

import 'login_route.dart';

class SubscriptionCheckRoute extends StatefulWidget {

  static const routeName = '/subscription_check_route';
  @override
  _SubscriptionCheckRouteState createState() => _SubscriptionCheckRouteState();
}

class _SubscriptionCheckRouteState extends State<SubscriptionCheckRoute> {

  void _check()async{
    // check login
    String? accessKey = Provider.of<UserProvider>(context, listen:false).accessKey;
    if(accessKey == null) {
      // need to login first
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, LoginRoute.routeName);
        return;
      });
    }
    else{
      // check subscription
      Course? course = Provider.of<CourseProvider>(context, listen:false).course;
      bool status = await Provider.of<SubscriptionProvider>(context, listen:false).checkSubscription(course!.id,accessKey);

      if(status == true){
        Navigator.pushReplacementNamed(context, CourseRoute.routeName);
      }
      else{
        Navigator.pushReplacementNamed(context, SubscriptionRoute.routeName);
      }
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
