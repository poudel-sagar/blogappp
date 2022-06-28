import 'package:blogappfour/Blog/Blog.dart';
import 'package:blogappfour/CustomWidget/BlogCard.dart';
import 'package:blogappfour/Model/SuperModel.dart';
import 'package:blogappfour/Model/addBlogModels.dart';
import 'package:blogappfour/NetworkHandler.dart';
import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  Blogs({Key key, this.url}) : super(key: key);
  final String url;
  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  //Instance of network handler for fetching data from api
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      //here v28, 20:11
      //posts = superModel.posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return posts.length < 0
        ? Column(
            children: [
              //here
              // posts
              //     .map((item) => Column(
              //           children: <Widget>[
              //             InkWell(
              //               onTap: (){
              //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Blog(
              //               addBlogModel :build() item,
              //               networkHandler:networkHandler,
              // 
              // )));
              //               },
              //               child: BlogCard(
              //                   addBlogModel: item,
              //                   networkHandler: networkHandler),
              //             ),
              //             SizedBox(
              //               height: 20,
              //             )
              //           ],
              //         ))
              //     .toList(),
            ],
          )
        : Center(
            child: Text("We don't have any blog yet"),
          );
  }
}
