// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_new



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

import 'stats.dart';
import 'homepage.dart';
import 'login.dart';
import 'fantasy.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseApp app;

  try {
    app = await Firebase.initializeApp(
      name: 'crictascy',
      options: FirebaseOptions(
        appId: '1:529539665805:android:9d9c9bf7fe5ec4fc17f7c4',
        apiKey: 'AIzaSyCg_1TaOuJZbCEjLvG2JNs0ftUsCtOD-jU',
        databaseURL: 'https://console.firebase.google.com/u/0/project/crictasy-5a73d/firestore/data/~2F',
        projectId: 'crictasy-5a73d',
        messagingSenderId: '529539665805',
      ),
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      app = Firebase.app('crictascy');
    } else {
      throw e;
    }
  } catch (e) {
    rethrow; e;
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // Root Widget
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: Entering(),
    );
  }
}

class StartingPage extends StatefulWidget{
  @override
  _StartingPageState createState() => _StartingPageState();
}
class _StartingPageState extends State<StartingPage> {

  int currentIndex=0;

  @override
    Widget build(BuildContext context) {
      final List _children = [
        MyHomePage(),
        StatsHome(),
        FantasyHome(),
      ];

      return Scaffold(
        body:_children[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black,
          backgroundColor: Colors.red,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex=index),
          
          
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.assessment_outlined),
              title: new Text("Stats"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.people),
              title: new Text("Team"),
            ),
          ],
        ),
      );
  }
}