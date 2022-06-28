// import 'dart:ui';
// import 'package:blogappfour/Blog/Blogs.dart';
// import 'package:blogappfour/Model/profileModel.dart';
// import 'package:blogappfour/NetworkHandler.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class MainProfile extends StatefulWidget {
//   const MainProfile({Key key}) : super(key: key);

//   @override
//   State<MainProfile> createState() => _MainProfileState();
// }

// class _MainProfileState extends State<MainProfile> {
//   bool circular=true;
//   NetworkHandler networkHandler = NetworkHandler();
  //ProfileModel profileModel = ProfileModel();
  
   
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchData();
  // }
  // void fetchData()async{
  //   var response = await networkHandler.get("/profile/getData");
  //   //converting json data into normal data

  //   setState(() {
  //    profileModel=ProfileModel.fromJson(response["data"]);
  //     circular=false;
  //   });

  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white10,
//         // leading: IconButton(
//         //   icon: Icon(
//         //     Icons.arrow_back,
//         //   ),
//         //   onPressed: () {},
//         //   color: Colors.black,
//         // ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.edit,
//             ),
//             onPressed: () {},
//             color: Colors.black,
//           ),
//         ],
//       ),
//       //first showing circular bar before showing data from backend
//       body: circular? Center(child: CircularProgressIndicator()): ListView(
//         children: [
//           head(),
//           Divider(
//             thickness: 0.8,
//           ),
//           otherDetails("About",profileModel.about),
//           otherDetails("Name",profileModel.name),
//           otherDetails("Profession",profileModel.profession),
//           otherDetails("Profession",profileModel.DOB), 
//           Divider(thickness: 0.8,),
             

          //  SizedBox(
          //   height:20,
           
          //  ),
          //   Blogs(
          //  url:"/blogpost/getOwnBlog")
//         ],
//       ),
//     );
//   }

//   Widget head() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: CircleAvatar(
//               radius: 50,
//               //background image taken from backend 
//               backgroundImage: NetworkHandler().getImage(profileModel.username),
//             ),
//           ),
//           Text(
//             profileModel.username,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(profileModel.titleline)
          
//         ],
//       ),
//     );
//   }

//   Widget otherDetails(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             "$label :",
//             style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 10,),
//           Text(value,style: TextStyle(fontSize: 15),)
//         ],
//       ),
//     );
//   }
// }
