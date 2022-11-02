import 'package:flutter/material.dart';
import 'package:kzn/providers/course_provider.dart';
import 'package:kzn/ui/components/single/lesson_card.dart';
import 'package:kzn/ui/components/single/lesson_video_player.dart';
import 'package:provider/provider.dart';

class CourseRoute extends StatefulWidget {
  static const routeName = '/course_route';
  @override
  _CourseRouteState createState() => _CourseRouteState();
}

class _CourseRouteState extends State<CourseRoute> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(Provider.of<CourseProvider>(context,listen:true).course!.name, style: TextStyle(fontSize: 14.0,
                color: Colors.black
            ),
          ),),
        body: Column(
            children: [
              LessonVideoPlayer(),
              //Placeholder(fallbackHeight: 300,),
              Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => LessonCard(lesson: Provider.of<CourseProvider>(context,listen: true).course!.lessonSet[index],),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: Provider.of<CourseProvider>(context,listen: true).course!.lessonSet.length
                  )
              )
            ],
          ),
      ),
    );
  }
}
