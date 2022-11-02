import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import '../../utils/Extensions/Widget_extensions.dart';
import '../../utils/Extensions/context_extensions.dart';
import '../../utils/Extensions/int_extensions.dart';
import '../../model/DefaultPostResponse.dart';
import '../../screen/QuickReadScreen.dart';
import '../../utils/Extensions/text_styles.dart';

class FitnessQuickReadWidget extends StatefulWidget {
  final List<DefaultPostResponse>? list;

  FitnessQuickReadWidget(this.list);

  @override
  _FitnessQuickReadWidgetState createState() => _FitnessQuickReadWidgetState();
}

class _FitnessQuickReadWidgetState extends State<FitnessQuickReadWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (dashboardStore.disableQuickview) return SizedBox();

    return Container(
      width: context.width(),
      margin: EdgeInsets.only(left: 16, right: 16),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor, border: Border.all(width: 0.1)),
      child: Column(
        children: [
          Text("Quick Look",
                  style: GoogleFonts.playfairDisplay(
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: 24))
              .paddingLeft(8),
          Text(
              "To read something quickly, especially to find the information you need",
              style: secondaryTextStyle(),
              textAlign: TextAlign.center),
          8.height,
          Icon(
            AntDesign.rightcircleo,
            color: Colors.black38,
            size: 18,
          )
        ],
      ).paddingSymmetric(horizontal: 12, vertical: 16).onTap(() {
        QuickReadScreen(blogList: widget.list).launch(context);
      }),
    );
  }
}
