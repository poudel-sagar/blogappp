import 'package:blogappfour/NetworkHandler.dart';
import 'package:blogappfour/Profile/CreatProfile.dart';
import 'package:flutter/material.dart';
import 'MainProfile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //after tutorial 17
    checkProfile();
  }
  void checkProfile()async{
    var response = await networkHandler.get("/profile/checkprofile");
    if(response["status"]==true){
      setState(() {
//here
  // page= MainProfile();
      });
    }
    else{
      setState(() {
        page = button();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
    );
  }
//showing profile data if profile data is available in backend
  Widget showProfile(){
    return Center(child: Text("Profile data is available"));
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Tap to button to add profile data",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepOrange, fontSize: 18),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () =>{
             // Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatProfile()))
            } ,
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Add Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
//profile screen , main profile , profile model after fetch BlogCard, Blogs
