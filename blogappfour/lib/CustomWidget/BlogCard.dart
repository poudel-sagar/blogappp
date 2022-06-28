//import 'dart:html';

import 'dart:io';

import 'package:blogappfour/Model/SuperModel.dart';
import 'package:blogappfour/Model/addBlogModels.dart';
import 'package:blogappfour/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                 // here
                  //image to identify v28 ,27:13
                  //  image: networkHandler.getImage(addBlogModel.id),
                    fit: BoxFit.fitWidth),
              ),
            ),
            Positioned(
                bottom: 3,
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    addBlogModel.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
//5:27.
