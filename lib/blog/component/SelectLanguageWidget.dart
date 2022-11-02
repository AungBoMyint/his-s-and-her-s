/* import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';

import '../utils/AppConstant.dart';

class SelectLanguageWidget extends StatefulWidget {
  final String? language;

  SelectLanguageWidget({this.language});

  @override
  SelectLanguageWidgetState createState() => SelectLanguageWidgetState();
}

class SelectLanguageWidgetState extends State<SelectLanguageWidget> {
  String selectedLanguage = defaultValues.defaultLanguage;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    selectedLanguage = widget.language!;
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.8,
      minChildSize: 0.2,
      builder: (context, scrollController) {
        return Container(
          decoration: boxDecorationWithRoundedCornersWidget(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0) )),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(height: 0),
            itemCount: localeLanguageList.length,
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            itemBuilder: (_, i) {
              LanguageDataModel data = localeLanguageList[i];

          /// Removed not supported language
          if (data.languageCode == 'zh') return SizedBox();

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonCacheImageWidget(data.flag!, height: 20, width: 20, fit: BoxFit.cover),
                  10.width,
                  Text(data.name!, style: primaryTextStyle()),
                ],
              ),
              Icon(Ionicons.checkmark_done_sharp, size: 20).visible(selectedLanguage == data.languageCode),
            ],
          ).paddingAll(20).onTap(() {
            selectedLanguage = data.languageCode!;
            setState(() {});

                finish(context, selectedLanguage);
              });
            },
          ),
        );
      },
    );
  }
}
 */