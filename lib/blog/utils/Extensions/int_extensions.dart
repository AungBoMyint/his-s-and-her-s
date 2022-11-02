import 'package:flutter/material.dart';

extension IntExtensions on int? {
  int validate({int value = 0}) {
    return this ?? value;
  }

  Widget get height => SizedBox(height: this?.toDouble());

  Widget get width => SizedBox(width: this?.toDouble());

  Duration get microseconds => Duration(microseconds: this.validate());

  Duration get milliseconds => Duration(milliseconds: this.validate());

  Duration get seconds => Duration(seconds: this.validate());

  Duration get minutes => Duration(minutes: this.validate());

  Duration get hours => Duration(hours: this.validate());

  Duration get days => Duration(days: this.validate());

  /// Returns Size
  Size get size => Size(this!.toDouble(), this!.toDouble());

  /// HTTP status code
  bool isSuccessful() => this! >= 200 && this! <= 206;

}
