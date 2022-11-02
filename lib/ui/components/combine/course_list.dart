import 'package:flutter/material.dart';
import 'package:kzn/data/models/course.dart';
import 'package:kzn/ui/components/single/course_thumb.dart';

class CourseList extends StatelessWidget {
  final List<Course> courses;
  CourseList({required this.courses});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (crossAxisCount: 2),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            elevation: 7,
            child: CourseThumb(course: courses[index])),
        itemCount: courses.length
    );
  }
}
