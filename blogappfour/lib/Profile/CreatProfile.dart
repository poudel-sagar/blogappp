// //import 'dart:html';
// import 'dart:io';

// import 'package:blogappthree/NetworkHandler.dart';
// import 'package:blogappthree/pages/HomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CreatProfile extends StatefulWidget {
//   const CreatProfile({Key key}) : super(key: key);

//   @override
//   State<CreatProfile> createState() => _CreatProfileState();
// }

// class _CreatProfileState extends State<CreatProfile> {
//   //network instance for calling api on clicking submit button to post user info
//   final networkHandler = NetworkHandler();
//   bool circular = false;
//   //variable to store image picked from the camera or gallery
//   PickedFile _imageFile;
//   //global key to handle validation
//   final _globalkey = GlobalKey<FormState>();
//   TextEditingController _name = TextEditingController();
//   TextEditingController _profession = TextEditingController();
//   TextEditingController _dob = TextEditingController();
//   TextEditingController _title = TextEditingController();
//   TextEditingController _about = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Form(
//       key: _globalkey,
//       child: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//         children: <Widget>[
//           imageProfile(),
//           SizedBox(height: 20),
//           nameTextField(),
//           SizedBox(
//             height: 20,
//           ),
//           professionTextField(),
//           SizedBox(
//             height: 20,
//           ),
//           dobField(),
//           SizedBox(
//             height: 20,
//           ),
//           titleTextField(),
//           SizedBox(
//             height: 20,
//           ),
//           aboutTextField(),
//           SizedBox(
//             height: 20,
//           ),
//           //bottom section
//           InkWell(
//             onTap: () async {
//               if (_globalkey.currentState.validate()) {
//                 //map variable to map the string value user inserted to backend api string
//                 Map<String, String> data = {
//                   "name": _name.text,
//                   "profession": _profession.text,
//                   "dob": _dob.text,
//                   "title": _title.text,
//                   "about": _about.text,
//                 };
//                 //post request to send the user info to backend
//                 var response = await networkHandler.post("/profile/add", body:data);
//                 if (response.statusCode == 200 || response.statusCode == 201) {
//                   if (_imageFile != null) {
//                     var imageResponse = await networkHandler.patchImage(
//                         "/profile/add/image", _imageFile.path);
//                     if (imageResponse.statusCode == 200) {
//                        setState(() {
//                       circular = false;
//                     });
//                     Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(builder: (context) => HomePage()),
//                         (route) => false);
//                     }
//                   } else {
//                     setState(() {
//                       circular = false;
//                     });
//                     Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(builder: (context) => HomePage()),
//                         (route) => false);
//                   }
//                 }
//               }
//             },
//             child: Center(
//               child: Container(
//                 width: 200,
//                 height: 50,
//                 decoration: BoxDecoration(
//                     color: Colors.teal,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Center(
//                   child: circular
//                       ? CircularProgressIndicator()
//                       : Text(
//                           "submit",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold),
//                         ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ));
//   }

//   Widget imageProfile() {
//     return Center(
//       child: Stack(
//         children: <Widget>[
//           CircleAvatar(
//               radius: 80.9,
//               backgroundImage: _imageFile == null
//                   ? AssetImage("assets/profile.jpeg")
//                   : FileImage(File(_imageFile.path))),
//           Positioned(
//             bottom: 20.0,
//             right: 20,
//             child: InkWell(
//                 onTap: () async {
//                   setState(() {
//                     circular = true;
//                   });
//                   showModalBottomSheet(
//                       context: context, builder: ((builder) => bottomSheet()));
//                 },
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: Colors.teal,
//                   size: 28,
//                 )),
//           )
//         ],
//       ),
//     );
//   }

//   Widget bottomSheet() {
//     return Container(
//       height: 100.0,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         children: <Widget>[
//           Text(
//             "choose profile photo",
//             style: TextStyle(fontSize: 20.0),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextButton.icon(
//                 icon: Icon(Icons.camera),
//                 onPressed: () {
//                   takePhoto(ImageSource.camera);
//                 },
//                 label: Text("camera"),
//               ),
//               TextButton.icon(
//                 icon: Icon(Icons.image),
//                 onPressed: () {
//                   takePhoto(ImageSource.gallery);
//                 },
//                 label: Text("Gallery"),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   void takePhoto(ImageSource source) async {
//     final pickedFile = await _picker.getImage(
//       source: source,
//     );
//     setState(() {
//       _imageFile = pickedFile;
//     });
//   }

//   Widget nameTextField() {
//     return TextFormField(
//       controller: _name,
//       validator: (value) {
//         if (value.isEmpty) return "Name can't be empty";
//         return null;
//       },
//       decoration: InputDecoration(
//           border:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
//           //focusborder to change the color od text field to orange when user start typing
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.orange, width: 2)),
//           prefixIcon: Icon(
//             Icons.person,
//             color: Colors.green,
//           ),
//           labelText: "Name",
//           helperText: "Name can't be empty",
//           hintText: "Your Name"),
//     );
//   }

//   Widget professionTextField() {
//     return TextFormField(
//       controller: _profession,
//       validator: (value) {
//         if (value.isEmpty) return "Profession can't be empty";
//         return null;
//       },
//       decoration: InputDecoration(
//           border:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
//           //focusborder to change the color od text field to orange when user start typing
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.orange, width: 2)),
//           prefixIcon: Icon(
//             Icons.person,
//             color: Colors.green,
//           ),
//           labelText: "Profession",
//           helperText: "Profession can't be empty",
//           hintText: "Your Profession"),
//     );
//   }

//   Widget dobField() {
//     return TextFormField(
//       controller: _dob,
//       validator: (value) {
//         if (value.isEmpty) return "DOB can't be empty";
//         return null;
//       },
//       decoration: InputDecoration(
//           border:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
//           //focusborder to change the color od text field to orange when user start typing
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.orange, width: 2)),
//           prefixIcon: Icon(
//             Icons.person,
//             color: Colors.green,
//           ),
//           labelText: "Date of Birth",
//           helperText: "DOB can't be empty",
//           hintText: "01/01/2001"),
//     );
//   }

//   Widget titleTextField() {
//     return TextFormField(
//       controller: _title,
//       validator: (value) {
//         if (value.isEmpty) return "Title can't be empty";
//         return null;
//       },
//       decoration: InputDecoration(
//           border:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
//           //focusborder to change the color od text field to orange when user start typing
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.orange, width: 2)),
//           prefixIcon: Icon(
//             Icons.person,
//             color: Colors.green,
//           ),
//           labelText: "Title",
//           helperText: "Title can't be empty",
//           hintText: "Flutter Developer"),
//     );
//   }

//   Widget aboutTextField() {
//     return TextFormField(
//       controller: _about,
//       validator: (value) {
//         if (value.isEmpty) return "About can't be empty";
//         return null;
//       },
//       maxLines: 4,
//       decoration: InputDecoration(
//           border:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
//           //focusborder to change the color od text field to orange when user start typing
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.orange, width: 2)),
//           labelText: "About",
//           helperText: "Write about yourself",
//           hintText: "I am Flutter Developer"),
//     );
//   }
// }
