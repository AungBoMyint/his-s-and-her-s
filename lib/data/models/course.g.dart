// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as int,
      lessonSet: (json['lesson_set'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      description: json['description'] as String,
      coverImgUrl: json['cover_img_url'] as String,
      price: json['price'] as int,
      createdAt: json['created_at'] as String,
      modifiedAt: json['modified_at'] as String,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'lesson_set': instance.lessonSet.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'description': instance.description,
      'cover_img_url': instance.coverImgUrl,
      'price': instance.price,
      'created_at': instance.createdAt,
      'modified_at': instance.modifiedAt,
    };
