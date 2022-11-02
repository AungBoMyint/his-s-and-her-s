import 'package:flutter/material.dart';
import 'package:kzn/data/constant.dart';
import 'package:kzn/data/models/course.dart';

class CourseThumbImg extends StatelessWidget {
  final Course course;
  CourseThumbImg({required this.course});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(appIconAsset,fit: BoxFit.fill),
          CircularProgressIndicator(),
          Image.network(course.coverImgUrl,fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,),
        ],
      ),
    );
  }
}
