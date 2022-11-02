import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class BlogProvider extends ChangeNotifier{

  late Future<dynamic> colorBlogPosts;
  late Future<dynamic> famousBlogPosts;
  late Future<dynamic> drawingBlogPosts;
  late Future<dynamic> historyBlogPosts;
  late Future<dynamic> otherBlogPosts;
  late Future<dynamic> notiBlogPosts;
  Future<void> fetchWpPostsForColors() async {
    print("fetchWpPostsForColors");
    final response = await http.get(Uri.parse(
      "https://hisandhermyanmar-95b62f.ingress-erytho.easywp.com/index.php/wp-json/wp/v2/posts?_embed&per_page=100&categories=291&orderby=date&status=publish",
      // headers: {"Accept: application/json"}
    ));
    colorBlogPosts = Future.delayed(Duration.zero,(){
      return jsonDecode(response.body);
    });
    notifyListeners();
  }


  Future<void> fetchWpPostsForFamous() async {
    final response = await http.get(Uri.parse(
      "https://hisandhermyanmar-95b62f.ingress-erytho.easywp.com/index.php/wp-json/wp/v2/posts?_embed&per_page=100&categories=292&orderby=date&status=publish",
      // headers: {"Accept: application/json"}
    ));
    famousBlogPosts = Future.delayed(Duration.zero,(){
      return jsonDecode(response.body);
    });
    notifyListeners();
  }


  Future<void> fetchWpPostsForDrawing() async {
    final response = await http.get(Uri.parse(
      "https://hisandhermyanmar-95b62f.ingress-erytho.easywp.com/index.php/wp-json/wp/v2/posts?_embed&per_page=100&categories=293&orderby=date&status=publish",
      // headers: {"Accept: application/json"}
    ));
    drawingBlogPosts = Future.delayed(Duration.zero,(){
      return jsonDecode(response.body);
    });
    notifyListeners();
  }


  Future<void> fetchWpPostsForHistory() async {
    final response = await http.get(Uri.parse(
      "https://hisandhermyanmar-95b62f.ingress-erytho.easywp.com/index.php/wp-json/wp/v2/posts?_embed&per_page=100&categories=294&orderby=date&status=publish",
      // headers: {"Accept: application/json"}
    ));

    historyBlogPosts = Future.delayed(Duration.zero,(){
      return jsonDecode(response.body);
    });
    notifyListeners();
  }


  Future<void> fetchWpPostsForOther() async {
    final response = await http.get(Uri.parse(
      "https://hisandhermyanmar-95b62f.ingress-erytho.easywp.com/index.php/wp-json/wp/v2/posts?_embed&per_page=100&categories=1&orderby=date&status=publish",
      // headers: {"Accept: application/json"}
    ));

    otherBlogPosts = Future.delayed(Duration.zero,(){
      return jsonDecode(response.body);
    });
    notifyListeners();
  }


  Future fetchWpPostsForNoti() async {
    final response = await http.get(Uri.parse(
      "https://hisandhermyanmar-95b62f.ingress-erytho.easywp.com/index.php/wp-json/wp/v2/posts?_embed&per_page=100&categories=289&orderby=date&status=publish",
      // headers: {"Accept: application/json"}
    ));

    notiBlogPosts = Future.delayed(Duration.zero,(){
      return jsonDecode(response.body);
    });
    notifyListeners();
  }
}