import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:kzn/bottom_nav/bankslip.dart';
import 'package:kzn/data/models/user.dart';
import 'package:kzn/providers/user_provider.dart';
import 'package:kzn/ui/routes/enroll_form_route.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main_route.dart';

class LoginRoute extends StatefulWidget {
  static final routeName = "/login_route";

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute>
    with SingleTickerProviderStateMixin {
  String? username;
  String? password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // heading
            Container(
              child: Stack(
                children: [
                  // custom painter
                  Container(
                    //color: Colors.green,
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: AssetImage('assets/images/trlogo.png'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // login form
            Column(
              children: [
                // username input
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white)
                    ),
                    child: TextField(
                      onChanged: (String str) {
                        setState(() {
                          username = str;
                        });
                      },
                      //style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.white)
                        ),
                        disabledBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.red)
                        ),
                        hintText: 'Enter username',
                        labelText: 'Username',
                        //hintStyle: TextStyle(color: Colors.white),
                        //labelStyle: TextStyle(color: Colors.white),
                        //fillColor: Colors.white
                      ),
                    ),
                  ),
                ),
                // password input
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white)
                    ),
                    child: TextField(
                      obscureText: true,
                      onChanged: (String str) {
                        setState(() {
                          password = str;
                        });
                      },
                      //style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.white)
                        ),
                        disabledBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.red)
                        ),
                        hintText: '****',
                        labelText: 'Password',
                        //hintStyle: TextStyle(color: Colors.white),
                        //labelStyle: TextStyle(color: Colors.white),
                        //fillColor: Colors.white
                      ),
                    ),
                  ),
                ),
                // sign in button
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        print('login onTap');
                        // validate username and password
                        //if(this.username == null || username = "" || password == null || password = ""){

                        //}
                        if (username == "" ||
                            password == "" ||
                            username == null ||
                            password == null) {
                          print('invalid input value');
                          return;
                        }
                        loginAccount(
                            username: username!,
                            password: password!,
                            context: context);
                      },
                      child: Container(
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.black, Colors.black]),
                          border: Border.all(color: Colors.pink),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Center(
                            child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ),
                        ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 30),
            // don't have an account, register here
            Container(
              //height: size.height /6,
              //color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    icon: Icon(Icons.school_outlined, color: Colors.black),
                    label: Text(
                      'Enroll Now',
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
                    icon: Icon(Icons.phone_outlined, color: Colors.black),
                    label: Text(
                      'Contact Us',
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    onPressed: () => launch("tel://09794664377"),
                  ),
                ],
              ),
            ),
            // login status
          ],
        ),
      ),
    );
  }

  void forgetPassword(BuildContext context) {
    print('forgetPassword is called');
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: TextButton.icon(
        icon: Icon(Icons.phone, color: Colors.black),
        label: Text(
          'Contact Us',
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        onPressed: () => launch("tel://09794664377"),
      ),
    ));
  }

  void registerAccount(BuildContext context) {
    print('registerAccount is called');

    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: TextButton.icon(
        icon: Icon(Icons.phone, color: Colors.black),
        label: Text(
          'Enroll Now',
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        onPressed: () async {
          Navigator.pushNamed(context, EnrollFormRoute.routeName);
        },
      ),
    ));

    // Navigator.pushNamed(context, SignUpRoute.routeName);
  }

  void loginAccount(
      {required String username,
        required String password,
        required BuildContext context}) async {
    print('loginAccount is called with username $username, password $password');

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("signing in..."),
    ));
    //Navigator.pushNamedAndRemoveUntil(context, MainRoute.routeName, (route) => false);
    print("signing in START");
    User user = await Provider.of<UserProvider>(context, listen: false)
        .login(username: username, password: password);
    print("signing in END");
    print(user);
    if (user == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("❌ Login Fail ❌ "),
      ));
    } else {
      Navigator.pushReplacementNamed(context, MainRoute.routeName);
    }
  }
}

class CustomCardShapePainter extends CustomPainter {
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter({required this.startColor, required this.endColor});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double radius = 24;
    Paint paint = Paint();
    paint.shader =
        ui.Gradient.linear(Offset(0, size.height), Offset(size.width, 0), [
          //HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
          startColor,
          endColor
        ]);

    final double w = size.width;
    final double h = size.height;
    final pointOneX = -w * 0.2;
    final pointOneY = h * 0.4;

    final pointTwoX = w * 0.4;
    final pointTwoY = h * 0.5;

    final pointThreeX = w * 0.7;
    final pointThreeY = h * 0.6;

    final pointFourX = w * 0.7;
    final pointFourY = h * 0.7;

    final pointFiveX = w * 0.7;
    final pointFiveY = h * 0.9;

    final pointSixX = w * 1.0;
    final pointSixY = h * 1.0;

    Path path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(pointOneX, pointOneY, pointTwoX, pointTwoY)
      ..quadraticBezierTo(pointThreeX, pointThreeY, pointFourX, pointFourY)
      ..quadraticBezierTo(pointFiveX, pointFiveY, pointSixX, pointSixY)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
    /*
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
       */
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //throw UnimplementedError();
    return true;
  }
}

class AppLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/appicon.png'),
      fit: BoxFit.fitWidth,
    );
  }
}