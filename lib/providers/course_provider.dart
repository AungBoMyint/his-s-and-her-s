import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kzn/data/constant.dart';
import 'package:kzn/data/models/course.dart';
import 'package:kzn/data/models/lesson.dart';

class CourseProvider extends ChangeNotifier{

  Course? course;
  Future<Lesson>? lesson;

  List<Course> courseListNormal = [];
  Future<List<Course>>? courseList;
  int? _lastCourseId;
  bool? courseLoading;

  // 1. select all courses [public]
  Future<void> getCourseListForOneTime()async{
    print("CourseProvider->getCourseListForOneTime ");

    try{
      courseLoading = true;
      print("courseEndpoint $courseEndpoint");
      var response = await Dio().get(courseEndpoint);
      print(response);
      print("CourseProvider->getCourseListForOneTime response");
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      Map<String, dynamic> dataResponse = response.data;
      dynamic dataList =  dataResponse['results'];  // list of wp-content
      print("dataList is ");
      print(dataList);
      courseListNormal = [];

      for(int i=0; i<dataList.length; i++){
        print("Goods => dataList[${i}]");
        print(jsonEncode(dataList[i]));
        print(dataList[i].runtimeType);

        try{
          print("try to parse Goods.fromJson");
          courseListNormal.add(Course.fromJson(dataList[i]));
          _lastCourseId = courseListNormal.last.id;
        }catch(innerExp){
          print('CourseProvider->getCourseListForOneTime innerExp $innerExp');
        }
      }


      //goodsListForOneTime = goodsListCONSTANT;
      print("courseListNormal");
      print(courseListNormal);
      courseList =  Future.delayed(Duration.zero,()=>courseListNormal);


      //return goodsListForOneTime;

      courseLoading = false;
      Future.delayed(Duration(seconds: 1),(){
        notifyListeners();
      });

    }catch(exp){
      print('CourseProvider->getCourseListForOneTime exp');
      // customer = null;
      courseLoading = false;
      print(exp);
      courseListNormal = [];
      courseList =  Future.delayed(Duration.zero,()=>courseListNormal);
      Future.delayed(Duration(seconds: 1),(){
        notifyListeners();
      });
    }


  }

  void setCourseDetail(Course detailCourse){
    print("CourseProvider->setCourseDetail");
    course = detailCourse;
    try{
      setLessonDetail(course!.lessonSet.first);
    }
    catch(exp){
      print("no element");
    }
    notifyListeners();
  }

  void setLessonDetail(Lesson detailLesson){
    print("CourseProvider->setLessonDetail");
    lesson = Future.delayed(Duration.zero,()=>detailLesson);
    notifyListeners();
  }


}