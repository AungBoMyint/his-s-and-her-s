import 'package:json_annotation/json_annotation.dart';

part 'enroll_data.g.dart';

@JsonSerializable()
class EnrollData {
  final String name;
  final String phoneNumber;
  final List<Map<String, dynamic>> courseList;
  final String paymentAccName;
  final String bankSsImage;
  final String facebookProfileSsImage;
  final int totalPrice;
  final DateTime? dateTime;
  EnrollData({
    required this.name,
    required this.phoneNumber,
    required this.courseList,
    required this.paymentAccName,
    required this.bankSsImage,
    required this.totalPrice,
    required this.facebookProfileSsImage,
    this.dateTime,
  });

  factory EnrollData.fromJson(Map<String, dynamic> json) =>
      _$EnrollDataFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollDataToJson(this);

  EnrollData copyWith({
    String? name,
    String? phoneNumber,
    List<Map<String, dynamic>>? courseList,
    String? paymentAccName,
    String? bankSsImage,
    String? facebookProfileSsImage,
    int? totalPrice,
    DateTime? dateTime,
  }) =>
      EnrollData(
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        courseList: courseList ?? this.courseList,
        paymentAccName: paymentAccName ?? this.paymentAccName,
        bankSsImage: bankSsImage ?? this.bankSsImage,
        facebookProfileSsImage:
        facebookProfileSsImage ?? this.facebookProfileSsImage,
        totalPrice: totalPrice ?? this.totalPrice,
        dateTime: dateTime ?? this.dateTime,
      );
}