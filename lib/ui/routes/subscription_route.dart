import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'enroll_form_route.dart';

class SubscriptionRoute extends StatefulWidget {
  static const routeName = '/subscription_route';
  @override
  _SubscriptionRouteState createState() => _SubscriptionRouteState();
}

class _SubscriptionRouteState extends State<SubscriptionRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.pinkAccent),
        backgroundColor: Colors.white,
        title: Text("သင်တန်းအပ်ရန်", style: TextStyle(fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: Colors.pinkAccent
        )),),
      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage('assets/images/appicon.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    icon: Icon(Icons.school_outlined, color: Colors.pinkAccent),
                    label: Text(
                      'Enroll Now',
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent),
                    ),
                    onPressed: () {
                      Get.toNamed(EnrollFormRoute.routeName);
                      //Get.pushNamed(context, EnrollFormRoute.routeName);
                    },
                  ),
                  SizedBox(width: 50),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    icon: Icon(Icons.phone_outlined, color: Colors.pinkAccent),
                    label: Text(
                      'Contact Us',
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent),
                    ),
                    onPressed: () => launch("tel://09969545215"),
                  ),
                ],
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Center(child: Text('''ယခု သင်တန်း၏ သင်ခန်းစာများ လေ့လာနိုင်ရန် 
  Enroll Now ကို နှိပ်ပြီး သင်တန်း အပ်နိုင်သလို 
      Contact Us ကို နှိပ်ပြီး သိရှိလိုသမျှကို 
                   မေးမြန်းနိုင်ပါတယ်ရှင်''',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
          ),
        ],
      ),



      // floatingActionButton: AppFab(),
    );
  }
}

