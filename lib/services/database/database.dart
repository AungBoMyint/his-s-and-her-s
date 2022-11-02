import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kzn/data/constant.dart';
import 'package:kzn/data/models/enroll_data.dart';
import 'package:kzn/services/api/send_notification.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/course_price.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<CoursePrice>> getCoursePriceList() async {
    return _firestore
        .collection(courseCollection)
        .orderBy("dateTime", descending: true)
        .withConverter(
      fromFirestore: (snapshot, _) =>
          CoursePrice.fromJson(snapshot.data()!),
      toFirestore: (coursePrice, _) {
        final course = coursePrice as CoursePrice;
        return course.toJson();
      },
    )
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<bool> uploadEnrollData(EnrollData enrollData) async {
    Completer<bool> _completer = Completer();
    if (enrollData.bankSsImage.isNotEmpty &&
        enrollData.facebookProfileSsImage.isNotEmpty) {
      List<File> _fileList = <File>[
        File(enrollData.bankSsImage),
        File(enrollData.facebookProfileSsImage),
      ];
      try {
        EnrollData jsonData = enrollData;
        Future.wait(List.generate(_fileList.length, (index) async {
          await _storage
              .ref()
              .child("enrollSs/${Uuid().v1()}")
              .putFile(_fileList[index])
              .then((snapshot) async {
            debugPrint(
                '*********************Uploaded ${snapshot.bytesTransferred} bytes.');
            await snapshot.ref.getDownloadURL().then((value) => index == 0
                ? jsonData = jsonData.copyWith(
              bankSsImage: value,
            )
                : jsonData = jsonData.copyWith(facebookProfileSsImage: value));
          });
        })).then((value) async {
          jsonData = jsonData.copyWith(dateTime: DateTime.now());
          await _firestore
              .collection(enrollCollection)
              .doc()
              .set(jsonData.toJson())
              .then((value) async {
            _completer.complete(true);
            try {
              await sendPush("အတန်းအပ်ခြင်း", "နာမည်-${jsonData.name}").then(
                      (value) =>
                      print("****************Push Send Success********"));
            } catch (e) {
              debugPrint("******************sendPushError: $e*********");
            }
          });
        });
      } catch (e) {
        _completer.complete(false);
        debugPrint("*************Something wrong $e**************");
      }
    }
    return _completer.future;
  }
}