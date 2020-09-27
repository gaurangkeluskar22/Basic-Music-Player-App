import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/screens/Home.dart';
import 'package:music_player_app/screens/Upload.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  int currentindex = 0;

  List tabs = [
    Home(),
    Upload(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Music Player App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Music Player App"),
          ),
          body: tabs[currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentindex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload),
                title: Text("Upload"),
              )
            ],
            onTap: (index) {
              setState(() {
                currentindex = index;
              });
            },
          ),
        ));
  }
}
