//import 'package:http/http.dart' as http;
//import 'dart:html';
import 'package:blogappfour/Blog/addBlog.dart';
import 'package:blogappfour/Model/profileModel.dart';
import 'package:blogappfour/NetworkHandler.dart';
import 'package:blogappfour/Profile/MainProfile.dart';
import 'package:blogappfour/Screen/HomeScreen.dart';
import 'package:blogappfour/Profile/ProfileScreen.dart';
import 'package:blogappfour/pages/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), ProfileScreen()];
  List<String> titlestring = ["Home Page", "Profile Page"];
  //secure storage for log out
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  Widget profilephoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {
        profilephoto = CircleAvatar(
          radius: 50,
         // backgroundImage: NetworkHandler().getImage(response['username']),
        );
      });
    } else {
      setState(() {
        profilephoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    profilephoto,
                    SizedBox(height: 10),
                    Text("@$username"),
                  ],
                ),
              ),
              ListTile(
                title: Text("All post"),
                trailing: Icon(Icons.launch),
                onTap: () {},
              ),
              ListTile(
                title: Text("New Story"),
                trailing: Icon(Icons.add),
                onTap: () {},
              ),
              ListTile(
                title: Text("Settings"),
                trailing: Icon(Icons.settings),
                onTap: () {},
              ),
              ListTile(
                title: Text("Feedback"),
                trailing: Icon(Icons.feedback),
                onTap: () {},
              ),
              ListTile(
                title: Text("Log Out"),
                trailing: Icon(Icons.power_settings_new),
                onTap: logout,
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(titlestring[currentState]),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications), onPressed: () {})
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddBlog()));
          },
          child: Text(
            "+",
            style: TextStyle(fontSize: 35),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.teal,
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          child: Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    color: currentState == 0 ? Colors.white : Colors.white54,
                    onPressed: () {
                      setState(() {
                        currentState = 0;
                      });
                    },
                    iconSize: 35,
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    color: currentState == 1 ? Colors.white : Colors.white54,
                    onPressed: () {
                      setState(() {
                        currentState = 1;
                      });
                    },
                    iconSize: 35,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: widgets[currentState]);
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
