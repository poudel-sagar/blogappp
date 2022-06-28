//page to open when clicked + button


import 'dart:convert';
import 'package:blogappfour/CustomWidget/OverlayCard.dart';
import 'package:blogappfour/Model/addBlogModels.dart';
import 'package:blogappfour/NetworkHandler.dart';
import 'package:blogappfour/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  //list for dropdown menus

  List dropDownListData = [
    {"title": "Latest Offer", "value": "1"},
    {"title": "Trending", "value": "2"},
    {"title": "New Event", "value": "3"},
    {"title": "Stories", "value": "4"},
    {"title": "Carriers", "value": "5"},
  ];
  //for default value in dropdown menu it changes when user select anyone
  String defaultValue = " ";

  final _globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  //title , body and category for adding blog to rest api
  TextEditingController _category = TextEditingController();
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  IconData iconPhoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (_imageFile.path != null &&
                  _globalkey.currentState.validate()) {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) => OverlayCard(
                          imageFile: _imageFile,
                          title: _title.text,
                        ));
              }
            },
            child: Text(
              "preview",
              style: TextStyle(fontSize: 18, color: Colors.teal),
            ),
          )
        ],
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          children: <Widget>[
            titleTextField(),
            bodyTextField(),
            SizedBox(
              height: 20,
            ),
            dropdown(),
            SizedBox(
              height: 20,
            ),
            addButton(),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        controller: _title,
        validator: (value) {
          if (value.isEmpty) {
            return "Title can't be empty";
          } else if (value.length > 100) {
            return "Title length should be less than 100";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          labelText: "Add Image and Title",
          prefixIcon: IconButton(
              icon: Icon(
                iconPhoto,
                color: Colors.teal,
              ),
              onPressed: takeCoverPhoto),
        ),
        maxLength: 150,
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _content,
        validator: (value) {
          if (value.isEmpty) {
            return "Body can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          labelText: "Provide body of your blog",
        ),
        maxLines: null,
      ),
    );
  }

  Widget dropdown() {
    return
        //  ListView(
        //   children: [
        DropdownButton<String>(
            isDense: true,
            value: defaultValue,
            isExpanded: true,
            menuMaxHeight: 350,
            items: [
              const DropdownMenuItem(
                  child: Text(
                    "Select Categories",
                    style: TextStyle(fontSize: 18, color: Colors.teal),
                  ),
                  value: "",),
              //spread operator for spreading list of dropdown button
              ...dropDownListData.map<DropdownMenuItem<String>>((dropdowndata) {
                return DropdownMenuItem(
                    child: Text(dropdowndata['title']),
                    value: dropdowndata['value']);
              }).toList(),
            ],
            //value in onChange is the value that we selected from dropdown menu
            onChanged: (value) {
              print("Selected Value $value");

              setState(() {
                defaultValue = value;
              });
            });
         

        //   ],
        // )
        ;
  }

// add button to add blog
  Widget addButton() {
    return InkWell(
      onTap: () async {
        //checking if image is selected for blog or not
        //validate method validate if images and text are properly provided or not
        if (_imageFile != null && _globalkey.currentState.validate()) {

          //initializing model class
          AddBlogModel addBlogModel = AddBlogModel(
              content: _content.text,
              title: _title.text,
              category: _category.text);
          //  tojson used to devstack model videos v27,4:00
          var response =
              await networkHandler.post1("/posts/new", addBlogModel.toJson());
          print(response.body);
          if (response.statusCode == 200 || response.statusCode == 201) {
          //
            String id = json.decode(response.body)["posts"];
            // var imageResponse = await networkHandler.patchImage(
            //     "/posts/new$id", _imageFile.path);
            // print(imageResponse.statusCode);
            // if (imageResponse.statusCode == 200 ||
            //     imageResponse.statusCode == 201) {
            //   Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(builder: (context) => HomePage()),
            //       (route) => false);
            // }
          }
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal),
          child: Center(
              child: Text(
            "Add Blog",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = coverPhoto;
      iconPhoto = Icons.check_box;
    });
  }
}



//network handler old one
// import 'dart:html';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:logger/logger.dart';

// class NetworkHandler {
//   //String baseurl = "https://faker-rest.zeferinix.com/api/v1/";
//   String baseurl = "https://flaskapi-sanjeev.herokuapp.com/";

//   var log = Logger();
//   //secure storage for token
//   FlutterSecureStorage storage = FlutterSecureStorage();

//   Future get(String url) async {
// //getting token
//   String token = await storage.read(key: "token");

// //formater takes input  as a string(url) concatenate url with base url and return it.
//     url = formater(url);

// //getting response from backend
//     var response =
//         await http.get(url, headers: {"Authorization": "Bearer $token"});
//     //from tutorial 17

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       log.i(response.body);
//       return json.decode(response.body);
//     }
//     log.i(response.body);
//     log.i(response.statusCode);
//   }
// //sending username, email and password to blog api.

//   Future<http.Response> post(String url,
//       {Map<String, String> body, Map<String, String> header}) async {
//     //in tutorial 17
//     String token = await storage.read(key: "token");
// //original
//     url = formater(url);
//     log.d(body);
//     final headers = {
//       "Content-type": "application/json"
//       //in tutorial 17
//       ,
//       "Authorization": "Bearer $token"
//       //original
//     };
//     if (header != null) {
//       headers.addAll(header);
//     }
//     var response = await http.post(
//       url,
//       headers: headers,
//       body: json.encode(body),
//     );

//     return response;
//     // if (response.statusCode == 200 || response.statusCode == 201) {
//     //   log.i(response.body);
//     //   return response;
//     // }
//     // log.d(response.body);
//     // log.d(response.statusCode);
//   }
//   //patch method to send files to backend
//   Future<http.StreamedResponse> patchImage(String url,String filePath) async
//   {
//     url=formater(url);
//     String token = await storage.read(key: "token");
//     //multipartrequest method used because we are sending file here
//     var request=http.MultipartRequest('PATCH', Uri.parse(url));
//     request.files.add(await http.MultipartFile.fromPath("img", filePath));
//     request.headers.addAll({
//       "content-type":"multipart/form-data",
//       "Authorization": "Bearer $token"
//     });
//     var response= request.send();
//     return response;
//   }

// //formater takes input  as a string(url) concatenate url with base url and return it.
//   String formater(String url) {
//     return baseurl + url;
//   }
  
//   NetworkImage getImage(String username){
//     //end point for user image v:19 ,16:41
//     String url = formater("/uploads/$username.jpg");
//     return NetworkImage(url);
//   }
// }

