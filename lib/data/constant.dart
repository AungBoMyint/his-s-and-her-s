import 'package:flutter/material.dart';
import 'package:kzn/data/models/checkbox_model.dart';

final String appName = "Grace Fashion & Design School";
// production server http://13.213.196.157:8000 2021-10-08 Updated
// development server http://192.168.1.2:8000
// http://127.0.0.1:8000/
//final String backendApiServer = 'http://13.213.196.157:8000';
final String backendApiServer = 'http://52.47.195.138:8081';
final String apiVersion = backendApiServer + '';
final String loginEndpoint = apiVersion + '/api/token/';
final String courseEndpoint = apiVersion + '/courses/?limit=100';
final String subscriptionEndpoint = apiVersion + '/subscriptions/';

final String appIconAsset = "assets/images/logo.png";
final String appIconUrl =
    "https://grace.sgp1.cdn.digitaloceanspaces.com/logo.png";

final Color tileColor = Colors.yellow;
final Color? iconColor = Colors.indigo[900];

final String fbProtocolUrl = "fb://page/Gracefashionschool";
final String fallbackUrl =
    "https://www.facebook.com/Gracefashionschool";

final List<String> introSliderImages = [
  "assets/images/slider/1.png",
  "assets/images/slider/2.png",
  "assets/images/slider/3.png",
  "assets/images/slider/4.png",
];

const List<String> courseNameList = [
  "Ready To Wear Basic Outfit Batch 2",
  "Fashion Illustration Online Training",
  "Baby Wear Online Class",
  "Polo Shirt & T Shirt Online Class",
  "Men Wear Wedding Suit Online Class",
  "Master of Myanmar Blouse Online Class",
  "Ready - Made Pant Online Training Course",
  "Readymade Coat & Jacket Online Class",
  "Ready To Wear Basic Outfit Course Online Class",
  "Readymade Crop Top Online Class",
  "Myanmar Basic Blouse & Longyi Course Online Class",
  "Ready - Made Corset & Bra Online Class",
  "Ready Made Advanced Online Class",
];
/*List<CheckboxModel> courseList = [
  CheckboxModel(
      courseTitle: "Ready To Wear Basic Outfit Batch 2", isSelected: false),
  CheckboxModel(
      courseTitle: "Fashion Illustration Online Training", isSelected: false),
  CheckboxModel(courseTitle: "Baby Wear Online Class", isSelected: false),
  CheckboxModel(
      courseTitle: "Polo Shirt & T Shirt Online Class", isSelected: false),
  CheckboxModel(
      courseTitle: "Men Wear Wedding Suit Online Class", isSelected: false),
  CheckboxModel(
      courseTitle: "Master of Myanmar Blouse Online Class", isSelected: false),
  CheckboxModel(
      courseTitle: "Ready - Made Pant Online Training Course",
      isSelected: false),
  CheckboxModel(
      courseTitle: "Readymade Coat & Jacket Online Class", isSelected: false),
  CheckboxModel(
      courseTitle: "Ready To Wear Basic Outfit Course Online Class",
      isSelected: false),
  CheckboxModel(
      courseTitle: "Readymade Crop Top Online Class", isSelected: false),
  CheckboxModel(
      courseTitle: "Myanmar Basic Blouse & Longyi Course Online Class",
      isSelected: false),
  CheckboxModel(
      courseTitle: "Ready - Made Corset & Bra Online Class", isSelected: false),
  CheckboxModel(
      courseTitle: "Ready Made Advanced Online Class", isSelected: false),
];*/

final List<String> paymentAccList = [
  "029 301 0290 3306 101 (KBZ Bank)",
  "09 969 5452 15 (KBZ Pay)",
  "09 969 5452 15 (Wave Pay - Password မလိုပါ)",
  "0241 2220 1000 5635 (AYA Bank)",
  "2009 6001 0000 7625 (CB Bank)",
];

const Map<String, dynamic> paymentAccMap = {
  "1": "029 301 0290 3306 101 (KBZ Bank)",
  "2": "09 969 5452 15 (KBZ Pay)",
  "3": "09 969 5452 15 (Wave Pay - Password မလိုပါ)",
  "4": "0241 2220 1000 5635 (AYA Bank)",
  "5": "2009 6001 0000 7625 (CB Bank)",
};

//Theme
const inputLabel = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);
const courseLabel = TextStyle(
  color: Colors.black,
  fontSize: 16,
);
const formBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

const enrollCollection = "enrollCollection";
const courseCollection = "courseCollection";