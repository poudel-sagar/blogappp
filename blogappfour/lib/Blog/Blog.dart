import 'package:blogappfour/Model/addBlogModels.dart';
import 'package:blogappfour/NetworkHandler.dart';
import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  const Blog({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);
  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 340,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 8,
              child: Column(
                children: [
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      // image: networkHandler.getImage(addBlogModel),
                      fit: BoxFit.fill,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      addBlogModel.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.chat_bubble,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // Text(
                        //   addBlogModel.comment.toString(),
                        //   style: TextStyle(fontSize: 15),
                        // ),
                         Icon(
                          Icons.thumb_up,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // Text(
                        //   addBlogModel.like.toString(),
                        //   style: TextStyle(fontSize: 15),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
