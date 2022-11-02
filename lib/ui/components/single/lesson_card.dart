import 'package:flutter/material.dart';
import 'package:kzn/data/models/lesson.dart';
import 'package:kzn/providers/course_provider.dart';
import 'package:provider/provider.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  LessonCard({required this.lesson});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: InkWell(
        onTap: (){
          print("lessonCard.onTap");
          Provider.of<CourseProvider>(context,listen: false).setLessonDetail(lesson);
        },

          child: Text(lesson.name, style: TextStyle(color: Colors.black),),
        // ),
      ),
    );
  }
}
