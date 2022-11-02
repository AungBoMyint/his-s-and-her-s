import 'package:flutter/material.dart';
import '../utils/Extensions/Widget_extensions.dart';

import '../utils/Extensions/text_styles.dart';

class ApiErrorScreen extends StatefulWidget {
  @override
  _ApiErrorScreenState createState() => _ApiErrorScreenState();
}

class _ApiErrorScreenState extends State<ApiErrorScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
              child: Text(
                  'Sorry, you cannot list resources. Verify your purchase code',
                  style: primaryTextStyle()))
          .paddingSymmetric(horizontal: 16),
    );
  }
}
