import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kzn/data/constant.dart';
import 'package:kzn/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier{

  User? user;
  String? refreshKey, accessKey;

  Future<User> login({required String username,required String password})async{
    try{
      print("loginEndpoint $loginEndpoint");

      var formData = {
        'username': username,
        'password': password
      };
      print(formData.toString());

      var response = await Dio().post(loginEndpoint, data: formData);


      print("UserProvider->login response");
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      print(response.data.runtimeType);

      refreshKey = response.data['refresh'];
      accessKey = response.data['access'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      user = User(username: username, password: password);
      try{
        prefs.setBool("login", true);
        prefs.setString("username",user!.username);
        prefs.setString("password",user!.password);
        prefs.setString("refresh",refreshKey!);
        prefs.setString("access",accessKey!);
      }catch(innerExp){
        prefs.setBool("login", false);
        prefs.remove("username");
        prefs.remove("password");
        prefs.remove("refresh");
        prefs.remove("access");
        print('UserProvider->login innerExp $innerExp');
        user = null;
      }

      print('UserProvider->login success');
      return user!;

    }catch(exp){
      print('UserProvider->login exp');
      user = null;
      refreshKey = null;
      accessKey = null;
      print(exp);
      return user!;
    }
  }

}