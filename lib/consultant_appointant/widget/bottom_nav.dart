import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../controller/template_controller.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TemplateController controller = Get.find();
    return Container(
      height: 70,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            offset: Offset(0, -1),
            spreadRadius: 1,
          )
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: GNav(
          selectedIndex: controller.index.value,
          onTabChange: controller.onChange,
          rippleColor: Theme.of(context)
              .highlightColor, // tab button ripple color when pressed
          hoverColor: Theme.of(context).hoverColor, // tab button hover color
          haptic: true, // haptic feedback
          tabActiveBorder: Border.all(
              color: Theme.of(context).selectedRowColor,
              width: 1), // tab button border
          tabBorder:
              Border.all(color: Colors.grey, width: 1), // tab button border
          tabShadow: [
            BoxShadow(
                color: Theme.of(context).scaffoldBackgroundColor, blurRadius: 8)
          ], // tab button shadow
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 100), // tab animation duration
          gap: 10, // the tab button gap between icon and text
          color: Colors.black, // unselected icon color
          activeColor: Theme.of(context)
              .selectedRowColor, // selected icon and text color
          iconSize: 25, // tab button icon size
          tabBackgroundColor: Colors.blue, // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 5), // navigation bar padding

          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: LineIcons.clipboardList,
              text: 'Booking',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            )
          ]),
    );
  }
}
