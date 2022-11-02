// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursePrice _$CoursePriceFromJson(Map<String, dynamic> json) => CoursePrice(
      id: json['id'] as String,
      courseName: json['courseName'] as String,
      coursePrice: json['coursePrice'] as int,
      dateTime: DateTime.parse(json['dateTime'] as String),
      isSelected: json['isSelected'] as bool? ?? false,
);

Map<String, dynamic> _$CoursePriceToJson(CoursePrice instance) =>
    <String, dynamic>{
          'id': instance.id,
          'courseName': instance.courseName,
          'coursePrice': instance.coursePrice,
          'dateTime': instance.dateTime.toIso8601String(),
          'isSelected': instance.isSelected,
    };