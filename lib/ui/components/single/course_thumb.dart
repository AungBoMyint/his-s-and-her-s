import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kzn/data/models/course.dart';
import 'package:kzn/providers/course_provider.dart';
import 'package:kzn/ui/components/single/course_thumb_img.dart';
import 'package:kzn/ui/routes/subscription_check_route.dart';
import 'package:provider/provider.dart';

class CourseThumb extends StatelessWidget {
  final Course course;
  CourseThumb({required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        print("CourseThumb onTap");
        Provider.of<CourseProvider>(context, listen:false).setCourseDetail(course);
        Navigator.pushNamed(context, SubscriptionCheckRoute.routeName);
      },
      child: Container(
        height: 200,
        // padding: EdgeInsets.all(8.0),
        // margin: EdgeInsets.all(8.0),
        // color: Colors.yellow,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CourseThumbImg(course: course,),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     width: double.infinity,
                  // color: Color.fromRGBO(38, 38, 38, 0.4),
                  // padding: EdgeInsets.all(8.0),
                  // margin: EdgeInsets.all(0.0),

                  // child: Text(course.name,
                  //   style: TextStyle(color: Colors.white, fontSize: 24),),
                // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

}
