/*  import 'package:kzn/bottom_nav/post.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_html/flutter_html.dart';

 import 'package:http/http.dart' as http;
 import 'dart:convert';

 import 'package:kzn/providers/blog_provider.dart';
 import 'package:provider/provider.dart';

 String url ='https://gracefashionanddesignschool.com';

 Future fetchWpPosts() async {
   final response = await http.get(Uri.parse(
     "https://gracefashionanddesignschool.com/index.php/wp-json/wp/v2/posts?_embed&per_page=100&categories=57&orderby=date&status=publish",
   ));

   var covetedDatatoJson = jsonDecode(response.body);
   return covetedDatatoJson;
 }


 Future fetchWpPostImageUrl(String href ) async {

   final response = await http.get(Uri.parse(href), headers: {"Accept": "application/json"});
   var covetedDatatoJson = jsonDecode(response.body);
   print(covetedDatatoJson);
   return covetedDatatoJson;
 }

 class NewClass extends StatefulWidget {
    const NewClass({Key? key}) : super(key: key);
   @override
   _NewClassState createState() => _NewClassState();
 }
 class _NewClassState extends State<NewClass> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         elevation: 2,
         iconTheme: const IconThemeData(color: Colors.pinkAccent),
         backgroundColor: Colors.white,
         title: Center(
           child: Text("His's and Her Fashion Info", style: TextStyle(fontWeight: FontWeight.w700,
               fontSize: 16.0,
               color: Colors.pinkAccent,
             letterSpacing: 1,
             wordSpacing: 1,
           )),
         ),
       ),

       body: FutureBuilder(
         future: Provider.of<BlogProvider>(context, listen: true),
         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
           if(snapshot.hasData){
             return ListView.builder(
               itemCount: snapshot.data.length,
               itemBuilder: (BuildContext context, int index) {
                 Map wppost = snapshot.data[index];

                  //you write wp:featuredmedia:
                  //I fixed wp:featuredmedia

                 return PostTile(
                     href: wppost["_links"]["wp:featuredmedia"][0]["href"],
                     title: wppost["title"]["rendered"].replaceAll("#038;", ""),
                     desc: wppost["excerpt"]["rendered"],
                     imageUrl: wppost["_embedded"]["wp:featuredmedia"].first["source_url"],
                     content: wppost["content"]["rendered"]);
               },);
           }
           return Center(child: const CircularProgressIndicator());
         },
       ),
     );
   }
 }


 class PostTile extends StatefulWidget {
   const PostTile({Key? key,required this.href,
     required this.title,required this.desc,
     required this.content,required this.imageUrl}) : super(key: key);

   final String href, title, desc, content, imageUrl;

   @override
   State<PostTile> createState() => _PostTileState();
 }

 class _PostTileState extends State<PostTile> {
   //var imageUrl = "";
   Widget shortDescritionView (){
     return Html(
       data: widget.desc,
     );
   }

   @override
   Widget build(BuildContext context) {
     return GestureDetector(
       onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => Post(
           desc: widget.content,
           imageUrl: widget.imageUrl,
           title: widget.title,
         )));
       },
       child: Card(
         elevation: 1,
         // height: 150,
         margin: EdgeInsets.only(top: 8),
         // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
         child: Row(
           // crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Hero(
                 tag: widget.imageUrl,
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: Image.network(widget.imageUrl,
                       width: 100,
                       height: 100,
                       fit: BoxFit.cover

                   ),
                 ),
               ),
             ),

             SizedBox(width: 8),

             Expanded(child:
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [Padding(
                 padding: const EdgeInsets.only(left: 8),
                 child: Text(widget.title,
                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)
                 ),
               ),
                 shortDescritionView(),
               ],)),
             SizedBox(width: 5),

           ],
         ),
       ),
     );
   }
 } */