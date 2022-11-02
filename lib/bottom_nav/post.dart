// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class Post extends StatefulWidget {
   final String imageUrl, title, desc;

  const Post({Key? key,required this.imageUrl,required this.title,required this.desc}) : super(key: key);
  // Post({required this.imageUrl,required this.title, required this.desc})

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  Widget postContent(htmlContent){
    return Html(
      data: htmlContent,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.pinkAccent),
        backgroundColor: Colors.white,
        title: Text(widget.title, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,
        color: Colors.pinkAccent),),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Center(child: Hero(tag: widget.imageUrl,
            child: Image.network(widget.imageUrl))),
            SizedBox(height: 8),
            // Text(widget.title, style: TextStyle(fontSize: 16),),
            SizedBox(height: 4),
            postContent(widget.desc)],),
        ),
      ),
    );
  }
}
