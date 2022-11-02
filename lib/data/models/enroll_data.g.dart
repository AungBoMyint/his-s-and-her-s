// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enroll_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollData _$EnrollDataFromJson(Map<String, dynamic> json) => EnrollData(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      courseList: (json['courseList'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      paymentAccName: json['paymentAccName'] as String,
      bankSsImage: json['bankSsImage'] as String,
      totalPrice: json['totalPrice'] as int,
      facebookProfileSsImage: json['facebookProfileSsImage'] as String,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
);

Map<String, dynamic> _$EnrollDataToJson(EnrollData instance) =>
    <String, dynamic>{
          'name': instance.name,
          'phoneNumber': instance.phoneNumber,
          'courseList': instance.courseList,
          'paymentAccName': instance.paymentAccName,
          'bankSsImage': instance.bankSsImage,
          'facebookProfileSsImage': instance.facebookProfileSsImage,
          'totalPrice': instance.totalPrice,
          'dateTime': instance.dateTime?.toIso8601String(),
    };