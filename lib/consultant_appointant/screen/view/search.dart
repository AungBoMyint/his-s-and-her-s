import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../widget/general_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final HomeController _home = Get.find();

  @override
  void dispose() {
    _home.disposeSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            onChanged: _home.searchExpert,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Search',
            ),
          ),
        ),
        Expanded(
            child: Obx(
          () => ListView.builder(
            itemCount: _home.getSearchExpert().length,
            itemBuilder: (_, i) => SearchCard(
              expertModel: _home.getSearchExpert()[i],
            ),
          ),
        ))
      ],
    );
  }
}
