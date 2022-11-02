import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/AppImages.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';

class NoDataWidget extends StatefulWidget {
  final String text;

  NoDataWidget(this.text);

  @override
  _NoDataWidgetState createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(ic_noData, fit: BoxFit.cover, height: 100, width: 100),
          8.height,
          Text(widget.text, style: primaryTextStyle()),
        ],
      ).center(),
    );
  }
}
