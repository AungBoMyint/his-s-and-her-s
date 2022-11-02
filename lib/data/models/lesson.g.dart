// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      url: json['url'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      videoUrl: json['video_url'] as String,
      createdAt: json['created_at'] as String,
      modifiedAt: json['modified_at'] as String,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'url': instance.url,
      'id': instance.id,
      'name': instance.name,
      'video_url': instance.videoUrl,
      'created_at': instance.createdAt,
      'modified_at': instance.modifiedAt,
    };
