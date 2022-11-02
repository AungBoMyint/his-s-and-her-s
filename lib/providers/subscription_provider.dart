import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kzn/data/constant.dart';

class SubscriptionProvider extends ChangeNotifier{

  bool? status;
  bool? subscriptionLoading;

  // 1. select all courses [public]
  Future<bool> checkSubscription(int courseId, String token)async{
    print("SubscriptionProvider->checkSubscription ");

    try{
      subscriptionLoading = true;
      final String endPoint = subscriptionEndpoint+"?course_id=${courseId}";
      print("endPoint $endPoint");

      Dio dio = new Dio();
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(endPoint);
      print(response);
      print("SubscriptionProvider->checkSubscription response");
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}'); // this is body

      Map<String, dynamic> dataResponse = response.data;
      dynamic dataList =  dataResponse['results'];  // list of wp-content
      print("dataList is ");
      print(dataList);
      subscriptionLoading = false;
      if(dataList.length > 0) return true;
      else return false;
    }catch(exp){
      print('SubscriptionProvider->checkSubscriptio exp');
      // customer = null;
      subscriptionLoading = false;
      print(exp);
      return false;
    }


  }


}