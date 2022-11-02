import 'package:flutter/material.dart';
import '../component/CategoryComponent.dart';
import '../language/language.dart';
import '../model/CategoryResponse.dart';
import '../network/RestApi.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Widget_extensions.dart';

import '../component/AppWidget.dart';
import 'package:kzn/main.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
      appBar: customAppBarWidget(LanguageEn.lblCategories,
          elevation: 0, showBack: false, textColor: Colors.white),
      body: FutureBuilder<List<CategoryResponse>>(
        future: getCategory(0),
        builder: (context, snap) {
          if (snap.hasData) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: CategoryComponent(data: snap.data),
            );
          }
          if (snap.hasError) {
            apiErrorComponent(snap.error, context);
          }
          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}
