import 'package:flutter/material.dart';

class PrivacyPolicyRoute extends StatefulWidget {
  static final String routeName = "/privacy_policy_route";
  @override
  _PrivacyPolicyRouteState createState() => _PrivacyPolicyRouteState();
}

class _PrivacyPolicyRouteState extends State<PrivacyPolicyRoute> {
  final Color tileColor = Colors.redAccent;
  final Color iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pinkAccent),
        backgroundColor: Colors.white,
        title: Text("Privacy Policy", style: TextStyle(fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: Colors.pinkAccent
        )),),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
        child: SingleChildScrollView(child: Text(
          '''
          Grace Fashion & Design School values the privacy of every person and is committed to protecting information that schools collect.

School's all staff must comply with Grace Fashion & Design School privacy law and policy.

This policy explains how our school collects and manages personal information, consistent with Grace Fashion & Design School law.'''
        )),
      ),

    );
  }
}


